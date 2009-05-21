From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Thu, 21 May 2009 10:21:48 +0000
Message-ID: <4A152B3C.1070500@cam.ac.uk>
References: <20090515131636.GE4443@nokia.com> <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com> 	<45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com> 	<20090515200235.GA11829@nokia.com> <4d34a0a70905180045u6619773dt1563fe38b13d46fb@mail.gmail.com> 	<20090518091236.GH4443@nokia.com> <4A121C54.2040205@samsung.com> 	<20090519104202.GB30597@nokia.com> <45cc95260905190534m561d666ds1fd5d38b4a08ba5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:55427 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZEUKWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 06:22:11 -0400
In-Reply-To: <45cc95260905190534m561d666ds1fd5d38b4a08ba5b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: felipe.balbi@nokia.com, ext Kim Kyuwon <q1.kim@samsung.com>, ext Kim Kyuwon <chammoru@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Jean Delvare <khali@linux-fr.org>


> Hi,
>=20
>>>  > But then comes another question: what to do with
>>>> magnetometers, gyroscopes, etc etc ??
>>> If we make a extensible sensor driver, I think we can add these new=
 etc
>>> sensors in the future. step by step.
>> agreed here. But we have to think that this might get extended, so w=
e
>> should start thinking of an abstraction layer that could evolve for
>> magnetometers, gyroscopes and other sensors
>=20
> Agree with you, there should be an abstraction layer.
Indeed. There is however a question of where some of this should take
place. (Pretty much userspace vs kernel space).

Getting some of the more useful information from these sensors
(particularly where multiple types are available together) will
require quite sophisticated algorithms that are not available in kernel=
=2E

An example of devices where this is true would be the new wii controlle=
r
add on (although in this case it's all handled on the remote I think).
Here multiple sensors are used in conjunction to give results that simp=
ly
can't be established with a single sensor type.  Even in cases such
as analogs adis16350 and similar IMUs there is a lot of processing to b=
e
done off the chip it self.

Yes we can do the dumb iphone style (hideously smoothed) accelerometer
type control, but that only touches the tip of what is possible.
=20
> According to this, we should collect similar functionalities in one
> module and make sub-module describing exceptions devices or ones that
> needs special handling.
Some things can be wrapped into a core subsystem driver, but a frighten=
ing
amount of this stuff is chip specific.
> But in the end for the user space apps, they should "see" an
> accelerometer in a standard way. All exceptions and pre-handling
> should be done in the abstraction layer as described.
Such an abstraction layer should exist, but shouldn't be the only way t=
o
access these devices.  A lot of them provide weird and wonderful elemen=
ts
(based on internal processing) that would lead to an obscene amount of =
bloat
on any attempt at a general abstraction.
> We can't bring as many full drivers as devices found, but one driver
> serving for a group and that can load submodules when necessary.
Doesn't work.  In hid you can do this because the hardware itself confo=
rms
to a tight spec.  This simply isn't the case with the types of sensor w=
e
are talking about here.  They structure that would be needed would be m=
uch
closer to that taken by hwmon, where every chip (or family of chips) ha=
s
to have it's own driver.   Sure it then registers certain elements with
the core, but fundamentally they aren't similar enough to share all tha=
t
much code.
> The way HID is coded in Linux is an example for that, dealing with
> many types of devices.
> It isn't perfect, but its architecture can be used for other devices.
=20
> To stay with accelerometers, they are sensors, and sensors sense
> physical properties.
> Every device use its own methods but in the end they sense the same
> thing and user wait for a similar feedback.
Partly true.  There is certainly a core functionality that is shared
across some of these chips.  However take a look at the drivers in IIO
or some data sheets and you'll find a frightening variety of other stuf=
f
in each driver.  For basic input stuff it may be fine to only support t=
he
common elements, but that's not an option for many other applications.
You tend to have picked a chip with particular features for a reason!
>=20
> I post a link describing the HID standard, you can see in page 37 to
> 39 how they define units, and exponents for sensors.
> http://www.usb.org/developers/devclass_docs/HID1_11.pdf
>=20
> Also, we can't imagine all use cases and scenarios, we should bring
> useful information to userspace apps and they do what they want with
> these informations.
> KDE developers may use sensors to automatically rotate the screen
> 90=B0/180=B0 if the laptop is rotated. Others will use it to play gam=
es,
> Some others will use light sensors to lighten the keyboard or to
> change the brightness of the screen,...
>=20
In a previous (off list) discussion, faking HID was brought up, so I'll
summarize where we got to.

=46irstly note we would be faking HID.  In it's conventional use, it wo=
uld be
the sensors themselves that would provide information about their facil=
ities
and add all the stuff that it's described in the document above.  Sadly=
 for
these devices very few manufacturers have gone down that path.  The dri=
ver has
to know what a given chip supports, there is no query method.  It would=
 be possible
to make this work, but it's a seriously nasty case of blugeoning data i=
nto a
format that although flexible enough, was very much designed for other =
things.
=46eel free to try and persuade the manufacturers to conform to HID!

To keep this maintenance nightmare minimal, we'd probably have to keep =
pretty
much completely separate from the HID system and just rely on matching =
interfaces.
(worth bringing in some HID experts but that's the feeling I got from r=
eading
the code last time round?)

This in turn means we going to generate a nasty problem with testing an=
y userspace
developments against both conventional hid and our 'fake' hid implement=
ation.

If we were to go this way it would have to only be one of several inter=
faces.
The overhead will be large, and frankly for the high performance sampli=
ng end of
things that I'm interested in (and others who are in the CC's above) th=
is isn't
an option.  Do you want to make HID deal with hardware (or software) ri=
ng buffering
for example?  It's way out of scope.

My personal preference for this problem area would be to look at how to=
 add some
minimal core functionality to IIO to make it provide input interfaces a=
s well.
In a similar fashion to lm-sensors it will be possible to establish fun=
ctionality
of a given device by looking at what it exports in sysfs and hence appl=
ications
(or more likely a nice userspace library) can use this to identify what=
 sort of
data is available and do any aggregation and processing.  In a similar =
fashion
to lm-sensors, this library would be kept in sync with the kernel tree.

HID might be an option, but I'm yet to be convinced it would be practic=
al.

Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
