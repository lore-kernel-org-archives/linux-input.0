From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] input: wacom: Use touch size for ABS_MT_TOUCH_MAJOR
Date: Mon, 14 May 2012 10:33:27 -0700
Message-ID: <CANRwn3QJXHzteJDJ+YJjtbK9WC3f_1xik1mXtuOvVRAKO6gbtg@mail.gmail.com>
References: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
	<CAGzDe_Z2Dpc9ue06V8mgc_fUUqSe0gJLwDK0piE156EsXV__7Q@mail.gmail.com>
	<CANRwn3SNnBAidf3wBuvSvO0EAyYPhhJXmBrv9Ly9f_HNiJkkPw@mail.gmail.com>
	<CAGzDe_bxoM81HOz2O3k7_bNvNO-V1Ro=fTGqGBRwwsNNtOYvAQ@mail.gmail.com>
	<CANRwn3SuZVQnfR9-+EUXyJ04RssWowUrZaMYNhYyNG9VYB42GA@mail.gmail.com>
	<CAGzDe_aD8SZtDGP2w4NWy0mCepLqUZaVOY55-9CSQqoy_MP=Bw@mail.gmail.com>
	<CANRwn3Qexa3yKs+fsv+CQ_LYrg2Ksj5zskSUwjn-RR9xBP4fSA@mail.gmail.com>
	<CAMu+ixhk+_xZ8Zqn7wj1VOq=C48RCWzh_Vw3-Wrv-=GqOBr7Hw@mail.gmail.com>
	<CAMu+ixj_jd61RXRLE_F1e8gHpELnhmsJ7WjjfNK8NCj23tbnuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63040 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab2ENRdk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 13:33:40 -0400
Received: by wibhn6 with SMTP id hn6so2740710wib.1
        for <linux-input@vger.kernel.org>; Mon, 14 May 2012 10:33:39 -0700 (PDT)
In-Reply-To: <CAMu+ixj_jd61RXRLE_F1e8gHpELnhmsJ7WjjfNK8NCj23tbnuw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Thu, May 10, 2012 at 10:38 PM, Jeffrey Brown <jeffbrown@android.com>=
 wrote:
> Resending to list.
>
> On Thu, May 10, 2012 at 10:32 PM, Jeffrey Brown <jeffbrown@android.co=
m> wrote:
>> I have tackled this problem in Android and it's a real nuisance.=C2=A0=
 As far as
>> I can tell, the vast majority of drivers don't use ABS_MT_TOUCH_MAJO=
R /
>> MINOR or ABT_MT_WIDTH_MAJOR / MINOR correctly.
>>
>> The drivers should be applying a transformation to the hardware repo=
rted
>> 'width' or 'area' measurements so that they can be reported up to us=
er space
>> in terms of surface units.
>>
>> There are two common transformations that may need to be applied.
>>
>> 1. Width values typically need linear scaling sometimes with a bias
>> constant.=C2=A0 eg. out =3D width * scale + bias.=C2=A0 The scale ad=
apts linear width
>> measurements to surface units.=C2=A0 The bias is typically zero but =
some devices
>> have a measurement floor.
>>
>> 2. Area values typically need inverse quadratic scaling.=C2=A0 Takin=
g the
>> assumption that the contact is circular, obtain a nominal width (dia=
meter)
>> using the square root.=C2=A0 Thus we have the relation: out =3D sqrt=
(area) * scale
>> + bias.
>>
>> It is easy to determine which of the two schemes to apply by observi=
ng the
>> relation between reported width or area (in unknown device specific =
units,
>> possibly sensor cell sizes) versus physical size (in millimeters).=C2=
=A0 When
>> plotted, look for the linear or quadratic relation and choose accord=
ingly.
>>
>> (I have yet to find a touch controller that uses the same units to r=
eport
>> size as it uses for position.)
>>
>> I often use coins as benchmark test objects of known size.=C2=A0 Dim=
es, nickels,
>> quarters, dollars...=C2=A0 (I wish I had some standard probes of var=
ious sizes.).
>> It is a good idea to get a range of objects of different sizes, part=
icularly
>> in the 6-16mm range.
>>
>> Special considerations:
>>
>> 1. Some devices do not report the individual size of each contact
>> correctly.=C2=A0 They may report a value that is a sum of the total =
area
>> covered.=C2=A0 A simple expedient is to divide the raw reported widt=
h or area by
>> the number of contacts for these devices.
>>
I was pretty sure I checked this, but it's been a while since I did
any testing and figured it'd be a good idea to make sure. Looks like
looks like I5 and Bamboo 3G don't sum up the values.

>> 2. Size measurement is by necessity an approximation.=C2=A0 Laying a=
 finger flat
