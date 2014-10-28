From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/15] new locomo driver
Date: Tue, 28 Oct 2014 00:13:39 +0000
Message-ID: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg KH <greg@kroah.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Andrea Adami <andrea.adami@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
> Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
> drivers present in Linux kernel has some problems:
> 
>  * It uses custom bus instead of platform bus/mfd core.

I believe Greg wouldn't see that as a positive point.

Don't think that the platform bus _should_ always be used.  It shouldn't
(Greg has said he'd like to see the platform bus to be totally killed off.)
Instead, custom buses properly suited to the class of device in question
is much preferred, especially if it aids in...

>  * Device drivers are not well layered/separated.

... better layering or separation of drivers.

So, thinking that converting from a custom bus to a platform bus
definitely is /not/ a positive step forward.

(Why mfd was ever allowed to re-use the platform bus stuff is a separate
question not relevent to these patches.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
