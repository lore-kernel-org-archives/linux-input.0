From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of
	gpio_remove retval in driver
Date: Thu, 24 Jul 2014 10:29:22 +0200
Message-ID: <CACRpkdaEF14cB+=SjTHgwGH0z88v82Q_UNPvjzDAbpOb_2ec5Q@mail.gmail.com>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
 <20140722151125.GS17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140722151125.GS17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-mips@linux-mips.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Matthew Garrett <matthew.garrett@nebula.com>, Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, abdoulaye berthe <berthe.ab@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Michael Buesch <m@bues.ch>, Greg KH <gregkh>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 22, 2014 at 5:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 22, 2014 at 05:08:13PM +0200, Linus Walleij wrote:
>
>> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
>> applied. We're getting rid of the return value from gpiochip_remove().
>
> Can someone send the patch please?  Splitting it up per-subsystem would
> probably be easier...

OK Abdoulaye maybe we can do it a piece at a time?

I have removed the __must_check attribute from gpiochip_remove()
in the gpiolib, so the compiler won't complain about this being missing
anymore as of kernel v3.17. I also dropped the check in the GPIO
and pin control subsystem, and other subsystems can start
dropping the checks too if they are OK with the build warnings
from the kautobuild until the __must_check removal has propagated
upstream.

Yours,
Linus Walleij
