From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: use generic driver for Logitech Unifying receivers
 if CONFIG_HID_LOGITECH_DJ=n
Date: Mon, 13 Feb 2012 10:31:26 +0100
Message-ID: <CAE7qMroBw6G5c-dWjwTneuLchwO=m9FdLaYLwajncbZU4VjE1w@mail.gmail.com>
References: <20120213080644.6105.54221.stgit@zurg> <CAE7qMrrubKoOSo+kwG9rpx6ac8U=6PQtHTDEh416NBBJNr8mGA@mail.gmail.com>
 <4F38D4BC.20708@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49126 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141Ab2BMJb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 04:31:57 -0500
In-Reply-To: <4F38D4BC.20708@openvz.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Mon, Feb 13, 2012 at 10:15 AM, Konstantin Khlebnikov
<khlebnikov@openvz.org> wrote:
> Nestor Lopez Casado wrote:
>>
>> Hi Konstantin,
>>
>> This was the original implementation
>> http://www.spinics.net/lists/linux-input/msg15225.html
>> Jiri suggested we removed the conditional compilation and we accepte=
d.
>>
>> Which are your reasons to add those conditionals back again?
>
>
> This device can work perfectly without special driver. It does not ad=
d
> any special advantage if there only one mouse and/or one keyboard dev=
ice.
> So, I don't see any reason for this strictly requirement of special d=
river.

I'm OK with that. It's Jiri's call.

Nevertheless, if you change that, please change the description on
Kconfig to reflect the fact that the receiver would work even without
the driver.

Nestor.

>
>
>>
>> Cheers,
>>
>> Nestor
>>
>> On Mon, Feb 13, 2012 at 9:06 AM, Konstantin Khlebnikov
>> <khlebnikov@openvz.org> =A0wrote:
>>>
>>> Before commit 534a7b8e1 "HID: Add full support for Logitech Unifyin=
g
>>> receivers"
>>> Logitech Unifying receiver can work as generic device without speci=
al
>>> driver,
>>> after that commit these devices does not works without special driv=
er.
>>>
>>> After this patch they will use generic driver if special driver is
>>> disabled.
>>>
>>> Signed-off-by: Konstantin Khlebnikov<khlebnikov@openvz.org>
>>> ---
>>> =A0drivers/hid/hid-core.c | =A0 =A02 ++
>>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> index af08ce7..3d7a174 100644
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -1462,8 +1462,10 @@ static const struct hid_device_id
>>> hid_have_special_driver[] =3D {
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_DFGT_WHEEL) },
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_G27_WHEEL) },
>>> +#if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER) },
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2) },
>>> +#endif
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_WII_WHEEL) },
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
>>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>>> USB_DEVICE_ID_SPACETRAVELLER) },
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
