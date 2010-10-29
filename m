From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev4)
Date: Fri, 29 Oct 2010 13:45:38 -0700
Message-ID: <AANLkTikcEjnWghuJGAe-JiUu2n0vfmE3vh7SzUpqK2tP@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<1283607783-29388-5-git-send-email-rydberg@euromail.se>
	<AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
	<4CB5F8B3.6010504@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62743 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761950Ab0J2Upj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Oct 2010 16:45:39 -0400
Received: by ewy7 with SMTP id 7so2557251ewy.19
        for <linux-input@vger.kernel.org>; Fri, 29 Oct 2010 13:45:38 -0700 (PDT)
In-Reply-To: <4CB5F8B3.6010504@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Wed, Oct 13, 2010 at 11:21 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>
>>> +static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
>
>>> +{
>>> + =A0 =A0 =A0 static int trkid;
>>> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>>> + =A0 =A0 =A0 unsigned char *data =3D wacom->data;
>>> + =A0 =A0 =A0 int sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
>>> + =A0 =A0 =A0 int i;
>>> +
>>> + =A0 =A0 =A0 if (len !=3D WACOM_PKGLEN_BBTOUCH)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> + =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unalign=
ed_be16(&data[9 * i + 3]) & 0x7ff;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unalign=
ed_be16(&data[9 * i + 5]) & 0x7ff;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(inpu=
t, ABS_MT_PRESSURE, p);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(inpu=
t, ABS_MT_POSITION_X, x);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(inpu=
t, ABS_MT_POSITION_Y, y);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[i] < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom=
->id[i] =3D trkid++ & MAX_TRACKING_ID;
>>
>> Why do we need an arbitrary MAX_TRACKING_ID when the device can tell
>> us how many IDs we can have and it tracks the individual fingers for
>> us? In this case, there are only two ID/fingers and the ID can be
>> retrieved from the raw data. I must be missing something in the
>> defintion of MAX_TRACKING_ID.
>
> In the language of ABS_MT, there is a distinction between slot and id=
=2E The slot
> is the handle used to communicate a unique touch. The id is the ident=
ifier of
> that touch. The device tells us how many slots we have. The range of =
ids is in
> principle infinite. In practice, it is set to a large number.

Sorry to bring this topic back again. I was under the impression that
I was the only one who didn't get the spec clear. The discussion at
yesterday's UDS session made me feel I am not alone (good or bad :).
Let me try it again to see if I can get it right this time.

=46rom the "Multi-touch (MT) Protocol" under Documentation/input, we se=
e
the following:

"The slot protocol requires the use of the ABS_MT_TRACKING_ID, either
provided by the hardware or computed from the raw data".

That means if the hardware provides the tracking ID, we use it.
Otherwise we lose that specific information reported from the
hardware.

=46or the Bamboo case, the tracking ID happens to be the same as the
slot ID we use. But, there are devices, as far as I know, report up to
10 fingers/touches. So, there would be 10 slots to report the data.
But, the tracking ID we get from the devices is 0 to 255. So, slot 5
could have a tracking ID of 123 now and 9 when tuch 123 is up and
touch 5 is down.

> To answer a possible follow-up question: from the tracking id, you ca=
n tell if a
> contact is present, if it is new, and if it is older than another con=
tact.

The new and old attribute can be tracked by a time stamp in the
userland. Kernel driver doesn't need to worry about it. Maybe I am
missing an use case in the kernel?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
