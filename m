From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Fri, 8 May 2015 11:57:47 +0900
Message-ID: <554C262B.5090607@daenzer.net>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
 <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from darkcity.gna.ch ([195.226.6.51]:60145 "EHLO mail.gna.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751434AbbEHDHb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 23:07:31 -0400
in-reply-to: <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, John Horan <knasher@gmail.com>
Cc: linux-input@vger.kernel.org

On 04.05.2015 17:11, Jiri Kosina wrote:
> On Mon, 4 May 2015, Jiri Kosina wrote:
>=20
>> On Mon, 4 May 2015, Jiri Kosina wrote:
>>
>>> On Fri, 1 May 2015, John Horan wrote:
>>>
>>>> The quirk for swapping the grave and 102nd keys should be applied =
to the=20
>>>> APPLE_ALU_ISO keyboard, as they aren't actually swapped.
>>>>
>>>> Signed-off-by: John Horan <knasher@gmail.com>
>>>> ---
>>>>  drivers/hid/hid-apple.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
>>>> index f822fd2..e4bbfc0 100644
>>>> --- a/drivers/hid/hid-apple.c
>>>> +++ b/drivers/hid/hid-apple.c
>>>> @@ -441,7 +441,7 @@ static const struct hid_device_id apple_device=
s[] =3D {
>>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_AN=
SI),
>>>>  		.driver_data =3D APPLE_HAS_FN },
>>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_IS=
O),
>>>> -		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
>>>> +		.driver_data =3D APPLE_HAS_FN },
>>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JI=
S),
>>>>  		.driver_data =3D APPLE_HAS_FN },
>>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER=
4_HF_ANSI),
>>>
>>> Okay, this has been there since 2007, so one would guess there must=
 be a=20
>>> reason for noone complaining about this for past 8 years. I'd rathe=
r be=20
>>> careful here so that we don't introduce any regressions.
>>>
>>> Adding Michel, who added the original quirk back in 2007 (through c=
ommit=20
>>> a45d82d19a6 ("HID: Add support for Apple aluminum USB keyboards")) =
to CC.

With my ISO Apple Aluminum keyboard:

Bus 006 Device 021: ID 05ac:0221 Apple, Inc. Aluminum Keyboard (ISO)

writing 0 to /sys/module/hid_apple/parameters/iso_layout (which disable=
s
the APPLE_ISO_KEYBOARD quirk) results in the key right of the left shif=
t
key (labelled "`" and "~") producing the wrong characters. With the
quirk enabled, it produces "`" and "~" as expected.


John, please provide more information about the problem you're trying t=
o
solve with this patch.


>> Okay, the original e-mail address of Michel bounces, let's try a dif=
ferent=20
>> one :)
>=20
> Hmm, that bounced again. One last attempt ...

Third time's the charm. :)


--=20
Earthling Michel D=C3=A4nzer               |               http://www.a=
md.com
Libre software enthusiast             |             Mesa and X develope=
r

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
