From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] input: wacom: Use touch size for ABS_MT_TOUCH_MAJOR
Date: Thu, 15 Mar 2012 17:10:37 -0700
Message-ID: <CANRwn3SuZVQnfR9-+EUXyJ04RssWowUrZaMYNhYyNG9VYB42GA@mail.gmail.com>
References: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
	<CAGzDe_Z2Dpc9ue06V8mgc_fUUqSe0gJLwDK0piE156EsXV__7Q@mail.gmail.com>
	<CANRwn3SNnBAidf3wBuvSvO0EAyYPhhJXmBrv9Ly9f_HNiJkkPw@mail.gmail.com>
	<CAGzDe_bxoM81HOz2O3k7_bNvNO-V1Ro=fTGqGBRwwsNNtOYvAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38574 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161824Ab2CPAKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 20:10:39 -0400
Received: by wgbdr13 with SMTP id dr13so106710wgb.1
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 17:10:37 -0700 (PDT)
In-Reply-To: <CAGzDe_bxoM81HOz2O3k7_bNvNO-V1Ro=fTGqGBRwwsNNtOYvAQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Mar 12, 2012 at 3:41 PM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Fri, Mar 9, 2012 at 5:26 PM, Jason Gerecke <killertofu@gmail.com> =
wrote:
>> On Fri, Mar 9, 2012 at 2:30 PM, Chris Bagwell <chris@cnpbagwell.com>=
 wrote:
>>> On Wed, Mar 7, 2012 at 7:39 PM, Jason Gerecke <killertofu@gmail.com=
> wrote:
>>>> 3rd-gen Bamboo devices report both "amplitude" and "size" data
>>>> in their touch packets. This patch changes the source for
>>>> ABS_MT_TOUCH_MAJOR to be the latter rather than the former.
>>>> ---
>>>> =C2=A0drivers/input/tablet/wacom_wac.c | =C2=A0 =C2=A02 +-
>>>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tabl=
et/wacom_wac.c
>>>> index d0b0fc4..5daf11d 100644
>>>> --- a/drivers/input/tablet/wacom_wac.c
>>>> +++ b/drivers/input/tablet/wacom_wac.c
>>>> @@ -916,7 +916,7 @@ static void wacom_bpt3_touch_msg(struct wacom_=
wac *wacom, unsigned char *data)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (touch) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x =3D (=
data[2] << 4) | (data[4] >> 4);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int y =3D (=
data[3] << 4) | (data[4] & 0x0f);
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D data[=
6];
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D data[=
5];
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_repor=
t_abs(input, ABS_MT_POSITION_X, x);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_repor=
t_abs(input, ABS_MT_POSITION_Y, y);
>>>> --
>>>> 1.7.9.1
>>>>
>>>
>>> I found time to test this patch and used "mtview" so I could get so=
me
>>> visual feedback.
>>>
>>> The lines because extremely thin with this change. =C2=A0Part of re=
ason I
>>> quickly traced to we are setting range as 0-255 but I couldn't get
>>> data[5] to go above a value of 18. =C2=A0So I changed range to 0-16=
 and it
>>> works better but the lines still never gets very thick (this could
>>> well be that mtview doesn't scale values and prefers 0-255. =C2=A0I=
 didn't
>>> look).
>> Looks like its a combination of two problems, one mine one mtview's.=
=2E.
>>
>> I did some reading, and the MT protocol docs specify that
>> ABS_MT_TOUCH_MAJOR are in terms of surface units. That means a value
>> of e.g. "20" should represent a touch that spans 20 units of X. The
>> touch sensor has a resolution of ~0.1mm, which would imply the touch
>> was only 2 mm wide... There's going to have to be a correction facto=
r
>> to transform the value to something more appropriate.
>>
>> As for mtview, it looks like it doesn't scale the major/minor axis
>> values based on the output size. At the very least it should scale
>> everything by roughly (output_max_x / sensor_max_x) so that a touch
>> taking up e.g. 10% of the tablet would take up 10% of the output.
>
> I see now that I got lucky that I had a 0-255 value available and
> didn't look into what I needed to report close enough.
>
>>
>>>
>>> Amplitude feels better to me using test apps but your in a better
>>> position to say if we should really change this. =C2=A0Please adjus=
t
>>> declared range though if you still think we should change this.
>>>
>>> Chris
>>
>> My main reasons for switching away from amplitude were that amplitud=
e
>> is a very crude number (I think I can get three or four unique value=
s
>> out of it), and that the tablet reports a size already. Worst case -=
-
>> assuming a correction factor isn't sufficient to get data[5] working
>> as MAJOR -- we should at least send data[5] through PRESSURE (which
>> the MT docs state may be used instead of MAJOR/MINOR if the units ar=
e
>> arbitrary).
>>
>
> I've not found time to dig deeply to this (to compute real scale
> value) but I'll offer this. =C2=A0I compared behaviour of original da=
ta[6]
> to this:
>
> int w =3D (data[5] > 31) ? 255 : data[5] << 3;
>
> and with mtview the size change is much more responsive and
> consistent. =C2=A0So I'm on board with changing to data[5] in some fo=
rm.
>
> Chris

I did a little more testing, and it looks like data[5] is proportional
to the area (not linear dimension) of the touch. Given the intended
semantics (and ignoring the huge blobs it produces in mtview),
int_sqrt(data[5] << 13) seems to work well. We'd probably have to
increase the maximum to 512 or 1024 though since I've been able to get
my palm to produce values of ~600...

Also, I don't yet know how these values scale between tablet sizes --
I imagine smaller tablets produce larger values (since their sensors
are denser), but haven't been able to get my hands on other hardware
yet.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
