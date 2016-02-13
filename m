From: "Simon Wood" <simon@mungewell.org>
Subject: Re: logitech HID driver is not probing
Date: Sat, 13 Feb 2016 12:30:10 -0700
Message-ID: <af1aa3beec094c30d4670eda62bcf2c3.squirrel@mungewell.org>
References: <CANOLnOMFQpULSw5Wt=v200peGSCoLNbVpVG5eYW-w6amxBL_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:36833 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbcBMTaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Feb 2016 14:30:11 -0500
In-Reply-To: <CANOLnOMFQpULSw5Wt=v200peGSCoLNbVpVG5eYW-w6amxBL_pQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

On Sat, February 13, 2016 11:58 am, Grazvydas Ignotas wrote:
> Hi,
>
>
> I have a gamepad [1] that requires quirks from hid-lg.c to work
> correctly. However for whatever reason the logitech driver is not probing
> and I'm getting hid-generic assigned to it instead. When I plug the device
> in, hid_logitech module is correctly autoloaded but it never probes
> (hid-generic does it instead).

It's listed as supported by 'hid-lg.c'
--
simon@retrobox:~/linux-git/drivers/hid$ grep
USB_DEVICE_ID_LOGITECH_DUAL_ACTION *.[ch]
hid-ids.h:#define USB_DEVICE_ID_LOGITECH_DUAL_ACTION	0xc216
hid-lg.c:	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_DUAL_ACTION),

--

but not included in hid-core as having a special driver
--
/*
 * A list of devices for which there is a specialized driver on HID bus.
 *
 * Please note that for multitouch devices (driven by hid-multitouch driver),
 * there is a proper autodetection and autoloading in place (based on
presence
 * of HID_DG_CONTACTID), so those devices don't need to be added to this
list,
 * as we are doing the right thing in hid_scan_usage().
 *
 * Autodetection for (USB) HID sensor hubs exists too. If a collection of
type
 * physical is found inside a usage page of type sensor, hid-sensor-hub
will be
 * used as a driver. See hid_scan_report().
 */
static const struct hid_device_id hid_have_special_driver[] = {
...
--

Perhaps that's something to do with confusion. Do you have the ability to
add and rebuild kernel to test?

Simon

