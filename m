From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/2] HID: huion: enable button mode reporting
Date: Thu, 19 Feb 2015 13:37:24 +0200
Message-ID: <54E5CAF4.5070205@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com> <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com> <54E4656F.4070708@gmail.com> <20150218202447.GD5928@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:57667 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbBSLh2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 06:37:28 -0500
In-Reply-To: <20150218202447.GD5928@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/18/2015 10:24 PM, Benjamin Tissoires wrote:
> On Feb 18 2015 or thereabouts, Nikolai Kondrashov wrote:
>> On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
>>> diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
>>> index 61b68ca..50fbda4 100644
>>> --- a/drivers/hid/hid-huion.c
>>> +++ b/drivers/hid/hid-huion.c
>>> @@ -34,6 +34,9 @@ enum huion_ph_id {
>>>   	HUION_PH_ID_NUM
>>>   };
>>>
>>> +/* header of a button report sent through the Pen report */
>>> +static const u8 button_report[]  =3D {0x07, 0xa0, 0x01, 0x01};
>>
>> Hmm, I see the second byte being 0xe0 on Huion H610, the rest is the=
 same.
>> Considering this, the fact that bit 7 is always 1 and bit 6 is pen p=
roximity,
>> I think we can assume that bit 5 in byte 2 indicates button reports =
and get
>> away with just a "data[1] & 0x20" test.
>
> that would be a nicer approach. Thanks for the analysis.
> Actually, I understood the difference. I tested the bits _after_ the
> driver reverts the in-range bit :)

Ah, I missed that.

> The raw data is {0x07, 0xe0, 0x01, 0x01} on the H610 Pro too.

That's good, less weirdness to handle :)

>>>   /* Report descriptor template placeholder */
>>>   #define HUION_PH(_ID) HUION_PH_HEAD, HUION_PH_ID_##_ID
>>>
>>> @@ -81,6 +84,31 @@ static const __u8 huion_tablet_rdesc_template[] =
=3D {
>>>   	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER=
),  */
>>>   	0x81, 0x02,             /*          Input (Variable),           =
    */
>>>   	0xC0,                   /*      End Collection,                 =
    */
>>> +	0x05, 0x01,             /*      Usage Page (Desktop)             =
   */
>>> +	0x09, 0x07,             /*      Usage (Keypad)                   =
   */
>>> +	0xa1, 0x01,             /*      Collection (Application)         =
   */
>>> +	0x85, 0x08,             /*          Report ID (8)                =
   */
>>> +	0x05, 0x0d,             /*          Usage Page (Digitizers)      =
   */
>>> +	0x09, 0x22,             /*          Usage (Finger)               =
   */
>>
>> I'd say "Finger" usage is wrong here. The spec says:
>>
>>      Finger
>>
>>          CL =E2=80=93 Any human appendage used as a transducer, such=
 as a finger
>>          touching a touch screen to set the location of the screen c=
ursor.  A
>>          digitizer typically reports the coordinates of center of th=
e finger.
>>          In the Finger collection a Pointer physical collection will=
 contain
>>          the axes reported by the finger.
>>
>> I.e. the buttons are not a pointing device. The specification contai=
ns another
>> collection usage which seems more suitable:
>>
>>      Tablet Function Keys
>>
>>          CL =E2=80=93 These controls are located on the surface of a=
 digitizing tablet,
>>          and may be implemented as actual switches, or as soft keys =
actuated by
>>          the digitizing transducer. These are often used to trigger
>>          location-independent macros or other events.
>
> Actually, the kernel knows about it: HID_DG_TABLETFUNCTIONKEY.
> I don't think it should influence to have it set. The hid processing
> would work on the BTN usages, not on the physical.
>
> [5 min later]
>
> yep, just works :)

Cool :)!

>> However the kernel doesn't seem to know anything about it (but we ca=
n fix
>> that). In my version of this I simply used a keyboard with buttons:
>>
>>      0x05, 0x01,             /*  Usage Page (Desktop),              =
     */
>>      0x09, 0x06,             /*  Usage (Keyboard),                  =
     */
>>      0xA1, 0x01,             /*  Collection (Application),          =
     */
>>      0x85, 0xF7,             /*      Report ID (247),               =
     */
>>      0x05, 0x09,             /*      Usage Page (Button),           =
     */
>>      0x75, 0x01,             /*      Report Size (1),               =
     */
>>      0x95, 0x18,             /*      Report Count (24),             =
     */
