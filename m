From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] input: gpio-keys: Move the gpio-keys bindings
 documentation
Date: Thu, 15 May 2014 11:22:37 -0300
Message-ID: <20140515142237.GA3147@arch.cereza>
References: <1399905224-1273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140512175806.GB16764@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140512175806.GB16764@core.coreip.homeip.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

On 12 May 10:58 AM, Dmitry Torokhov wrote:
> On Mon, May 12, 2014 at 11:33:44AM -0300, Ezequiel Garcia wrote:
> > This is an input driver and belongs to input not gpio.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20
> Fine by me, will DT guys pick the patch or shoudl I do it?
>=20

I'd say it's just a small file movement, so go for it!

BTW, forgot to prepare the patch with rename detection, want me to rese=
nd it?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
