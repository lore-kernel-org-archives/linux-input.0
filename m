From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH] input: wacom: Use touch size for ABS_MT_TOUCH_MAJOR
Date: Thu, 10 May 2012 22:38:02 -0700
Message-ID: <CAMu+ixj_jd61RXRLE_F1e8gHpELnhmsJ7WjjfNK8NCj23tbnuw@mail.gmail.com>
References: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
 <CAGzDe_Z2Dpc9ue06V8mgc_fUUqSe0gJLwDK0piE156EsXV__7Q@mail.gmail.com>
 <CANRwn3SNnBAidf3wBuvSvO0EAyYPhhJXmBrv9Ly9f_HNiJkkPw@mail.gmail.com>
 <CAGzDe_bxoM81HOz2O3k7_bNvNO-V1Ro=fTGqGBRwwsNNtOYvAQ@mail.gmail.com>
 <CANRwn3SuZVQnfR9-+EUXyJ04RssWowUrZaMYNhYyNG9VYB42GA@mail.gmail.com>
 <CAGzDe_aD8SZtDGP2w4NWy0mCepLqUZaVOY55-9CSQqoy_MP=Bw@mail.gmail.com>
 <CANRwn3Qexa3yKs+fsv+CQ_LYrg2Ksj5zskSUwjn-RR9xBP4fSA@mail.gmail.com> <CAMu+ixhk+_xZ8Zqn7wj1VOq=C48RCWzh_Vw3-Wrv-=GqOBr7Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57485 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab2EKFin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 01:38:43 -0400
Received: by obbtb18 with SMTP id tb18so2791230obb.19
        for <linux-input@vger.kernel.org>; Thu, 10 May 2012 22:38:42 -0700 (PDT)
In-Reply-To: <CAMu+ixhk+_xZ8Zqn7wj1VOq=C48RCWzh_Vw3-Wrv-=GqOBr7Hw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

Resending to list.

On Thu, May 10, 2012 at 10:32 PM, Jeffrey Brown <jeffbrown@android.com>=
 wrote:
> I have tackled this problem in Android and it's a real nuisance.=A0 A=
s far as
> I can tell, the vast majority of drivers don't use ABS_MT_TOUCH_MAJOR=
 /
> MINOR or ABT_MT_WIDTH_MAJOR / MINOR correctly.
>
> The drivers should be applying a transformation to the hardware repor=
ted
> 'width' or 'area' measurements so that they can be reported up to use=
r space
> in terms of surface units.
>
> There are two common transformations that may need to be applied.
>
> 1. Width values typically need linear scaling sometimes with a bias
> constant.=A0 eg. out =3D width * scale + bias.=A0 The scale adapts li=
near width
> measurements to surface units.=A0 The bias is typically zero but some=
 devices
> have a measurement floor.
>
> 2. Area values typically need inverse quadratic scaling.=A0 Taking th=
e
> assumption that the contact is circular, obtain a nominal width (diam=
eter)
> using the square root.=A0 Thus we have the relation: out =3D sqrt(are=
a) * scale
> + bias.
>
> It is easy to determine which of the two schemes to apply by observin=
g the
> relation between reported width or area (in unknown device specific u=
nits,
> possibly sensor cell sizes) versus physical size (in millimeters).=A0=
 When
> plotted, look for the linear or quadratic relation and choose accordi=
ngly.
>
> (I have yet to find a touch controller that uses the same units to re=
port
> size as it uses for position.)
>
> I often use coins as benchmark test objects of known size.=A0 Dimes, =
nickels,
> quarters, dollars...=A0 (I wish I had some standard probes of various=
 sizes.).
> It is a good idea to get a range of objects of different sizes, parti=
cularly
> in the 6-16mm range.
>
> Special considerations:
>
> 1. Some devices do not report the individual size of each contact
> correctly.=A0 They may report a value that is a sum of the total area
> covered.=A0 A simple expedient is to divide the raw reported width or=
 area by
> the number of contacts for these devices.
>
> 2. Size measurement is by necessity an approximation.=A0 Laying a fin=
ger flat
> may distribute the contact area over an elongated region.=A0 Often th=
e device
> does not report enough information to tell what is going on, so we of=
ten
> must make the assumption that the contact is round.
>
> 3. The orientation vector reported by some devices can provide inform=
ation
> about the extent to which the contact is elongated in one direction o=
r
> another.=A0 By combining this information with the overall area measu=
rement we
> can estimate appropriate values for MAJOR and MINOR that capture the
> distribution.
>
> 4. The resolution field in the absinfo structure rarely seems to be
> populated.=A0 It would be very useful if it were so that applications=
 could
