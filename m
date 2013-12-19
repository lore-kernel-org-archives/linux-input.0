From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] mfd: ti_am335x_tscadc: make am335x_tsc_se_update()
 local
Date: Thu, 19 Dec 2013 08:53:08 +0000
Message-ID: <20131219085308.GF2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387385577-24447-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> since the "recent" changes, am335x_tsc_se_update() has no longer any
> users outside of this file so make it local.

Please use formatting dictated by the subsystem when providing
patches. For MFD we capitalise the first word after 'mfd: <dev>: ' and
the same for the first word in the commit body.

Patch looks okay, I'd prefer to take the set in one go.

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
