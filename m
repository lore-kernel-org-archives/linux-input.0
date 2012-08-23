From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Date: Thu, 23 Aug 2012 17:43:32 +0200
Message-ID: <50364FA4.7000401@metafoo.de>
References: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit.thebaudeau@advansee.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/23/2012 04:19 PM, Beno=C3=AEt Th=C3=A9baudeau wrote:
> Some PWM drivers enable the clock of the PWM peripheral in pwm_enable=
(). Hence,
> for these drivers, a call to pwm_config() does not have any effect be=
fore
> pwm_enable() has been called.
>=20
> This patch fixes the PWM users to make sure that they call pwm_enable=
() before
> pwm_config().
>=20
> This fixes the first setting of brightness through sysfs that had no =
effect with
> leds-pwm and the i.MX PWM driver.

But isn't this a bug in the PWM peripheral driver? With this change the=
 PWM
will start with the old settings first. While this is not so much of a =
problem
for a backlight (although it might cause a short flickering) it might c=
ause
problems for other applications, like using the PWM pin as a timing gen=
erator.
In my opinion it's better to fix the PWM peripheral drivers which have =
this
problem instead of trying to work around it in every user of the PWM AP=
I.

- Lars