> get a sense of the relation between surface units and physical dimens=
ions.
> It is often more useful to know that a screen is 80mm wide or a touch=
 is
> 18mm wide than it is to know how many pixels that represents.
>
> I believe it would be very beneficial for the community to pull toget=
her and
> fix drivers that currently report size incorrectly.=A0 I would dearly=
 love to
> delete the code I have in Android that compensates for this problem u=
sing
> input device configuration files in user space...
>
> Jeff.
>
> On May 9, 2012 12:14 PM, "Jason Gerecke" <killertofu@gmail.com> wrote=
:
>>
>> On Thu, Mar 15, 2012 at 8:22 PM, Chris Bagwell <chris@cnpbagwell.com=
>
>> wrote:
>> > On Thu, Mar 15, 2012 at 7:10 PM, Jason Gerecke <killertofu@gmail.c=
om>
>> > wrote:
>> >> On Mon, Mar 12, 2012 at 3:41 PM, Chris Bagwell <chris@cnpbagwell.=
com>
>> >> wrote:
>> >>> On Fri, Mar 9, 2012 at 5:26 PM, Jason Gerecke <killertofu@gmail.=
com>
>> >>> wrote:
>> >>>> On Fri, Mar 9, 2012 at 2:30 PM, Chris Bagwell <chris@cnpbagwell=
=2Ecom>
>> >>>> wrote:
>> >>>>> On Wed, Mar 7, 2012 at 7:39 PM, Jason Gerecke <killertofu@gmai=
l.com>
>> >>>>> wrote:
>> >>>>>> 3rd-gen Bamboo devices report both "amplitude" and "size" dat=
a
>> >>>>>> in their touch packets. This patch changes the source for
>> >>>>>> ABS_MT_TOUCH_MAJOR to be the latter rather than the former.
>> >>>>>> ---
>> >>>>>> =A0drivers/input/tablet/wacom_wac.c | =A0 =A02 +-
>> >>>>>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/drivers/input/tablet/wacom_wac.c
>> >>>>>> b/drivers/input/tablet/wacom_wac.c
>> >>>>>> index d0b0fc4..5daf11d 100644
>> >>>>>> --- a/drivers/input/tablet/wacom_wac.c
>> >>>>>> +++ b/drivers/input/tablet/wacom_wac.c
>> >>>>>> @@ -916,7 +916,7 @@ static void wacom_bpt3_touch_msg(struct
>> >>>>>> wacom_wac *wacom, unsigned char *data)
>> >>>>>> =A0 =A0 =A0 =A0if (touch) {
>> >>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D (data[2] << 4) | (da=
ta[4] >> 4);
>> >>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D (data[3] << 4) | (da=
ta[4] & 0x0f);
>> >>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w =3D data[6];
>> >>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w =3D data[5];
>> >>>>>>
>> >>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MT=
_POSITION_X, x);
>> >>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MT=
_POSITION_Y, y);
>> >>>>>> --
>> >>>>>> 1.7.9.1
>> >>>>>>
>> >>>>>
>> >>>>> I found time to test this patch and used "mtview" so I could g=
et
>> >>>>> some
>> >>>>> visual feedback.
>> >>>>>
>> >>>>> The lines because extremely thin with this change. =A0Part of =
reason I
>> >>>>> quickly traced to we are setting range as 0-255 but I couldn't=
 get
>> >>>>> data[5] to go above a value of 18. =A0So I changed range to 0-=
16 and
>> >>>>> it
>> >>>>> works better but the lines still never gets very thick (this c=
ould
>> >>>>> well be that mtview doesn't scale values and prefers 0-255. =A0=
I
>> >>>>> didn't
>> >>>>> look).
>> >>>> Looks like its a combination of two problems, one mine one
>> >>>> mtview's...
>> >>>>
>> >>>> I did some reading, and the MT protocol docs specify that
>> >>>> ABS_MT_TOUCH_MAJOR are in terms of surface units. That means a =
value
>> >>>> of e.g. "20" should represent a touch that spans 20 units of X.=
 The
