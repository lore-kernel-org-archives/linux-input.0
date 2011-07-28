From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 07/16] HID: wiimote: Parse accelerometer data
Date: Thu, 28 Jul 2011 20:51:37 +0200
Message-ID: <CANq1E4Q=XDWjq7gUss=Xe_TMNJPZOL81MM_LKCpy9c9j92hZVA@mail.gmail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
	<1311869316-17128-8-git-send-email-dh.herrmann@googlemail.com>
	<201107282012.25113.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54599 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab1G1Svi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:51:38 -0400
Received: by vws1 with SMTP id 1so2413061vws.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 11:51:38 -0700 (PDT)
In-Reply-To: <201107282012.25113.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

On Thu, Jul 28, 2011 at 8:12 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 28. Juli 2011, 18:08:27 schrieb David Herrmann:
>> +static void handler_accel(struct wiimote_data *wdata, const __u8 *p=
ayload)
>> +{
>> + =A0 =A0 =A0 __u16 x, y, z;
>> +
>> + =A0 =A0 =A0 if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* payload is: BB BB XX YY ZZ
>> + =A0 =A0 =A0 =A0* Buttons data contains LSBs
>> + =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 x =3D payload[2] << 2;
>> + =A0 =A0 =A0 y =3D payload[3] << 2;
>> + =A0 =A0 =A0 z =3D payload[4] << 2;
>> +
>> + =A0 =A0 =A0 x |=3D (payload[0] >> 5) & 0x3;
>> + =A0 =A0 =A0 y |=3D (payload[1] >> 4) & 0x2;
>> + =A0 =A0 =A0 z |=3D (payload[1] >> 5) & 0x2;
>
> Could you make the comments a bit clearer. Those last lines are impos=
sible
> to understand.

The LSBs are encoded in the "BB BB" data and I am extracting them. I
have documented the whole protocol in a separated document but if it
is common practice to add those comments to the code, I will add it in
the next version.

X, Y and Z data of accelerometer have 10 bits of precision. The data
is reported as 5 bytes:
BB BB XX YY ZZ
The first two bytes also contain the button data but there are 5
additional bits in the BB BB data that contain the LSBs of the
accelerometer.
XX YY ZZ are the upper 8 bits of the three accelerometer values.

BB BB have 8 bits. Bit 6 and 7 of first byte are LSBs of X value.
Bit 6 of second byte is LSB of Y value. Bit 7 of second byte is LSB of
Z value. The 10th bit of Y and Z are no available and set to 0.
As a table:

1st byte BB
Bit: 1 2 3 4 5 6 7 8
     ---------------
     B B B B B X X B

2nd byte BB
Bit: 1 2 3 4 5 6 7 8
     ---------------
     B B B B B Y Z B

B is button data and ignored here. handler_keys() takes care of them.

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver

Thanks for your review.
Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
