From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Fri, 14 Nov 2014 19:30:22 +0400
Message-ID: <CALT56yPkKO=_FYyQvgvnCBA4XU6ETZk_3NNjRu-0mhHy-4aSAQ@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
	<CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
	<CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
	<CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
	<20141105202405.GJ8509@sirena.org.uk>
	<CALT56yOtjNbYOWM4ba5yP8pz7bNLY5BWpkkpfmv5QZU-7Y5u_g@mail.gmail.com>
	<20141114151000.GC3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20141114151000.GC3815@sirena.org.uk>
Sender: linux-leds-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

2014-11-14 18:10 GMT+03:00 Mark Brown <broonie@kernel.org>:
> On Fri, Nov 14, 2014 at 04:47:00PM +0400, Dmitry Eremin-Solenikov wrote:
>
>> I'm actually looking at the regulator interface. Since this DAC serves mostly
>> like a (semi-)constant voltage interface, would it be rather logical to use
>> regulator subsystem to drive it?
>
> Possibly...  it's mostly a function of what the consumers of the
> functionality look like - if that code looks weird calling into the
> regulator API then it's bad, if that code looks OK it's fine.  I haven't
> looked at the hardware at all so don't have strong feelings either way
> so long as the result looks tasteful.

The DAC is used in backlight driver (control brightness) and in ASoC
machine driver (master joined volume).

-- 
With best wishes
Dmitry
