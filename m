From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH v3 1/2] hid: Blacklist new eBeam classic device
Date: Tue, 07 Aug 2012 03:21:45 +0200
Message-ID: <50206DA9.1070503@laposte.net>
References: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net> <1344288104-20731-2-git-send-email-yann.cantin@laposte.net> <20120806214340.GA30355@kroah.com> <1975621.3ErbANJ9at@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:46257 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143Ab2HGBVH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 21:21:07 -0400
In-Reply-To: <1975621.3ErbANJ9at@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Le 07/08/2012 00:07, Dmitry Torokhov a =E9crit :
> On Monday, August 06, 2012 02:43:40 PM Greg KH wrote:
>> On Mon, Aug 06, 2012 at 11:21:43PM +0200, Yann Cantin wrote:
>>> Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
>>> ---
>>>
>>>  drivers/hid/hid-core.c |    3 +++
>>>  drivers/hid/hid-ids.h  |    3 +++
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> index 60ea284..b1ed8ee 100644
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -1908,6 +1908,9 @@ static const struct hid_device_id hid_ignore_=
list[]
>>> =3D {>=20
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_=
LT20)
>>>  	},
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
>>>
>>> +#if defined(CONFIG_INPUT_EBEAM_USB)
>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_CLASSIC) },
>>> +#endif
>>
>> Why is this #if in here?  Just always do it, how could it not be
>> defined?
>=20
> User might disable the driver and CONFIG_INPUT_EBEAM_USB will not be
> set. But I agree, since the device is unusable with generic HID drive=
r
> there is no point in doing this conditionally.

There's a closed-source user-space stack (libusb based daemon + xorg dr=
iver
+ wine apps) provided for some distro (Ubuntu 10.04, works on mandriva =
2010,
maybe others but break on recent xorg).

I don't know exactly what to do : i don't want to break hypothetical su=
pport,
even proprietary.
Leaving the choice at kernel compile time seems to be safer, no ?

--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
