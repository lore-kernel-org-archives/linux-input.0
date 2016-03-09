From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Wed, 9 Mar 2016 10:36:54 +0200
Message-ID: <20160309083654.GC1796@lahna.fi.intel.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
 <20160222195815.GB28343@dtor-ws>
 <CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
 <20160229081723.GB1770@lahna.fi.intel.com>
 <CA+V1LzqX7_r1YuBCHSVLbjmp=6Ra=fi+mnVjNGzNhdvEDgXh2Q@mail.gmail.com>
 <20160301075241.GD1794@lahna.fi.intel.com>
 <CACRpkdb2vwjcpvOdmn36u_ESpapoc7_BPGOVFGKfsRmW_Q2cQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb2vwjcpvOdmn36u_ESpapoc7_BPGOVFGKfsRmW_Q2cQA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: sergk sergk2mail <sergk.admin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 09, 2016 at 10:36:08AM +0700, Linus Walleij wrote:
> I just this merge window added an ABI for userspace to read name
> of the GPIO line and also consumer name ("label") by using the
> two strings stored in struct gpio_desc.
> 
> Currently this will be initialized per-offset from the seldom used
> char names[] in struct gpio_chip, if not NULL.
> 
> We're working on DT bindings to set this per-line from the DT, and
> if ACPI has a mechanism to name individual lines, please submit
> patches for assigning this properly! (Hi Mika ;)

Hi :)

Yes, ACPI nowadays has mechanism for assigning names to GPIOs (_DSD). We
will look into the DT implementation and try to come up with
corresponding ACPI version.

Thanks for the heads-up.