>> >>>> touch sensor has a resolution of ~0.1mm, which would imply the =
touch
>> >>>> was only 2 mm wide... There's going to have to be a correction =
factor
>> >>>> to transform the value to something more appropriate.
>> >>>>
>> >>>> As for mtview, it looks like it doesn't scale the major/minor a=
xis
>> >>>> values based on the output size. At the very least it should sc=
ale
>> >>>> everything by roughly (output_max_x / sensor_max_x) so that a t=
ouch
>> >>>> taking up e.g. 10% of the tablet would take up 10% of the outpu=
t.
>> >>>
>> >>> I see now that I got lucky that I had a 0-255 value available an=
d
>> >>> didn't look into what I needed to report close enough.
>> >>>
>> >>>>
>> >>>>>
>> >>>>> Amplitude feels better to me using test apps but your in a bet=
ter
>> >>>>> position to say if we should really change this. =A0Please adj=
ust
>> >>>>> declared range though if you still think we should change this=
=2E
>> >>>>>
>> >>>>> Chris
>> >>>>
>> >>>> My main reasons for switching away from amplitude were that amp=
litude
>> >>>> is a very crude number (I think I can get three or four unique =
values
>> >>>> out of it), and that the tablet reports a size already. Worst c=
ase --
>> >>>> assuming a correction factor isn't sufficient to get data[5] wo=
rking
>> >>>> as MAJOR -- we should at least send data[5] through PRESSURE (w=
hich
>> >>>> the MT docs state may be used instead of MAJOR/MINOR if the uni=
ts are
>> >>>> arbitrary).
>> >>>>
>> >>>
>> >>> I've not found time to dig deeply to this (to compute real scale
>> >>> value) but I'll offer this. =A0I compared behaviour of original =
data[6]
>> >>> to this:
>> >>>
>> >>> int w =3D (data[5] > 31) ? 255 : data[5] << 3;
>> >>>
>> >>> and with mtview the size change is much more responsive and
>> >>> consistent. =A0So I'm on board with changing to data[5] in some =
form.
>> >>>
>> >>> Chris
>> >>
>> >> I did a little more testing, and it looks like data[5] is proport=
ional
>> >> to the area (not linear dimension) of the touch. Given the intend=
ed
>> >> semantics (and ignoring the huge blobs it produces in mtview),
>> >> int_sqrt(data[5] << 13) seems to work well. We'd probably have to
>> >> increase the maximum to 512 or 1024 though since I've been able t=
o get
>> >> my palm to produce values of ~600...
>> >>
>> >> Also, I don't yet know how these values scale between tablet size=
s --
>> >> I imagine smaller tablets produce larger values (since their sens=
ors
>> >> are denser), but haven't been able to get my hands on other hardw=
are
>> >> yet.
>> >>
>> >
>> > You've already given it much more thought than I but I made the
>> > following assumption a little bit related. =A0The sensors report X=
/Y
>> > maximums of 4096 even though its a rectangle tablet. Thats why I m=
ade
>> > sure resolution was reported proportionally. =A0Here is from Xorg =
log of
>> > my medium size tablet:
>> >
>> > =A0(--) Wacom Wireless Receiver Finger pad: Wacom Unknown USB tabl=
et
>> > maxX=3D4096 maxY=3D4096 maxZ=3D0 resX=3D18000 resY=3D29000
>> >
>> > I suspect that same ratio also applies to width reporting as well.
>> >
>> > I'm also guessing the value of size is really defining an ellipse =
with
>> > fixed orientation. =A0But we can't really expose that to user as
>> > WIDTH_MINOR because it will be incorrectly interrupted as a pressu=
re
>> > estimate.
>> >
>> > But I suspect the above resolution calculation will help push the
>> > scaling issue to user land and we can concentrate on reporting
>> > something like the int_sqrt() values you've come up with.
>> >
>> > Chris
>>
>> Whoops. Looks like this fell off my radar.
>>
>> So, if I were to adjust the uncorrected width by the aspect ratio to
>> get values for ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR, would that
>> be correct? For example, should placing a quarter (diameter of
>> 24.26mm) on my Intuos5 Medium (logical size: 4096 x 4096, physical
>> size: 223mm x 139mm) ideally report a contact with a MAJOR axis of 7=
14
>> and MINOR axis of 445?
>
> Quarters are great aren't they?=A0 ;-)
>
> Foil wrapped pencils and conductive metal rods work well too.=A0 Low =
tech
> solutions to high tech problems...
>
>>
>> Jason
>>
>> ---
>> Day xee-nee-svsh duu-'ushtlh-ts'it;
>> nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
>> Huu-chan xuu naa~-gha.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
