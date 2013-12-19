From: Lee Jones <lee.jones@linaro.org>
Subject: Re: am335x: IIO/ADC fixes if used together with TSC
Date: Thu, 19 Dec 2013 08:48:47 +0000
Message-ID: <20131219084847.GD2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <d916c9be-2614-41b8-ae92-67bf1a57ed74@email.android.com>
 <52B1EAC5.4020104@linutronix.de>
 <a3513779-5ede-4e33-b29d-0cc8e73f8282@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a3513779-5ede-4e33-b29d-0cc8e73f8282@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> >> Given timing I suspect that by the we have reviewed these will be =
too
> >late in this cycle so will hit in the merge window plus stable.
> >>=20
> >> Also some of these are cleanups rather than fixes so should normal=
ly
> >be separate from fixes and applied after them as they are not=20
> >> Stable material.
> >
> >I tried to keep 5/5 as small as possible so I factor individual and
> >separate changes as good as possible as long as the drivers remained
> >functional. That means 1-4 are mostly pre-work for 5/5 and that make=
s
> >5/5 depends on them.
> >
> >Tagging 5/5 stable I would prefer to take 1-4, too to keep the backp=
ort
> >effort small. The clash due to the continues mode which is v3.13 is
> >probably small. This said, I think it is the best to backport it sta=
ble
> >if someone asks for it (unless the majority here thinks otherwise).
> >
> >Are you saying this is too late for v3.13 or v3.14-rc1?
> >
> >Sebastian
>=20
> Too late for 3.13. Probably fine for next merge window if reviews are=
 all good or as a
>  fix post 3.14-rc1 of it misses the cutoff for the merge window.

I think this set should go in via -next. So it will hit the v3.14
merge window.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
