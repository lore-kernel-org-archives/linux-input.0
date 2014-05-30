From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Date: Fri, 30 May 2014 17:48:59 +0200
Message-ID: <20140530154859.GK17197@linux-mips.org>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: abdoulaye berthe <berthe.ab@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, m@bues.ch, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, patches@opensource.wolfsonmicro.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com, platform-driver-x86@vger.kernel.org"netdev@vger.kernel.org" <ne>
List-Id: linux-input@vger.kernel.org

On Fri, May 30, 2014 at 01:39:15PM +0200, Geert Uytterhoeven wrote:

> > +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> > +                       panic("gpio: removing gpiochip with gpios still requested\n");
> 
> panic?
> 
> Is this likely to happen?

And while we're at it - panic() is going to add a \n itself so don't pass a
string ending in \n to panic().

  Ralf
