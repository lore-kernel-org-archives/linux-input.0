From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Tue, 17 Feb 2015 18:01:43 -0800
Message-ID: <54E3F287.3040900@synaptics.com>
References: <54C85FB5.9050404@simon-woerner.de> <1422492195-11492-1-git-send-email-linux@simon-woerner.de> <alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:24542 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbbBRCEb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 21:04:31 -0500
In-Reply-To: <alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux@simon-woerner.de
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?B?U2ltb24gV8O2?= =?UTF-8?B?cm5lcg==?= <mail@simon-woerner.de>

On 02/17/2015 04:30 AM, Jiri Kosina wrote:
> On Thu, 29 Jan 2015, linux@simon-woerner.de wrote:
>
>> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>>
>> HID: Add driver for acer keybard with broken rdesc
> Hi Simon,
>
> to make sure proper device <-> driver binding is performed, you also =
have
> to add device ID to the hid_have_special_driver[] array.
>
I have been meaning to respond to this patch. Unfortunately, simply=20
adding this driver to the hid_have_special_driver[] list will prevent=20
hid-multitouch from binding to the touchpad which shares the same vid=20
and pid. My suggestion would be to create a new scan_flag for=20
GD_KEYBOARD and to add to the code in hid_scan_collection() which scans=
=20
the GENDESK usages. Similar to the code which is searching for=20
HID_GD_POINTER. Then in hid_scan_report() we could assign a group for=20
this driver based on the pid and the GD_KEYBOARD scan flag in the vendo=
r=20
handling code.

I can help out with implementing this part of the patch if there aren't=
=20
any other suggestions. Adding a new group and more code to the=20
hid_scan_report() vendor handling code is definately not ideal. But, I=20
am not sure of a better way of binding different sub drivers to devices=
=20
with the same vid and pid.

An alternative would be to have hid-rmi handle all Synaptics touchpads,=
=20
even the ones which currently use hid-multitouch. Then the keyboard=20
report descriptor fixup could just be handled in hid-rmi. Accessing the=
=20
finger data via rmi mode would also have the benefit of being able to=20
report events which are currently not supported by the PTP collection=20
(ie ABS_MT_PRESSURE, ABS_MT_TOUCH_MAJOR/MINOR). The touchpads which=20
currently use hid-multitouch report finger data a little differently=20
then the ones currently using hid-rmi so there is some work which would=
=20
need to be done to add support for them in hid-rmi.

Andrew
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
