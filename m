From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Add support for Cintiq Companion 2
Date: Mon, 12 Oct 2015 09:23:59 -0700
Message-ID: <561BDE9F.7070404@gmail.com>
References: <CADvPr_5M_o46S_Y1qnWSmJVgTVeNaBo77x5fPgYdQhyKYG_gNg@mail.gmail.com>
 <1444328918-3157-1-git-send-email-killertofu@gmail.com>
 <alpine.LNX.2.00.1510120059280.21100@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36380 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbbJLQYC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 12:24:02 -0400
Received: by pacex6 with SMTP id ex6so3969923pac.3
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2015 09:24:01 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1510120059280.21100@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Clifford Jolly <expiredpopsicle@gmail.com>

10/11/2015 4:02 PM, Jiri Kosina wrote:
> On Thu, 8 Oct 2015, Jason Gerecke wrote:
>=20
>> Adds support for the EMR (pen+pad) and touchscreen devices used by t=
he
>> Wacom Cintiq Companion 2. This applies both to using the device as a
>> standalone system, as well as when operating in "Cintiq mode" (where
>> the EMR/touchscreen are simply exposed as USB devices to the system
>> its connected to).
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>
> [ ... snip ... ]
>> @@ -2290,6 +2311,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
>>  	case WACOM_27QHD:
>>  	case DTK:
>>  	case CINTIQ_HYBRID:
>> +	case CINTIQ_COMPANION_2:
>>  		sync =3D wacom_intuos_irq(wacom_wac);
>>  		break;
>=20
> This doesn't make any sense. You break here out after handling=20
> CINTIQ_COMPANION_2 in features->type switch ...
>=20
>> =20
>> @@ -2543,6 +2565,7 @@ int wacom_setup_pen_input_capabilities(struct =
input_dev *input_dev,
>>  	case CINTIQ:
>>  	case WACOM_13HD:
>>  	case CINTIQ_HYBRID:
>> +	case CINTIQ_COMPANION_2:
>>  		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
>>  		input_abs_set_res(input_dev, ABS_Z, 287);
>>  		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>=20
> ... here you break out of the switch case a few lines below again.
>=20
>=20
>> @@ -2595,6 +2618,12 @@ int wacom_setup_pen_input_capabilities(struct=
 input_dev *input_dev,
>>  		__clear_bit(ABS_MISC, input_dev->absbit);
>>  		/* fall through */
>> =20
>> +	case CINTIQ_COMPANION_2:
>> +		for (i =3D 0; i < 10; i++)
>=20
> Where do you define this 'i'?
>=20
>> +			__set_bit(BTN_0 + i, input_dev->keybit);
>> +		__set_bit(BTN_A, input_dev->keybit);
>> +		break;
>> +
>=20
> And here you break out of the same case again explicitly again.
>=20

Looks like something went awry when migrating my patch from my branch i=
n
our local "input-wacom" tree to your upstream branch. Based on what's
wrong, it looks like `patch` may have been confused by Aaron's recent
changes to 'wacom_setup_pad_input_capabilities' (70ee06c) that weren't
integrated into my local branch.

I'll submit a fixed version shortly. Apologies for the noise.

Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
