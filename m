From: Matteo Croce <technoboy85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Western Digital HDD Leds
Date: Tue, 23 Dec 2008 01:19:09 +0100
Message-ID: <200812230119.10231.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,
I have a Western Digital usb HDD, it has some nice LEDs to show the disk
usage, but sadly they works only with Windows.
This is the syslog:

usb 1-1: new high speed USB device using ehci_hcd and address 3
usb 1-1: configuration #1 chosen from 1 choice
input: Western Digital  External HDD     as /devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1:1.1/input/input7
generic-usb 0003:1058:0705.0002: input,hidraw0: USB HID v1.10 Device [Western Digital  External HDD    ] on usb-0000:00:1d.7-1/input1
Initializing USB Mass Storage driver...
scsi3 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
scsi 3:0:0:0: Direct-Access     WD       3200BEV External 1.75 PQ: 0 ANSI: 4
sd 3:0:0:0: [sdb] 625142448 512-byte hardware sectors: (320 GB/298 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 23 00 00 00
sd 3:0:0:0: [sdb] Assuming drive cache: write through
sd 3:0:0:0: [sdb] 625142448 512-byte hardware sectors: (320 GB/298 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 23 00 00 00
sd 3:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete

so it seems that the LEDs are an USB HID device, and udev creates /dev/hidraw0
lsusb -n says:

Bus 001 Device 003: ID 1058:0705 Western Digital Technologies, Inc. 
Device Descriptor:                                                  
  bLength                18                                         
  bDescriptorType         1                                         
  bcdUSB               2.00                                         
  bDeviceClass            0 (Defined at Interface level)            
  bDeviceSubClass         0                                         
  bDeviceProtocol         0                                         
  bMaxPacketSize0        64                                         
  idVendor           0x1058 Western Digital Technologies, Inc.      
  idProduct          0x0705                                         
  bcdDevice            1.75                                         
  iManufacturer           1 Western Digital                         
  iProduct                2 External HDD                            
  iSerial                 3 57442D575848393038343538303037          
  bNumConfigurations      1                                         
  Configuration Descriptor:                                         
    bLength                 9                                       
    bDescriptorType         2                                       
    wTotalLength           57                                       
    bNumInterfaces          2                                       
    bConfigurationValue     1                                       
    iConfiguration          0                                       
    bmAttributes         0xc0                                       
      Self Powered                                                  
    MaxPower                2mA                                     
    Interface Descriptor:                                           
      bLength                 9                                     
      bDescriptorType         4                                     
      bInterfaceNumber        0                                     
      bAlternateSetting       0                                     
      bNumEndpoints           2                                     
      bInterfaceClass         8 Mass Storage                        
      bInterfaceSubClass      6 SCSI                                
      bInterfaceProtocol     80 Bulk (Zip)                          
      iInterface              0                                     
      Endpoint Descriptor:                                          
        bLength                 7                                   
        bDescriptorType         5                                   
        bEndpointAddress     0x81  EP 1 IN                          
        bmAttributes            2                                   
          Transfer Type            Bulk                             
          Synch Type               None                             
          Usage Type               Data                             
        wMaxPacketSize     0x0200  1x 512 bytes                     
        bInterval               0                                   
      Endpoint Descriptor:                                          
        bLength                 7                                   
        bDescriptorType         5                                   
        bEndpointAddress     0x02  EP 2 OUT                         
        bmAttributes            2                                   
          Transfer Type            Bulk                             
          Synch Type               None                             
          Usage Type               Data                             
        wMaxPacketSize     0x0200  1x 512 bytes                     
        bInterval               0                                   
    Interface Descriptor:                                           
      bLength                 9                                     
      bDescriptorType         4                                     
      bInterfaceNumber        1                                     
      bAlternateSetting       0                                     
      bNumEndpoints           1                                     
      bInterfaceClass         3 Human Interface Device              
      bInterfaceSubClass      0 No Subclass                         
      bInterfaceProtocol      0 None                                
      iInterface              5 WD HID INTERFACE                    
        HID Device Descriptor:                                      
          bLength                 9                                 
          bDescriptorType        33                                 
          bcdHID               1.10                                 
          bCountryCode            0 Not supported                   
          bNumDescriptors         1                                 
          bDescriptorType        34 Report                          
          wDescriptorLength      33                                 
         Report Descriptors:                                        
           ** UNAVAILABLE **                                        
      Endpoint Descriptor:                                          
        bLength                 7                                   
        bDescriptorType         5                                   
        bEndpointAddress     0x83  EP 3 IN                          
        bmAttributes            3                                   
          Transfer Type            Interrupt                        
          Synch Type               None                             
          Usage Type               Data                             
        wMaxPacketSize     0x0040  1x 64 bytes                      
        bInterval               6                                   
Device Qualifier (for other device speed):                          
  bLength                10                                         
  bDescriptorType         6                                         
  bcdUSB               2.00                                         
  bDeviceClass            0 (Defined at Interface level)            
  bDeviceSubClass         0                                         
  bDeviceProtocol         0                                         
  bMaxPacketSize0        64                                         
  bNumConfigurations      1                                         
Device Status:     0x0001                                           
  Self Powered

note the lines:
      bInterfaceClass         8 Mass Storage
      bInterfaceClass         3 Human Interface Device

My question now is: how can we make the LEDs configurable by Linux?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
