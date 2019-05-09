From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
Date: Thu, 9 May 2019 19:02:49 +0200
Message-ID: <D4F87479-4FF7-4DBC-81D5-1BA836D2C889@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-iio <linux-iio@vger.kernel.org>, kernel@pyra-handheld.com, lkml <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-input@vger.kernel.org


> Am 09.05.2019 um 11:09 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Jonathan,
>>=20
>>=20
>> And how does that work on the common case of a sensor in the lid of a =
laptop?
>> how do you know what angle the screen is at? =20
>=20
> Well, I am not aware of laptops where the sensor is in the lid because =
I am in the handhelds
> business, but let's assume it is common.
>=20
> I realized that if the sensor orientation is related to the lid =
position, while the reference
> frame reported to user space is to be referenced to the lap or =
keyboard of the laptop, there does
> not exist a static mount-matrix to describe it properly. So no driver =
can report that correctly.
>=20
> Therefore, such a device needs a dynamic mount matrix, i.e. there =
should be a kernel driver that
> reads out the lid angle sensor and modifies the mount-matrix of the =
accelerometer by some sin()/cos()
> table.

One more thought on this topic.

My answer to the question "how do you know what angle the screen is at?" =
by requiring an ADC to
measure some potentiometer in the hinge to make the mount matrix dynamic =
is probably completely
wrong...

If we take the definition for the mount matrix, it defines a specific =
g-vector pointing to
center of earth if the user is holding the device in a specific position =
and looking on the display
or the keyboard.

So far the description assumes that there is a single accelerometer and =
display and keys of a phone
are in a single plane, i.e. there is no angle and everything is fine.

Now if we simply take the two accelerometers separately, one z-axis is =
going through the keyboard
and the other through the display. Which means if the mount matrices are =
well defined, the accelerometers
should report almost the same values if the display is fully opened by =
180 degrees, i.e. the display
is sitting flat on the table. This is what my RFC does by autoscaling. =
The values differ only
by noise.

Now what about measuring the lid angle? Well, it is already measured by =
both accelerometers! If they
do not agree, the angle can be calculated by some arctan() based on y =
and z axis reports...

If you close the lid, the display is turned upside down and y and z axes =
reverse sign.

So there remains only the issue that user-space must know which sensor =
device file is which sensor
and can do the calculation of the lid angle. This is possible because =
the iio accelerometer name
is available through the input event ioctls.

In summary this case also does not need policy or configuration. Just =
user space using the information
that is already presented.

BR,
Nikolaus
