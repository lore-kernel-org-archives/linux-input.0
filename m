From: Ken Sloat <KSloat@aampglobal.com>
Subject: input: Device Tree Properties for Captouch Button Device Registers
Date: Wed, 19 Jun 2019 12:55:03 +0000
Message-ID: <BL0PR07MB4115574AA13B8F8C2E036644ADE50@BL0PR07MB4115.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Kasun Beddewela <KBeddewela@aampglobal.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ken Sloat <KSloat@aampglobal.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

We have a new input driver we are currently working on and would like to su=
bmit
to the Linux kernel when we finish it. Specifically, this is a cap touch IC=
 which
implements potentially multiple individual proximity and cap touch buttons =
(which
would be reported like key events as seems to be the standard). A couple of=
 questions:

1. What is the preferred/proper method to expose the many registers that
these devices have via device tree?

These devices have dozens of registers, many of which might be needed depen=
ding
on the individual application. It wouldn't be useful in the majority of cas=
es to provide
default values in the driver as the registers are custom tuned to the indiv=
idual application.

2. Where should this device live? I am guessing in input/misc?

Thanks,
Ken Sloat
