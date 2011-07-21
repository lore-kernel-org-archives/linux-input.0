From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 0/6] mc13783: add pwr button support
Date: Thu, 21 Jul 2011 16:44:42 +0200
Message-ID: <20110721144442.GA16561@pengutronix.de>
References: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: amit.kucheria@canonical.com, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, s.hauer@pengutronix.de, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hello Philippe,

On Thu, Jul 21, 2011 at 05:10:00PM +0200, Philippe R=E9tornaz wrote:
> This add button handling for the MC13783 PMIC.
> The first patch modify the mc13783 MFD driver to add a button
> subdevice and also adds the mc13783-pwrbutton driver using a misc
> input device.
> =

> The second patch adds the power on button support to the mx31moboard boar=
ds.
> =

> Patch 3 & 4 modify the mc13xxx MFD driver to use the platform data to =

> register the led subdevice and unconditionally register the regulator
> subdevice (as suggested by Mark and Uwe).
> =

> Patch 5 remove the use of the *_USE_REGULATOR and *_USE_LED in the platfo=
rm
> files.
> =

> Patch 6 must be applied after patch 3,4,5 to remove the obsolete define.
> =

> v2: first patch modified according to comments by Dmitry Torokhov
> v3: Implement review by Uwe
> v4: Implement comments by Uwe and Mark
> =

> Philippe R=E9tornaz (6):
>   mc13783: add power button support
>   mx31moboard: Add MC13783 power button support
>   mc13xxx: Unconditionally register regulator subdevice
>   mc13xxx: implicitly register led subdevice
>   mc13xxx: remove obsolete leds and regualtors flags
>   mc13xxx: remove unused define
I think Arndt would like to have the clean up stuff first (assuming this
goes via the arm-soc tree). That is 3-6, then 1-2.

Other than that I think the series looks good now (at least the arch/arm
bits, didn't recheck the rest).
 =

>  arch/arm/mach-imx/mach-mx27_3ds.c      |    1 -
>  arch/arm/mach-imx/mach-mx31_3ds.c      |    2 +-
>  arch/arm/mach-imx/mach-mx31lite.c      |    3 +-
>  arch/arm/mach-imx/mach-mx31moboard.c   |   11 +-
>  arch/arm/mach-imx/mach-pcm038.c        |    3 +-
>  arch/arm/mach-mx5/mx51_efika.c         |    2 +-
>  drivers/input/misc/Kconfig             |   10 +
>  drivers/input/misc/Makefile            |    1 +
>  drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++++++=
++++++
>  drivers/mfd/mc13xxx-core.c             |   12 +-
>  include/linux/mfd/mc13783.h            |    3 +-
>  include/linux/mfd/mc13xxx.h            |   19 ++-
>  12 files changed, 337 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/input/misc/mc13783-pwrbutton.c

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
