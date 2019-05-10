From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
Date: Fri, 10 May 2019 12:06:03 +0200
Message-ID: <4C600F37-33E3-4C3D-B7D1-BBB85D5A2195@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net> <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com> <4a77d53966d117bc5c7ff2836634d8591633f4f5.camel@hadess.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4a77d53966d117bc5c7ff2836634d8591633f4f5.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> Am 10.05.2019 um 11:35 schrieb Bastien Nocera <hadess@hadess.net>:
>=20
> On Fri, 2019-05-10 at 11:33 +0200, H. Nikolaus Schaller wrote:
>>>=20
> <snip>
>> It does through "Input device name:" starting with "iio-bridge:" as
>> you can see in the commit message of [RFC v3]:
>=20
> This makes it ABI, right?

The "Input device name:" is already ABI of the input system (although I =
guess the string is
built into the evtest tool). I think there are also /sys nodes which =
carry the same information.

But yes, if someone changes the "iio-bridge:" prefix in kernel code it =
breaks a user space lib
making use of it:

+	poll_dev->input->name =3D kasprintf(GFP_KERNEL, "iio-bridge: =
%s",
+						    indio_dev->name);
+	poll_dev->input->phys =3D kasprintf(GFP_KERNEL, "iio:device%d",
+						    indio_dev->id);

This type of exporting names seems to be quite common. E.g. "mmcblk0p1" =
which may end up
in some /etc/fstab.

>=20
> Big fat warnings around the code that declares it would be =
appreciated.

Ok.
