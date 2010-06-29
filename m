From: Amit Nagal <helloin.amit@gmail.com>
Subject: Report ID problem with HID-RAW interface usage
Date: Tue, 29 Jun 2010 16:40:59 +0530
Message-ID: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab0F2LK7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 07:10:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

Hi ,

i am trying to send a vendor specific HID report from a userspace host
program to vendor usb hid device
using HIDRAW interface .

the vendor specific report consist of < "Report ID " (0th position ) >
followed by <  "payload of data "  > .
when i send report in this format , i am not getting report response
from the usb device .

but when i send report in the format  < "Report ID "(0th byte ) >
<Report ID (1st byte )> < "data payload ">
i am getting perfect report response from usb device .

when i debugged kernel source code , i found the  function
usbhid_output_raw_report function defined in
drivers/hid/usbhid/hid-core.c
responsible for report transfer , where we use usb_control_msg as  :

ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
		HID_REQ_SET_REPORT,
		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
		cpu_to_le16(((HID_OUTPUT_REPORT + 1) << 8) | *buf),
		interface->desc.bInterfaceNumber, buf + 1, count - 1,
		USB_CTRL_SET_TIMEOUT);


As we can see above we are passing   " buf + 1 "  , " count - 1 "  to
data and size parameters of usb_control_msg()  function ,
which effectively means that if i make my report  format as <report id
>  < payload >
then in the  data parameter of usb_control_msg function , report id is
stripped off () .
and thats why i am not getting response with above report format .

report responses comes fine if  i  modify usb_control_msg usage as below :

ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
		HID_REQ_SET_REPORT,
		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
		cpu_to_le16(((HID_OUTPUT_REPORT + 1) << 8) | *buf),
		interface->desc.bInterfaceNumber, buf , count ,
		USB_CTRL_SET_TIMEOUT);

here i passed complete buf and count thereby passing < report id >
also in data params of usb_control_msg .

kindly provide insight and clarity regarding the < report id > ambiguity .


the original usbhid_output_raw_report()  function is  copied below for
reference .

static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf,
size_t count)
{
	struct usbhid_device *usbhid = hid->driver_data;
	struct usb_device *dev = hid_to_usb_dev(hid);
	struct usb_interface *intf = usbhid->intf;
	struct usb_host_interface *interface = intf->cur_altsetting;
	int ret;

	printk("=====>[IPOD HID ][Hid-core.c]%s\n" , __FUNCTION__);

	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
		HID_REQ_SET_REPORT,
		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
		cpu_to_le16(((HID_OUTPUT_REPORT + 1) << 8) | *buf),
		interface->desc.bInterfaceNumber, buf + 1, count - 1,
		USB_CTRL_SET_TIMEOUT);

	/* count also the report id */
	if (ret > 0)
		ret++;

	return ret;
}


Thanx & Regards
Amit Nagal
