From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH v8] psmouse - focaltech pass finger width to userspace
Date: Fri, 24 Apr 2015 13:57:47 +0300
Message-ID: <553A21AB.7070304@gmail.com>
References: <1429830932-4501-1-git-send-email-hanipouspilot@gmail.com> <553A198D.8010103@gmail.com> <553A1E9E.8020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34793 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbbDXK5u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 06:57:50 -0400
In-Reply-To: <553A1E9E.8020502@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Gottschlag <mgottschlag@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I see that I did not change that here.

Width can be in state->width or fingers[finger]->width

I think latter is mere correct.It should be that way in this patch.
I moved ot back and forth and tested. Noticed no difference.

24.04.2015 13:44, Dmitry Tunin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>>
>> Hi,
>>
>> Some comments below. If it is not a problem that width values are
>> outdated as soon as there are two or more fingers on the touchpad, I
>> think the change is good.
>>
>> Regards,
>> Mathias
>>
>> Am 24.04.2015 um 01:15 schrieb Dmitry Tunin:
>>> Focaltech touchpads report finger width in packet[5] of absolute pa=
cket.
>>> Range for width in raw format is 0x10 - 0x70. Second half-byte is a=
lways 0.
>>> 0xff is reported, when a large contact area is detected.
>>> This can be handled in userspace.
>>>
>>> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
>>> ---
>>>  drivers/input/mouse/focaltech.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/=
focaltech.c
>>> index 23d2594..ea53f8b 100644
>>> --- a/drivers/input/mouse/focaltech.c
>>> +++ b/drivers/input/mouse/focaltech.c
>>> @@ -90,6 +90,13 @@ struct focaltech_finger_state {
>>>  	 */
>>>  	unsigned int x;
>>>  	unsigned int y;
>>> +
>>> +	/*
>>> +	* Finger width 0-7 and 15 for 'latching'
>> You already describe below that 15 is latched - what you write above
>> should probably rather be something like "15 if a very large contact
>> area was detected" or something like that.
>=20
> OK. No problem.
>>> +	* 15 value stays until the finger is released
>>> +	* Width is reported only in absolute packets
>>> +	*/
>>> +	unsigned int width;
>>>  };
>>> =20
>>>  /*
>>> @@ -112,7 +119,7 @@ struct focaltech_data {
>>>  	struct focaltech_hw_state state;
>>>  };
>>> =20
>>> -static void focaltech_report_state(struct psmouse *psmouse)
>>> +static void focaltech_report_state(struct psmouse *psmouse, bool a=
bs)
>>>  {
>>>  	struct focaltech_data *priv =3D psmouse->private;
>>>  	struct focaltech_hw_state *state =3D &priv->state;
>>> @@ -137,6 +144,7 @@ static void focaltech_report_state(struct psmou=
se *psmouse)
>>>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>>>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>>>  					 priv->y_max - clamped_y);
>>> +			if (abs) input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
>> You are sending width here for *all* fingers, even though only one
>> finger has an up-to-date width value. Is that intentional? I fail to=
 see
>> how that is different from always sending width no matter the packet
>> type, because in any case all but one fingers will have an outdated
>> width value.
>=20
> That is not true. Width is reported only in abs packets. So I report =
width for a specific=20
> finger. If multiple fingers are active, this data becomes outdated, w=
hen rel packets are processed.
> But we can do nothing with that. The only doubt I have, that we do no=
t need to store all that finger width in
> struct  focaltech_finger_state. It is overkill.
> The only reason for that is to process a situation, when there is one=
 'thin' touch and another 'palm' touch.
> Userspace driver may ignore the palm, but keep processing a finger. V=
arious userspace drivers can behave in a different way.
> But this is rare. I can move width *all* value to hw_state and forget=
 of each packets. Just report the last one.
> In practice it should not make much difference.
>=20
> I already committed this change to ppa with dkms driver, and it can b=
e tested by people.
>=20
>>>  		}
>>>  	}
>>>  	input_mt_report_pointer_emulation(dev, true);
>>> @@ -187,6 +195,7 @@ static void focaltech_process_abs_packet(struct=
 psmouse *psmouse,
>>> =20
>>>  	state->fingers[finger].x =3D ((packet[1] & 0xf) << 8) | packet[2]=
;
>>>  	state->fingers[finger].y =3D (packet[3] << 8) | packet[4];
>>> +	state->fingers[finger].width =3D packet[5] >> 4;
>>>  	state->fingers[finger].valid =3D true;
>>>  }
>>> =20
>>> @@ -228,14 +237,17 @@ static void focaltech_process_packet(struct p=
smouse *psmouse)
>>>  	switch (packet[0] & 0xf) {
>>>  	case FOC_TOUCH:
>>>  		focaltech_process_touch_packet(psmouse, packet);
>>> +		focaltech_report_state(psmouse, false);
>>>  		break;
>>> =20
>>>  	case FOC_ABS:
>>>  		focaltech_process_abs_packet(psmouse, packet);
>>> +		focaltech_report_state(psmouse, true);
>>>  		break;
>>> =20
>>>  	case FOC_REL:
>>>  		focaltech_process_rel_packet(psmouse, packet);
>>> +		focaltech_report_state(psmouse, false);
>>>  		break;
>>> =20
>>>  	default:
>>> @@ -243,7 +255,6 @@ static void focaltech_process_packet(struct psm=
ouse *psmouse)
>>>  		break;
>>>  	}
>>> =20
>> Remove that blank line as well? :)
>>> -	focaltech_report_state(psmouse);
>>>  }
>>> =20
>>>  static psmouse_ret_t focaltech_process_byte(struct psmouse *psmous=
e)
>>> @@ -331,6 +342,7 @@ static void focaltech_set_input_params(struct p=
smouse *psmouse)
>>>  	__set_bit(EV_ABS, dev->evbit);
>>>  	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0=
);
>>>  	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0=
);
>>> +	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
>>>  	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>>>  	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
>>>  }
>>
>=20
> Various mistakes in commits are because I have too many trees and ver=
sions. 3.16, 3.19 and two dkms, which are a bit different.
> I need to learn sorting that out.
>=20
> After someone of maintainers finds time to look at this, I will make =
a final version.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