>> may distribute the contact area over an elongated region.=C2=A0 Ofte=
n the device
>> does not report enough information to tell what is going on, so we o=
ften
>> must make the assumption that the contact is round.
>>
>> 3. The orientation vector reported by some devices can provide infor=
mation
>> about the extent to which the contact is elongated in one direction =
or
>> another.=C2=A0 By combining this information with the overall area m=
easurement we
>> can estimate appropriate values for MAJOR and MINOR that capture the
>> distribution.
>>
There's no orientation information to speak of in these packets, so
I'm just interested in knowing if its appropriate to omit MINOR for
our tablet. The docs say that we're allowed to do so for a circular
contact (which is the best estimate we can make), and it's possible to
re-generate MINOR for a circular contact given just MAJOR and
absinfo.resolution (which we fill in), but it doesn't look like
userspace necessarily bothers to do that calculation. Android (not to
pick on) for instance appears to simply assume MINOR =3D=3D MAJOR when =
its
otherwise not specified. That's fine for sensors with identical
horizontal and vertical resolution, but ours is "squished" and has
significantly higher vertical resolution...

>> 4. The resolution field in the absinfo structure rarely seems to be
>> populated.=C2=A0 It would be very useful if it were so that applicat=
ions could
>> get a sense of the relation between surface units and physical dimen=
sions.
>> It is often more useful to know that a screen is 80mm wide or a touc=
h is
>> 18mm wide than it is to know how many pixels that represents.
>>
>> I believe it would be very beneficial for the community to pull toge=
ther and
>> fix drivers that currently report size incorrectly.=C2=A0 I would de=
arly love to
>> delete the code I have in Android that compensates for this problem =
using
>> input device configuration files in user space...
>>
>> Jeff.
Ah, deleting code. Nothing feels quite as good :)

