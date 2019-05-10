From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
Date: Fri, 10 May 2019 11:33:26 +0200
Message-ID: <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> Am 10.05.2019 um 10:57 schrieb Bastien Nocera <hadess@hadess.net>:
>=20
> On Mon, 2019-04-22 at 15:20 +0100, Jonathan Cameron wrote:
>>> Different goals usually lead to different solution architectures.
>>=20
>> Indeed, but in this case we have your proposal which is a subset of
>> what
>> I am suggesting.  One architecture can fulfil both requirements.
>>=20
>> I'll leave it for the other thread, but Bastien has raised the case
>> (that I'd forgotten) that there already userspace stacks that are
>> capable of happily taking in both IIO and Input devices.  The
>> confusion
>> here is they will now discover 'both' without the existing userspace
>> knowing that they are the same device.  We need to be very careful
>> not
>> to break those userspace programs.
>>=20
>> So this is an illustration of why the simplistic case doesn't work
>> 'now'.
>=20
> I don't know what state the whole patch is, but, at the very least, =
I'd
> expect that patch to export the fact that it's exporting synthesised
> data from another driver, so that it can be easily ignored in user-
> space that already supports IIO devices.
>=20

It does through "Input device name:" starting with "iio-bridge:" as you =
can see in the commit message of [RFC v3]:

root@letux:~# evtest /dev/input/event5 | head -19
Input driver version is 1.0.1
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "iio-bridge: bmc150_accel"
Supported events:
  Event type 0 (EV_SYN)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      8
      Min     -511
      Max      511
    Event code 1 (ABS_Y)
      Value    -44
      Min     -511
      Max      511
    Event code 2 (ABS_Z)
      Value   -265
      Min     -511
      Max      511
