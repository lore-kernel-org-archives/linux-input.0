From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of
 gpio_remove retval in driver
Date: Tue, 22 Jul 2014 16:17:28 -0300
Message-ID: <20140722161728.712d961e.m.chehab@samsung.com>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Matthew Garrett <matthew.garrett@nebula.com>, Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, abdoulaye berthe <berthe.ab@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Michael
List-Id: linux-input@vger.kernel.org

Em Tue, 22 Jul 2014 17:08:13 +0200
Linus Walleij <linus.walleij@linaro.org> escreveu:

> On Sat, Jul 12, 2014 at 10:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:
> 
> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
> applied. We're getting rid of the return value from gpiochip_remove().
> 
> > this remove all reference to gpio_remove retval in all driver
> > except pinctrl and gpio. the same thing is done for gpio and
> > pinctrl in two different patches.
> >
> > Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>
> (...)
> 
> I think this patch probably needs to be broken down per-subsystem as it
> hits all over the map. But let's start requesting ACKs for the
> individual pieces.
> Actually I think it will be OK to merge because there is likely not much churn
> around these code sites.
> 
> I'm a bit torn between just wanting a big patch for this hitting drivers/gpio
> and smaller patches hitting one subsystem at a time. We should be able
> to hammer this in one switch strike.
> 
...
> >  drivers/media/dvb-frontends/cxd2820r_core.c    | 10 +++-------
> 
> Mauro can you ACK this?

Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
> 
> (Hm that looks weird. Mental note to look closer at this.)

What's weird there?

Regards,
Mauro