>>
>> On May 9, 2012 12:14 PM, "Jason Gerecke" <killertofu@gmail.com> wrot=
e:
>>>
>>> On Thu, Mar 15, 2012 at 8:22 PM, Chris Bagwell <chris@cnpbagwell.co=
m>
>>> wrote:
>>> > On Thu, Mar 15, 2012 at 7:10 PM, Jason Gerecke <killertofu@gmail.=
com>
>>> > wrote:
>>> >> On Mon, Mar 12, 2012 at 3:41 PM, Chris Bagwell <chris@cnpbagwell=
=2Ecom>
>>> >> wrote:
>>> >>> On Fri, Mar 9, 2012 at 5:26 PM, Jason Gerecke <killertofu@gmail=
=2Ecom>
>>> >>> wrote:
>>> >>>> On Fri, Mar 9, 2012 at 2:30 PM, Chris Bagwell <chris@cnpbagwel=
l.com>
>>> >>>> wrote:
>>> >>>>> On Wed, Mar 7, 2012 at 7:39 PM, Jason Gerecke <killertofu@gma=
il.com>
>>> >>>>> wrote:
>>> >>>>>> 3rd-gen Bamboo devices report both "amplitude" and "size" da=
ta
>>> >>>>>> in their touch packets. This patch changes the source for
>>> >>>>>> ABS_MT_TOUCH_MAJOR to be the latter rather than the former.
>>> >>>>>> ---
>>> >>>>>> =C2=A0drivers/input/tablet/wacom_wac.c | =C2=A0 =C2=A02 +-
>>> >>>>>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>> >>>>>>
>>> >>>>>> diff --git a/drivers/input/tablet/wacom_wac.c
>>> >>>>>> b/drivers/input/tablet/wacom_wac.c
>>> >>>>>> index d0b0fc4..5daf11d 100644
>>> >>>>>> --- a/drivers/input/tablet/wacom_wac.c
>>> >>>>>> +++ b/drivers/input/tablet/wacom_wac.c
>>> >>>>>> @@ -916,7 +916,7 @@ static void wacom_bpt3_touch_msg(struct
>>> >>>>>> wacom_wac *wacom, unsigned char *data)
>>> >>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (touch) {
>>> >>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x=
 =3D (data[2] << 4) | (data[4] >> 4);
>>> >>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int y=
 =3D (data[3] << 4) | (data[4] & 0x0f);
>>> >>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D=
 data[6];
>>> >>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D=
 data[5];
>>> >>>>>>
>>> >>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input=
_report_abs(input, ABS_MT_POSITION_X, x);
>>> >>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input=
_report_abs(input, ABS_MT_POSITION_Y, y);
>>> >>>>>> --
>>> >>>>>> 1.7.9.1
>>> >>>>>>
>>> >>>>>
>>> >>>>> I found time to test this patch and used "mtview" so I could =
get
>>> >>>>> some
>>> >>>>> visual feedback.
>>> >>>>>
>>> >>>>> The lines because extremely thin with this change. =C2=A0Part=
 of reason I
>>> >>>>> quickly traced to we are setting range as 0-255 but I couldn'=
t get
>>> >>>>> data[5] to go above a value of 18. =C2=A0So I changed range t=
o 0-16 and
>>> >>>>> it
>>> >>>>> works better but the lines still never gets very thick (this =
could
>>> >>>>> well be that mtview doesn't scale values and prefers 0-255. =C2=
=A0I
>>> >>>>> didn't
>>> >>>>> look).
>>> >>>> Looks like its a combination of two problems, one mine one
>>> >>>> mtview's...
>>> >>>>
>>> >>>> I did some reading, and the MT protocol docs specify that
>>> >>>> ABS_MT_TOUCH_MAJOR are in terms of surface units. That means a=
 value
>>> >>>> of e.g. "20" should represent a touch that spans 20 units of X=
=2E The
>>> >>>> touch sensor has a resolution of ~0.1mm, which would imply the=
 touch
>>> >>>> was only 2 mm wide... There's going to have to be a correction=
 factor
>>> >>>> to transform the value to something more appropriate.
>>> >>>>
>>> >>>> As for mtview, it looks like it doesn't scale the major/minor =
axis
>>> >>>> values based on the output size. At the very least it should s=
cale
>>> >>>> everything by roughly (output_max_x / sensor_max_x) so that a =
touch
>>> >>>> taking up e.g. 10% of the tablet would take up 10% of the outp=
ut.
>>> >>>
>>> >>> I see now that I got lucky that I had a 0-255 value available a=
nd
>>> >>> didn't look into what I needed to report close enough.
>>> >>>
>>> >>>>
>>> >>>>>
>>> >>>>> Amplitude feels better to me using test apps but your in a be=
tter
>>> >>>>> position to say if we should really change this. =C2=A0Please=
 adjust
>>> >>>>> declared range though if you still think we should change thi=
s.
>>> >>>>>
>>> >>>>> Chris
>>> >>>>
>>> >>>> My main reasons for switching away from amplitude were that am=
plitude
>>> >>>> is a very crude number (I think I can get three or four unique=
 values
>>> >>>> out of it), and that the tablet reports a size already. Worst =
case --
>>> >>>> assuming a correction factor isn't sufficient to get data[5] w=
orking
>>> >>>> as MAJOR -- we should at least send data[5] through PRESSURE (=
which
>>> >>>> the MT docs state may be used instead of MAJOR/MINOR if the un=
its are
>>> >>>> arbitrary).
>>> >>>>
>>> >>>
>>> >>> I've not found time to dig deeply to this (to compute real scal=
e
>>> >>> value) but I'll offer this. =C2=A0I compared behaviour of origi=
nal data[6]
>>> >>> to this:
>>> >>>
>>> >>> int w =3D (data[5] > 31) ? 255 : data[5] << 3;
>>> >>>
>>> >>> and with mtview the size change is much more responsive and
>>> >>> consistent. =C2=A0So I'm on board with changing to data[5] in s=
ome form.
>>> >>>
>>> >>> Chris
>>> >>
>>> >> I did a little more testing, and it looks like data[5] is propor=
tional
>>> >> to the area (not linear dimension) of the touch. Given the inten=
ded
>>> >> semantics (and ignoring the huge blobs it produces in mtview),
>>> >> int_sqrt(data[5] << 13) seems to work well. We'd probably have t=
o
>>> >> increase the maximum to 512 or 1024 though since I've been able =
to get
>>> >> my palm to produce values of ~600...
>>> >>
>>> >> Also, I don't yet know how these values scale between tablet siz=
es --
>>> >> I imagine smaller tablets produce larger values (since their sen=
sors
>>> >> are denser), but haven't been able to get my hands on other hard=
ware
>>> >> yet.
>>> >>
>>> >
>>> > You've already given it much more thought than I but I made the
>>> > following assumption a little bit related. =C2=A0The sensors repo=
rt X/Y
>>> > maximums of 4096 even though its a rectangle tablet. Thats why I =
made
>>> > sure resolution was reported proportionally. =C2=A0Here is from X=
org log of
>>> > my medium size tablet:
>>> >
>>> > =C2=A0(--) Wacom Wireless Receiver Finger pad: Wacom Unknown USB =
tablet
>>> > maxX=3D4096 maxY=3D4096 maxZ=3D0 resX=3D18000 resY=3D29000
>>> >
>>> > I suspect that same ratio also applies to width reporting as well=
=2E
>>> >
>>> > I'm also guessing the value of size is really defining an ellipse=
 with
>>> > fixed orientation. =C2=A0But we can't really expose that to user =
as
>>> > WIDTH_MINOR because it will be incorrectly interrupted as a press=
ure
>>> > estimate.
>>> >
>>> > But I suspect the above resolution calculation will help push the
>>> > scaling issue to user land and we can concentrate on reporting
>>> > something like the int_sqrt() values you've come up with.
>>> >
>>> > Chris
>>>
>>> Whoops. Looks like this fell off my radar.
>>>
>>> So, if I were to adjust the uncorrected width by the aspect ratio t=
o
>>> get values for ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR, would tha=
t
>>> be correct? For example, should placing a quarter (diameter of
>>> 24.26mm) on my Intuos5 Medium (logical size: 4096 x 4096, physical
>>> size: 223mm x 139mm) ideally report a contact with a MAJOR axis of =
714
>>> and MINOR axis of 445?
>>
>> Quarters are great aren't they?=C2=A0 ;-)
>>
>> Foil wrapped pencils and conductive metal rods work well too.=C2=A0 =
Low tech
>> solutions to high tech problems...
>>
Yup. Gotta love 'em :)

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
