From: pancho horrillo <pancho@pancho.name>
Subject: [PATCH] HID: usbhid: quirk for NEC Corp. PA302W monitor
Date: Mon, 18 Aug 2014 00:35:40 +0200
Message-ID: <20140817223540.GA13561@potito.inittab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from potito.inittab.org ([5.199.142.158]:57016 "EHLO
	potito.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaHQWm7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Aug 2014 18:42:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This device has an odd HID entry and causes a 10 second delay in boot.
Add this device to the quirks list with HID_QUIRK_NO_INIT_REPORTS.

[EDIT OUT THE FOLLOWING AS NEEDED IF EXPLANATION IS TOO MUCH, THIS LINE INCL.]

dmesg shows the 10 second delay, which hinders normal operation
(e.g., using the keyboard):

  [ +10.098394] hid-generic 0003:0409:042F.005A: timeout initializing reports

Passing this arg to the kernel fixes the issue:

  usbhid.quirks=0x0409:0x042f:0x20000000

This patch expresses precisely the above quirk.

See https://bugzilla.redhat.com/attachment.cgi?id=710695 for a similar case.

For reference, here is the output of 'lsusb -v -d 0409:042f':

Bus 002 Device 003: ID 0409:042f NEC Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0409 NEC Corp.
  idProduct          0x042f
  bcdDevice            0.01
  iManufacturer           1 NEC
  iProduct                2 PA302W
  iSerial                 3 3X100603TW
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      39
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
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered

Signed-off-by: pancho horrillo <pancho@pancho.name>
---
 drivers/hid/hid-ids.h           | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25cd674..d636c37 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -665,6 +665,9 @@
 #define USB_VENDOR_ID_NEC		0x073e
 #define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
 
+#define USB_VENDOR_ID_NEC_CORP		0x0409
+#define USB_DEVICE_ID_NEC_CORP_PA302W	0x042f
+
 #define USB_VENDOR_ID_NEXIO		0x1870
 #define USB_DEVICE_ID_NEXIO_MULTITOUCH_420	0x010d
 #define USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750	0x0110
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 15225f3..34c1bc9 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -41,6 +41,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NATSU, USB_DEVICE_ID_NATSU_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_NEC_CORP, USB_DEVICE_ID_NEC_CORP_PA302W, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXTWINDOW, USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN, HID_QUIRK_MULTI_INPUT},
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
-- 
2.0.4

-- 
pancho horrillo

To be conscious that
you are ignorant is a great step
to knowledge.

		Benjamin Disraeli
