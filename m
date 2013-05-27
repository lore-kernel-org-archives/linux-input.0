From: =?windows-1252?Q?Eisenberger_Tam=E1s?= <ufooka@gmail.com>
Subject: Re: [PATCH] Input: Add support for Fujitsu S762 laptops scroll wheel
Date: Mon, 27 May 2013 20:13:30 +0200
Message-ID: <51A3A24A.5060707@gmail.com>
References: <1367861750.11289.3.camel@u-foka-laptop.ethome2> <519BA0AA.7080002@gmail.com> <20130521185844.GA23365@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:43553 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab3E0SNd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 14:13:33 -0400
Received: by mail-we0-f178.google.com with SMTP id q56so4498157wes.23
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 11:13:32 -0700 (PDT)
In-Reply-To: <20130521185844.GA23365@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dimitry,

Thanks for your reply!

On 2013-05-21 20:58, Dmitry Torokhov wrote:
> Hi Tam=E1s,
>
> On Tue, May 21, 2013 at 06:28:26PM +0200, Eisenberger Tam=E1s wrote:
>> Hello,
>>
>> This were my first contribution, and I received no response at all :=
(
>> Am I done something wrong, no one else is interested in supporting
>> this particular piece of hardware or what?
>>
>> If anyone has a minute please review it.
>>
>
> Ah, yes, sorry...
>
>> Thanks:
>> Tam=E1s
>>
>> On 2013-05-06 19:35, Eisenberger Tam=E1s wrote:
>>> Detects and makes the Touch Scroll Wheel found on some Fujitsu lapt=
ops
>>> working.
>>>
>>> The detection is based on the (hopefully) unique E7 report of the w=
heel
>>> device.
>>> Up and down scrolling is detected by the only byte that has differe=
nt
>>> values in the devices packets, but it should be fine since it only =
able
>>> to report that two events.
>>>
>>> Signed-off-by: Tama's Eisenberger <tamas@eisenberger.hu>
>>> Index: linux/drivers/input/mouse/alps.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux.orig/drivers/input/mouse/alps.c
>>> +++ linux/drivers/input/mouse/alps.c
>>> @@ -410,6 +410,17 @@ static void alps_process_trackstick_pack
>>>   	if (packet[1] =3D=3D 0x7f && packet[2] =3D=3D 0x7f && packet[4] =
=3D=3D 0x7f)
>>>   		return;
>>>
>>> +	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
>>> +		if (packet[3] =3D=3D 0x4c)
>>> +			input_report_rel(dev, REL_WHEEL, 1);
>>> +
>>> +		if (packet[3] =3D=3D 0x58)
>>> +			input_report_rel(dev, REL_WHEEL, -1);
>
> Are these really the only values that emitted by the wheel? Have you
> tried spinning it vigorously to see if it produces different results?

I've tried to scroll really slow, and really fast with it, also tryed t=
o=20
move my finger diagonally and randomly but only that two were sent. Als=
o=20
events are really rare when not moving the finger around the edge.

>
>>> +
>>> +		input_sync(dev);
>>> +		return;
>
> Why are we ignoring the rest of the packet in this case? Does it cont=
ain
> invalid data?

Without my modifications the original driver reports middle button=20
events when I scroll upwards, so I have to return here to prevent this.=
=20
I don't think that this scroll well can co-exists with a trackstick.

>
>>> +	}
>>> +
>>>   	x =3D (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
>>>   	y =3D (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
>>>   	z =3D (packet[4] & 0x7c) >> 2;
>>> @@ -1255,6 +1266,7 @@ error:
>>>   static int alps_setup_trackstick_v3(struct psmouse *psmouse, int
>>> reg_base)
>>>   {
>>>   	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
>>> +	struct alps_data *priv =3D psmouse->private;
>>>   	int ret =3D 0;
>>>   	unsigned char param[4];
>>>
>>> @@ -1277,6 +1289,12 @@ static int alps_setup_trackstick_v3(stru
>>>   		psmouse_dbg(psmouse, "trackstick E7 report: %3ph\n", param);
>>>
>>>   		/*
>>> +		 * Detect fujitsu scroll wheel device
>>> +		 */
>>> +		if (param[0] =3D=3D 0x34 && param[1] =3D=3D 0x01 && param[2] =3D=
=3D 0x14)
>>> +			priv->quirks |=3D ALPS_QUIRK_SCROLL_WHEEL;
>>> +
>
> I believe this quirk should go into alps_model_data[] table.

I've tried to do that but it seems that the exact same (as my primary=20
touchpad) signature is already in the alps_model_data[] table (E7=3D73 =
02=20
64, EC=3D88 07 9d) and the secondary device seems to be independent. Th=
is=20
is why I'm trying to use the EC report of the secondary device but it=20
seemed to be overkill to create a new  model_data array for attached=20
devices or I don't know what could be the consequences to use the same=20
array also for secondary devices.

>
>>> +		/*
>>>   		 * Not sure what this does, but it is absolutely
>>>   		 * essential. Without it, the touchpad does not
>>>   		 * work at all and the trackstick just emits normal
>>> @@ -1798,12 +1816,16 @@ int alps_init(struct psmouse *psmouse)
>>>   	dev2->id.product =3D PSMOUSE_ALPS;
>>>   	dev2->id.version =3D 0x0000;
>>>   	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
>>> -
>>>   	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>>>   	dev2->relbit[BIT_WORD(REL_X)] =3D BIT_MASK(REL_X) | BIT_MASK(REL=
_Y);
>>>   	dev2->keybit[BIT_WORD(BTN_LEFT)] =3D
>>>   		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT)=
;
>>>
>>> +	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
>>> +		dev2->name =3D "DualPoint Scroll Wheel";
>
> I'd keep the name as is.

No prob. I'l remove the name change.

>
>>> +		dev2->relbit[BIT_WORD(REL_X)] |=3D BIT_MASK(REL_WHEEL);
>>> +	}
>>> +
>>>   	if (input_register_device(priv->dev2))
>>>   		goto init_fail;
>>>
>>> Index: linux/drivers/input/mouse/alps.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux.orig/drivers/input/mouse/alps.h
>>> +++ linux/drivers/input/mouse/alps.h
>>> @@ -158,6 +158,7 @@ struct alps_data {
>>>   };
>>>
>>>   #define ALPS_QUIRK_TRACKSTICK_BUTTONS	1 /* trakcstick buttons in
>>> trackstick packet */
>>> +#define ALPS_QUIRK_SCROLL_WHEEL		2 /* secondary device is scroll w=
heel
>>> */
>>>
>>>   #ifdef CONFIG_MOUSE_PS2_ALPS
>>>   int alps_detect(struct psmouse *psmouse, bool set_properties);
>>>
>
> BTW, your mailer line-wrapped the patch so it is not possible to appl=
y,
> when resending please make sure the long lines stay intact.

You're right, I=92ll try to use an other one.

>
> Thanks.
>

So basically as I see the main concern is the introduction of a new=20
quirk, but I don't know how to do this using the alps_model_data[] if=20
you have any suggestions please tell me!

Thanks:
Tam=E1s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
