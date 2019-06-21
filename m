From: Ken Sloat <KSloat@aampglobal.com>
Subject: RE: input: Device Tree Properties for Captouch Button Device
 Registers
Date: Fri, 21 Jun 2019 14:11:33 +0000
Message-ID: <BL0PR07MB41150BF0740C6F7E63FF4E11ADE70@BL0PR07MB4115.namprd07.prod.outlook.com>
References: <BL0PR07MB4115574AA13B8F8C2E036644ADE50@BL0PR07MB4115.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BL0PR07MB4115574AA13B8F8C2E036644ADE50@BL0PR07MB4115.namprd07.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Kasun Beddewela <KBeddewela@aampglobal.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ken Sloat <KSloat@aampglobal.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Ken Sloat
> Sent: Wednesday, June 19, 2019 8:55 AM
> To: dmitry.torokhov@gmail.com
> Cc: Kasun Beddewela <KBeddewela@aampglobal.com>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Ken Sloat
> <KSloat@aampglobal.com>
> Subject: input: Device Tree Properties for Captouch Button Device Registe=
rs
>=20
> Hello Dmitry,
>=20
> We have a new input driver we are currently working on and would like to
> submit
> to the Linux kernel when we finish it. Specifically, this is a cap touch =
IC which
> implements potentially multiple individual proximity and cap touch button=
s
> (which
> would be reported like key events as seems to be the standard). A couple =
of
> questions:
>=20
> 1. What is the preferred/proper method to expose the many registers that
> these devices have via device tree?
>=20
> These devices have dozens of registers, many of which might be needed
> depending
> on the individual application. It wouldn't be useful in the majority of c=
ases to
> provide
> default values in the driver as the registers are custom tuned to the
> individual application.
>=20
> 2. Where should this device live? I am guessing in input/misc?
>=20
> Thanks,
> Ken Sloat

CC'ing people from device tree mailing list since this discussion would be =
relevant there as well, so the more generic question would be: For any devi=
ce which requires multiple unique register configuration values per target =
application - what is the preferred method to expose all these via devicetr=
ee? Maybe there are some good examples of this already somewhere in the ker=
nel drivers?

Thanks,
Ken Sloat
