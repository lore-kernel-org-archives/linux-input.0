From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] pwm: Call pwm_enable() before pwm_config()
Date: Thu, 30 Aug 2012 16:10:11 +0900
Message-ID: <002001cd867e$7e964130$7bc2c390$%han@samsung.com>
References: <217877237.2758643.1345731587941.JavaMail.root@advansee.com>
 <50364FA4.7000401@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <50364FA4.7000401@metafoo.de>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Lars-Peter Clausen' <lars@metafoo.de>
Cc: 'Thierry Reding' <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, 'Sascha Hauer' <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Bryan Wu' <bryan.wu@canonical.com>, 'Richard Purdie' <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, =?utf-8?Q?'Beno=C3=AEt_Th=C3=A9baudeau'?= <benoit.thebaudeau@advansee.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Friday, August 24, 2012 12:44 AM, Lars-Peter Clausen wrote:
>=20
> On 08/23/2012 04:19 PM, Beno=C3=AEt Th=C3=A9baudeau wrote:
> > Some PWM drivers enable the clock of the PWM peripheral in pwm_enab=
le(). Hence,
> > for these drivers, a call to pwm_config() does not have any effect =
before
> > pwm_enable() has been called.
> >
> > This patch fixes the PWM users to make sure that they call pwm_enab=
le() before
> > pwm_config().
> >
> > This fixes the first setting of brightness through sysfs that had n=
o effect with
> > leds-pwm and the i.MX PWM driver.
>=20
> But isn't this a bug in the PWM peripheral driver? With this change t=
he PWM
> will start with the old settings first. While this is not so much of =
a problem
> for a backlight (although it might cause a short flickering) it might=
 cause
> problems for other applications, like using the PWM pin as a timing g=
enerator.
> In my opinion it's better to fix the PWM peripheral drivers which hav=
e this
> problem instead of trying to work around it in every user of the PWM =
API.

Hi Lars-Peter Clausen,

I think so.
It would be better to fix the PWM peripheral drivers.


Best regards,
Jingoo Han

>=20
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
