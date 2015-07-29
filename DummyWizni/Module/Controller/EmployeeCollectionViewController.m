//
//  EmployeeCollectionViewController.m
//  DummyWizni
//
//  Created by arvind rawat on 27/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import "EmployeeCollectionViewController.h"
#import "PersonalInfoCollectionViewCell.h"
#import "AddressCollectionViewCell.h"
#import <CoreLocation/CoreLocation.h>

#import "Employee.h"
#import "Address.h"
#import "AppDelegate.h"
#import "MapViewController.h"
#import "ValidationRegex.h"

#import "LocationHandler.h"

@interface EmployeeCollectionViewController ()
{
    UITextField *activeField;
    Employee *newEmp;
    Address *newAddress;
    AppDelegate *appDlg;
    BOOL IsEdit;
    BOOL IsUpdating;
    
}
//Core Location
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
//Geocoding
@property (strong, nonatomic)   CLGeocoder *geocoder;
@property (strong, nonatomic)   CLPlacemark *placemark;
// ImagePicker
@property (strong, nonatomic)  UIImagePickerController  *picker;
- (IBAction)takePhoto:(id)sender;


@end

@implementation EmployeeCollectionViewController
@synthesize NewEmployeeBool;
@synthesize detailItem;

static NSString * const reuseIdentifierAddressCell = @"AddressCell";
static NSString * const reuseIdentifierPersonalInfo = @"PersonalInfoCell";


- (void)viewDidLoad {
    [super viewDidLoad];

    //keyboard Notification Observer
    
    
    LogTrace(@"%@",CApplicationName);
    
    appDlg= APP_DELEGATE;
    if (NewEmployeeBool) {
        IsEdit=YES;
    }else
    {
        newEmp=(Employee*) detailItem;
        NSArray *arr=[newEmp.employeeAddrress allObjects ];
        newAddress=(Address*)[arr objectAtIndex:0];
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        IsEdit=NO;
        
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    AddressCollectionViewCell *cellAddressInfo =(AddressCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if(editing) {
        // edit mode
        IsEdit=YES;
        IsUpdating =YES;
        [cellAddressInfo.useLocation setTitle:@"Use Current Location " forState:UIControlStateNormal];
        //[self.collectionView reloadData];
    }
    else
    {
        
        IsEdit=NO;
        IsUpdating =YES;
        [self addNewEmplyee:nil];
        if (IsUpdating)
        {
            [self.collectionView reloadData];
        }
        [cellAddressInfo.useLocation setTitle:@"Show On Map" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==0)
    {
        PersonalInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierPersonalInfo forIndexPath:indexPath];
        
        cell.firstName.text=newEmp.firstName;
        cell.lastName.text=newEmp.lastName;
        cell.emailId.text=newEmp.emailId;
        cell.mobileNumber.text=newEmp.phoneNumber;
        [cell.emplyeeImage setImage:[CommonUtilities getImageFromLocalDirectory:newEmp.phoneNumber] forState:UIControlStateNormal];
        cell.emplyeeImage.layer.masksToBounds = YES;
        cell.emplyeeImage.layer.cornerRadius = 10;
        
        cell.firstName.enabled=IsEdit;
        cell.lastName.enabled=IsEdit;
        cell.emailId.enabled=IsEdit;
        cell.mobileNumber.enabled=IsEdit;
        
        
        return cell;
    }
    else
    {
        
        AddressCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierAddressCell forIndexPath:indexPath];
        
       cell.streetName.text=newAddress.streetName;
       cell.cityName.text=newAddress.cityName;
       cell.CountryName.text=newAddress.country;
       cell.lattitude.text=newAddress.lattitude;
       cell.longitude.text=newAddress.longitude;
        
        cell.streetName.enabled=IsEdit;
        cell.cityName.enabled=IsEdit;
        cell.CountryName.enabled=IsEdit;
        cell.lattitude.enabled=IsEdit;
        cell.longitude.enabled=IsEdit;
        if(!NewEmployeeBool)
        {
            cell.saveButton.hidden=YES;
            [cell.useLocation setTitle:@"Show On Map " forState:UIControlStateNormal];
        }
        
        return cell;
        
    }
    return nil;
}


- (UIEdgeInsets)collectionView:(UICollectionView*) collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5); // top, left, bottom, right
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{    
    return 5.0;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize;
    switch (indexPath.section)
    {
        case 0:
        {
             cellSize = CGSizeMake(SCREEN_WIDTH, 360);
            break;
        }
        case 1:
        {
             cellSize = CGSizeMake(SCREEN_WIDTH, 350);
            break;
        
        }
    }//End of switch
    
    return cellSize;
}


#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */




#pragma  mark -- KEyboard Hide and show
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.collectionView.contentInset = contentInsets;
    self.collectionView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height =aRect.size.height - kbRect.size.height+50;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.collectionView scrollRectToVisible:activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.collectionView.contentInset = contentInsets;
    self.collectionView.scrollIndicatorInsets = contentInsets;
}

#pragma Mark --  uitextfeild methods
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


#pragma Mark -- Address by Current Location Delegate