>>      0x81, 0x03,             /*      Input (Constant, Variable),    =
     */
>>      0x19, 0x01,             /*      Usage Minimum (01h),           =
     */
>>      0x29, 0x08,             /*      Usage Maximum (08h),           =
     */
>>      0x95, 0x08,             /*      Report Count (8),              =
     */
>>      0x81, 0x02,             /*      Input (Variable),              =
     */
>>      0xC0                    /*  End Collection                     =
     */
>>
>> Although it might not be entirely correct either.
>
> Even if no-one but hid-core uses the report descriptor, I would rathe=
r
> not declare ourself as a keyboard. It's shooting on our own foot if
> someone decides to actually merge a keyboard and a tablet.

Yes, I think you're right.

>>> +	0xa0,                   /*          Collection (Physical)        =
   */
>>> +	0x14,                   /*              Logical Minimum (0)      =
   */
>>> +	0x25, 0x01,             /*              Logical Maximum (1)      =
   */
>>> +	0x75, 0x08,             /*              Report Size (8)          =
   */
>>> +	0x95, 0x03,             /*              Report Count (3)         =
   */
>>> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)     =
   */
>>> +	0x05, 0x09,             /*              Usage Page (Button)      =
   */
>>> +	0x19, 0x01,             /*              Usage Minimum (1)        =
   */
>>> +	0x29, 0x08,             /*              Usage Maximum (8)        =
   */
>>> +	0x14,                   /*              Logical Minimum (0)      =
   */
>>> +	0x25, 0x01,             /*              Logical Maximum (1)      =
   */
>>> +	0x75, 0x01,             /*              Report Size (1)          =
   */
>>> +	0x95, 0x08,             /*              Report Count (8)         =
   */
>>> +	0x81, 0x02,             /*              Input (Data,Var,Abs)     =
   */
>>> +	0x75, 0x08,             /*              Report Size (8)          =
   */
>>> +	0x95, 0x03,             /*              Report Count (3)         =
   */
>>> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)     =
   */
>>> +	0xc0,                   /*          End Collection               =
   */
>>> +	0xc0,                   /*      End Collection                   =
   */
>>
>> Which tool did you use to generate this?
>
> My own custom-made:
> https://github.com/bentiss/hid-replay/blob/master/tools/editor.py
>
> not 100% implemented, but it works for me :)

Ah, nice :) Here is mine: https://github.com/DIGImend/hidrd

>>>   	0xC0                    /*  End Collection                      =
    */
>>>   };
>>>
>>> @@ -205,6 +233,25 @@ static int huion_tablet_enable(struct hid_devi=
ce *hdev)
>>>   		}
>>>   	}
>>>
>>> +	/* switch to the button mode reporting */
>>> +	rc =3D usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
>>> +				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
>>> +				(USB_DT_STRING << 8) + 0x7b,
>>> +				0x0409, buf, len,
>>> +				USB_CTRL_GET_TIMEOUT);
>>
>> I'm a bit uncomfortable about reusing a buffer which was sized speci=
fically
>> for another task, as it's confusing. But it will work as is, so it's=
 OK.
>
> Yes, and no :)
>
> Actually, I would prefer that we stick to what the Windows driver do.
> But it requests 32 bytes in each requests, and we receive 14 and 22
> IIRC. The trick I exploited here is that the ctrl message answers bac=
k
> at most len data, so we are find in both cases because 12 is less tha=
n
> 14 and 22. I am not sure we should check at all the length of the
> returning buffer (though for the first command, we have to be sure th=
at
> we received enough to get the values in the buffer).

In that case, if we want to mimic the Windows driver we can request 32 =
bytes
always and do a compile-time check that our parameters fit into that.

> Side note: the huion-abstract-keyboard branch uses usb_string() inste=
ad
> of a plain usb_control_msg(). I like this much better and I think we
> should change the first call with that. This way, it will be clear th=
at
> the tablet is not fully HID compatible and that we need to keep the u=
sb
> access.

No, we can't do that to the parameters string, because usb_string() doe=
s
utf16s_to_utf8s on the received data.

>>> +		/* check for buttons events and change the report ID */
>>> +		if (size >=3D sizeof(button_report) &&
>>> +		    !memcmp(data, button_report, sizeof(button_report)))
>>
>> So, yes, I think it's better to have a "data[1] & 0x20" test here in=
stead.
>
> Yep, works just fine.

Nice :)

Nick
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
