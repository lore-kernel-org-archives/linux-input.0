From: Alan Ott <alan@signal11.us>
Subject: Re: Help: Writing to USB feature port from within kernel driver
Date: Sun, 12 Sep 2010 22:41:46 -0400
Message-ID: <4C8D8F6A.8080406@signal11.us>
References: <7fcc69ce35dc284d573651e282337a69.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:34390 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309Ab0IMClp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Sep 2010 22:41:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 94E1C1CCAA6A
	for <linux-input@vger.kernel.org>; Sun, 12 Sep 2010 22:41:44 -0400 (EDT)
In-Reply-To: <7fcc69ce35dc284d573651e282337a69.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Marcel Holtmann <marcel@holtmann.org>, Antonio Ospite <ospite@studenti.unina.it>

On 09/12/2010 07:02 PM, simon@mungewell.org wrote:
> Hi Alan,
> I believe you submitted a patch a couple of months ago
> (https://patchwork.kernel.org/patch/105169/).
>    

It's not in the mainline. We are waiting on the bluetooth maintainer 
(Marcel Holtmann) to sign off on it.

> It looks like this hasn't been applied to 2.6 mainline yet, and I am
> having problems with trying to write a feature report to set up a device
> in it's driver...
>
>    

The gist of the patch is that it adds feature reports to user space, but 
this section of the patch:

@@ -807,7 +834,7 @@    static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
  	struct usb_host_interface *interface = intf->cur_altsetting;
  	int ret;

-	if (usbhid->urbout) {
+	if (usbhid->urbout&&  report_type != HID_FEATURE_REPORT) {

fixes the problem you are describing below, forcing FEATURE reports to 
go out on the control endpoint.

> ---------------------------- Original Message ----------------------------
> Subject: Help: Writing to USB feature port from within kernel driver
> From:    simon@mungewell.org
> Date:    Fri, September 10, 2010 3:23 pm
> To:      linux-usb@vger.kernel.org
> --------------------------------------------------------------------------
>
> Hi,
> I'm attempting to write to the feature port of a USB HID device during
> config, however this doesn't seem to be functioning the same as the python
> test code I have.
>    

What does this Python test code do and look like? Do you have some kind 
of Python wrapper around hiddev or libusb or something?

>  From looking at the USBMon output it looks like (although I'm not sure)
> that my kernel code is using an interrupt write ('Io') where as the
> 'working' python code is using a control write ('Co').
>
>    

This is a bug, as stated above. Feature reports are always to use the 
control endpoint.


I'll get a patch in which fixes this for .35 and .36. In the mean time, 
you can just send the report using usb_control_msg(). See 
drivers/hid/hid-sony.c for an example. Note that the part which says (3 
<< 8) is indicating a FEATURE report (feature = 3 on the USB bus, but 
the constant HID_FEATURE_REPORT in the kernel is 2. Don't get tripped up 
on that.). That example RECEIVES an input transfer, so you'll have to 
modify it slightly to SEND one.

Sorry for the bother. More of my broken code, it seems.

Alan.