-(IBAction)callCurrentLocation:(id)sender
{
    if (NewEmployeeBool||IsUpdating ){
        
        [[LocationHandler sharedLocationHandler] callCurrentLocation:^(id dict){
            
           NSMutableDictionary *dictionary =[NSMutableDictionary new];
            dictionary= (NSMutableDictionary *)dict;
            LogTrace(@"it is called");
         AddressCollectionViewCell *cell = (AddressCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.lattitude.text= [dictionary valueForKey:@"lattitude"];
        cell.longitude.text= [dictionary valueForKey:@"longitudeUser"];
        cell.streetName.text= [dictionary valueForKey:@"street"];
        cell.cityName.text= [dictionary valueForKey:@"city"];
        cell.CountryName.text= [dictionary valueForKey:@"country"];
            
        }];
       
    }
    else{
        [self performSegueWithIdentifier:SHOW_MAP_SEGUE sender:nil];
    }
}



//*************************

-(BOOL)validateAllData
{
    
    AddressCollectionViewCell *addressInfoCell = (AddressCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    PersonalInfoCollectionViewCell *personalInfoCell = (PersonalInfoCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //check for empty fields
    if (personalInfoCell.firstName.text.length == 0){
        [ValidationRegex showAlert:@"Error" message:@"Please Enter first Name"];
        return NO;
    }
    
    if (personalInfoCell.lastName.text.length == 0){
        [ValidationRegex showAlert:@"Error" message:@"Please Enter last Name"];
        return NO;
    }
    
    if (personalInfoCell.mobileNumber.text.length == 0){
        [ValidationRegex showAlert:@"Error" message:@"Please Enter mobile Number"];
        return NO;
    }
    
    
    if (![ValidationRegex validateMobileNumber:personalInfoCell.mobileNumber.text]) {
         [ValidationRegex showAlert:@"Error" message:@"Please Enter valid mobile Number"];
        return NO;
    }
    
    if (personalInfoCell.emailId.text.length == 0){
        [ValidationRegex showAlert:@"Error" message:@"Please Enter email ID"];
        return NO;
    }
    if (![ValidationRegex validateEmailWithString:personalInfoCell.emailId.text]) {
        [ValidationRegex showAlert:@"Error" message:@"Please Enter valid email Id"];
        return NO;
    }
    return YES;
}





- (IBAction)addNewEmplyee:(id)sender {
    if (![self validateAllData]) {
        if (!NewEmployeeBool) {
         [self setEditing:YES animated:NO ];
        }
        return;
    };
    
    
    if (NewEmployeeBool) {
        newEmp = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Employee"
                  inManagedObjectContext:appDlg.managedObjectContext];
        newAddress = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Address"
                      inManagedObjectContext:appDlg.managedObjectContext];
        
    }
    
    /************************************************
     *
     *          Set Addresssnd from the Address cell
     *
     *************************************************/
    
    // Setting Data from Personal Info cell
    PersonalInfoCollectionViewCell *cell =(PersonalInfoCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [newEmp setFirstName:cell.firstName.text];
    [newEmp setLastName:cell.lastName.text];
    [newEmp setPhoneNumber:cell.mobileNumber.text];
    [newEmp setEmailId:cell.emailId.text];
    
    /************************************************
     *
     *          Set Addresssnd from the Address cell
     *
     *************************************************/
    AddressCollectionViewCell *addressCell =(AddressCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [newAddress setStreetName:addressCell.streetName.text];
    [newAddress setCityName:addressCell.cityName.text];
    [newAddress setCountry:addressCell.CountryName.text];
    [newAddress setLattitude:addressCell.lattitude.text];
    [newAddress setLongitude:addressCell.longitude.text];
    
    /************************************************
     *
     *          Setting Up relationShips
     *
     *************************************************/
    [newAddress addAddressOfEmployeeObject:newEmp];
    [newEmp addEmployeeAddrressObject:newAddress];
    
    NSError *error = nil;
    if (![appDlg.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //Saving Photo With Moline Number
    [CommonUtilities saveImageToDocument:cell.mobileNumber.text  image:cell.emplyeeImage.currentImage];
    
    if (IsUpdating) {
        IsUpdating=NO;
    }
    
    [self.navigationController popViewControllerAnimated:YES   ];
    
    
    
}

#pragma Mark ---- Photo Picker /Update

- (IBAction)takePhoto:(id)sender {
    
    if (!IsEdit) {
        return;
    }
    
    NSString *fromCameraButtonTitle =  @"From Camera";
    NSString *fromGalleryButtonTitle = @"From Gallery";
    NSString *destructiveButtonTitle = NSLocalizedString(@"Cancel", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *pickFromCameraAction = [UIAlertAction actionWithTitle:fromCameraButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self pickFromCamera];
    }];
    
    UIAlertAction *pickFromGalleryAction = [UIAlertAction actionWithTitle:fromGalleryButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // call from gallerry
        [self pickFromGallery];
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Hide.");
    }];
    
    // Add the actions.
    [alertController addAction:pickFromCameraAction];
    [alertController addAction:pickFromGalleryAction];
    [alertController addAction:destructiveAction];
    
    // Configure the alert controller's popover presentation controller if it has one.
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        //UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:selectedPath];
        // popoverPresentationController.sourceRect = selectedCell.frame;
        popoverPresentationController.sourceView = self.view;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)pickFromCamera
{
    _picker = [[UIImagePickerController alloc] init];
    
    _picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:_picker animated:YES completion:nil];
}
-(void)pickFromGallery
{
    if (_picker==nil) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
    }
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

#pragma Mark -- UIImage Picker Methods delegate methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    PersonalInfoCollectionViewCell *cell =(PersonalInfoCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UIImage *img=[info objectForKey:UIImagePickerControllerOriginalImage];
    [cell.emplyeeImage setImage:img forState:UIControlStateNormal];
    [_picker  dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Segues- Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:SHOW_MAP_SEGUE]) {
       // CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28.428051, 77.109683);
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([newAddress.lattitude floatValue],[newAddress.longitude floatValue] );
        
        MapViewController  *destination = segue.destinationViewController;
        [destination setCoordinate:coordinate];
    }
    
}

@end

