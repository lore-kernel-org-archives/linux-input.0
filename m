From: Michael Friedl <linux-p+Ff8IiBl0E@public.gmane.org>
Subject: duplicate usb device ids
Date: Wed, 11 Feb 2009 21:25:18 +0100
Message-ID: <4993342E.4050008@nicce.at>
Reply-To: linux-p+Ff8IiBl0E@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

I got a new CCD 800B barcode scanner, but it has the same device id like
an other product from Tenx, which is on the ignore list for hid devices.

Found nothing about the old product so I report it here.
If the old one get removed from the ignore list the bardcode scanner
works perfect!

Im not sure how to handle duplicate ids..

Current state (2.6.29-rc4):

drivers/hid/hid-core.c:
line 1481: static const struct hid_device_id hid_ignore_list[] = {
line 1613: { HID_USB_DEVICE(USB_VENDOR_ID_TENX,
USB_DEVICE_ID_TENX_IBUDDY1) },
line 1614: { HID_USB_DEVICE(USB_VENDOR_ID_TENX,
USB_DEVICE_ID_TENX_IBUDDY2) },

drivers/hid/hid-ids.h:
#define USB_VENDOR_ID_TENX              0x1130
#define USB_DEVICE_ID_TENX_IBUDDY1      0x0001
#define USB_DEVICE_ID_TENX_IBUDDY2      0x0002



My CCD 800B barcode scanner (Vendor 0x1130, Device 0x0001 )
lsusb -v -s 005:002:

Bus 005 Device 002: ID 1130:0001 Tenx Technology, Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x1130 Tenx Technology, Inc.
   idProduct          0x0001
   bcdDevice            1.00
   iManufacturer           0
   iProduct                2 USB-TMU-V3
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           34
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      1 Keyboard
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0 Not supported
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      78
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0008  1x 8 bytes
         bInterval              10
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled




Sorry Im not sure if HID belongs to usb or input section.


thanks!
Michael Friedl




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
