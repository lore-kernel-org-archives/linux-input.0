From: Andrew Haines <AndrewD207@aol.com>
Subject: [PATCH] ps3 controller clone
Date: Sun, 22 Dec 2013 18:26:42 -0500
Message-ID: <52B77532.3010606@aol.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030003080807080505070201"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from omr-d05.mx.aol.com ([205.188.109.202]:42090 "EHLO
	omr-d05.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab3LVXdY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Dec 2013 18:33:24 -0500
Received: from mtaout-mbb02.mx.aol.com (mtaout-mbb02.mx.aol.com [172.26.254.110])
	by omr-d05.mx.aol.com (Outbound Mail Relay) with ESMTP id 6BBDF700000B0
	for <linux-input@vger.kernel.org>; Sun, 22 Dec 2013 18:28:06 -0500 (EST)
Received: from [192.168.1.141] (cpe-74-78-128-139.twcny.res.rr.com [74.78.128.139])
	by mtaout-mbb02.mx.aol.com (MUA/Third Party Client Interface) with ESMTPA id 2C2C838000090
	for <linux-input@vger.kernel.org>; Sun, 22 Dec 2013 18:28:06 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030003080807080505070201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi this is my first kernel patch.

I have a ps3 controller clone that dmesg calls "Gasia Co.,Ltd PS(R) 
Gamepad." When I plugged it in it was recognized but did not send any 
output. After some searching I found 
http://www.spinics.net/lists/linux-input/msg18172.html and changed my 
kernel according to the patch on that email which didn't fix the 
problem. I installed wireshark and connected the controller to 
Windows(VirtualBox) and came up with the solution in the attached patch.

My controller needed the additional
hdev->hid_get_raw_report(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT)
and an interrupt set.

I tried to use the newer hdev->hid_output_raw_report rather than calling 
usb_interrupt_msg but I think usbhid->urbout is null in 
usbhid_output_raw_report since it gets sent as a SET_REPORT instead of 
URB_INTERRUPT out.

I did a little testing and running testrumble just after the controller 
is attached does initialize the controller so that the buttons send 
output. (Only with the additional hid_get_raw_report(hdev, 0xf5...)

I'm completely new to the kernel and have no idea how to allocate 
urbout. I did some searching but I'm not sure where to look.

Regards,

Andrew Haines

--------------030003080807080505070201
Content-Type: text/x-patch;
 name="sony-hid-clone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sony-hid-clone.patch"

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 098af2f8..c2bab2b 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -426,16 +426,46 @@ static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
  */
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *dev = interface_to_usbdev(intf);
+	//struct usbhid_device *usbhid = hdev->driver_data;
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	int transfered;	
+	char *buf = kmalloc(65, GFP_KERNEL);
+	unsigned char buf2[] = { 	
+		0x01, 
+		0x00, 0xff, 0x00, 0xff, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x1e, // led flags 1e = all
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32,
+		0x00, 0x00, 0x00, 0x00, 0x00
+	};
 
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hdev->hid_get_raw_report(hdev, 0xf2, buf, 17, HID_FEATURE_REPORT);
-
+		
 	if (ret < 0)
 		hid_err(hdev, "can't set operational mode\n");
+	else {
+		/* Some compatible controllers like the Speedlink Strike FX and
+		 * Gasia need a write to the Interrupt EP to get operational */		
+		hdev->hid_get_raw_report(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT); 
+
+		// doesn't work. gets sent as a SET_REPORT Request intstead of a
+		// URB_INTERRUPT out. I guess usbhid->urbout is null		 
+		//if ( hdev->hid_output_raw_report(hdev, buf2, sizeof(buf2), 
+		//					HID_OUTPUT_REPORT)  < 0 )
+		//	hid_err(hdev, "can't set initial interrupt. Cloned controllers may not operate\n");
+
+		if ( usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),   
+					buf2, sizeof(buf2),
+					&transfered, USB_CTRL_SET_TIMEOUT))
+			hid_err(hdev, "can't set initial interrupt. Cloned controllers may not operate\n");
+	}
 
 	kfree(buf);
 

--------------030003080807080505070201--
