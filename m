From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH] psmouse - focaltech report finger width to userspace
Date: Sat, 30 May 2015 08:53:03 +0300
Message-ID: <5569503F.60906@gmail.com>
References: <1432940459-19828-1-git-send-email-hanipouspilot@gmail.com> <20150529233734.GA20962@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33008 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517AbbE3FxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 May 2015 01:53:06 -0400
In-Reply-To: <20150529233734.GA20962@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>



30.05.2015 02:37, Dmitry Torokhov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sat, May 30, 2015 at 02:00:59AM +0300, Dmitry Tunin wrote:
>> Focaltech touchpads report finger width in packet[5] of absolute pac=
ket.
>> Range for width in raw format is 0x10 - 0x70. Second half-byte is al=
ways 0.
>> 0xff is reported, when a large contact area is detected.
>> This can be handled in userspace.
>>
>> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
>=20
> Let's add a few people...
>=20
>> ---
>>  drivers/input/mouse/focaltech.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/f=
ocaltech.c
>> index 23d2594..0c3b698 100644
>> --- a/drivers/input/mouse/focaltech.c
>> +++ b/drivers/input/mouse/focaltech.c
>> @@ -105,6 +105,16 @@ struct focaltech_hw_state {
>> =20
>>  	/* True if the clickpad has been pressed. */
>>  	bool pressed;
>> +
>> +	/*
>> +	* Finger width 0-7 and 15 for a very big contact area.
>> +	* 15 value stays until the finger is released.
>> +	* Width is reported only in absolute packets.
>> +	* Since hardware reports width only for last touching finger,
>> +	* there is no need to store width for every specific finger, so=20
>> +	* we keep only last value reported.
>> +	*/
>> +	unsigned int width;
>>  };
>> =20
>>  struct focaltech_data {
>> @@ -112,7 +122,7 @@ struct focaltech_data {
>>  	struct focaltech_hw_state state;
>>  };
>> =20
>> -static void focaltech_report_state(struct psmouse *psmouse)
>> +static void focaltech_report_state(struct psmouse *psmouse, bool ab=
s)
>>  {
>>  	struct focaltech_data *priv =3D psmouse->private;
>>  	struct focaltech_hw_state *state =3D &priv->state;
>> @@ -137,6 +147,7 @@ static void focaltech_report_state(struct psmous=
e *psmouse)
>>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>>  					 priv->y_max - clamped_y);
>> +			if (abs) input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
>=20
> I am not sure this condition and the change in focaltech_process_pack=
et
> are needed. The relative packets augment absolute one and we expect
> width not change so we can always report state->width (either updated=
 or
> cached) and input core will drop dupes.

That's what I started from. Just added a report line. But this confused=
 user space.
A touch packet reporting that a finger does not touch the pad together =
with width reported for same finger gets xorg-synaptics to ignore it.
E.g two-finger scrolling becomes unusable. xorg ignores "untouch" event=
 and when fingers touch again, cursor jumps.

So finally this solution looks clean and safe to report width only with=
 abs.

I sent some versions of these to linux-input mailing list and to Mathia=
s, but forgot to add Dmitry.

I added a similar patch to my ppa, with backport of focaltech driver fo=
r Ubuntu 3.19 kernel users. There are >500 installs.=20
No issues reported.


>=20
>>  		}
>>  	}
>>  	input_mt_report_pointer_emulation(dev, true);
>> @@ -187,6 +198,7 @@ static void focaltech_process_abs_packet(struct =
psmouse *psmouse,
>> =20
>>  	state->fingers[finger].x =3D ((packet[1] & 0xf) << 8) | packet[2];
>>  	state->fingers[finger].y =3D (packet[3] << 8) | packet[4];
>> +	state->width =3D packet[5] >> 4;
>>  	state->fingers[finger].valid =3D true;
>>  }
>> =20
>> @@ -228,22 +240,23 @@ static void focaltech_process_packet(struct ps=
mouse *psmouse)
>>  	switch (packet[0] & 0xf) {
>>  	case FOC_TOUCH:
>>  		focaltech_process_touch_packet(psmouse, packet);
>> +		focaltech_report_state(psmouse, false);
>>  		break;
>> =20
>>  	case FOC_ABS:
>>  		focaltech_process_abs_packet(psmouse, packet);
>> +		focaltech_report_state(psmouse, true);
>>  		break;
>> =20
>>  	case FOC_REL:
>>  		focaltech_process_rel_packet(psmouse, packet);
>> +		focaltech_report_state(psmouse, false);
>>  		break;
>> =20
>>  	default:
>>  		psmouse_err(psmouse, "Unknown packet type: %02x\n", packet[0]);
>>  		break;
>>  	}
>> -
>> -	focaltech_report_state(psmouse);
>>  }
>> =20
>>  static psmouse_ret_t focaltech_process_byte(struct psmouse *psmouse=
)
>> @@ -331,6 +344,7 @@ static void focaltech_set_input_params(struct ps=
mouse *psmouse)
>>  	__set_bit(EV_ABS, dev->evbit);
>>  	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0)=
;
>>  	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0)=
;
>> +	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
>>  	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>>  	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
>>  }
>> --=20
>> 1.9.1
>>
>=20
> Thanks.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
