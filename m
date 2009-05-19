From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH  3/3] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 17:38:09 +0200
Message-ID: <5696FC49-3530-4D5B-B5B5-924973AD3120@enac.fr>
References: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr> <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:45385 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZESPiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 11:38:11 -0400
In-Reply-To: <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Rafi Rubin <rafi@seas.upenn.edu>




Le 19 mai 09 =E0 16:50, Jiri Kosina a =E9crit :


>> +	static __s32 x, y, id, w, h;
>> +	static char reading_a_point =3D 0, found_contact_id =3D 0;
>> +	struct input_dev *input =3D field->hidinput->input;
>
> Why are these variables static? This will break horribly if multiple
> devices are connected to the system, right?

You're right. But so far these devices are sold only as embedded in a =20
notebook, and I doubt we will see standalone devices in the near =20
future. Do you think it is worth planning ahead for this eventuality?

>
> Please use kernel-style comments (i.e. stars on each line).

Will do.

>
>> +	case 0xff000000:
>> +		/* we do not want to map these */
>
> Why?

Will add a couple of words.


>> +		default:
>> +                	hidinput_hid_event(hid, field, usage, value);
>
> Just return 1; here?
>
>> +		}
>> +	}
>> +        if (hid->claimed & HID_CLAIMED_HIDDEV && hid-=20
>> >hiddev_hid_event)
>> +                hid->hiddev_hid_event(hid, field, usage, value);
>> +
>> +	return 1;
>
> And return 0; here and let the HID core do all the rest (passing to
> hidinput and hiddev, etc) if necessary?

See my question in my other reply.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
