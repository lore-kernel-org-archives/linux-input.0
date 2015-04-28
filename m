From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 15/17] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Date: Tue, 28 Apr 2015 21:36:10 +0200
Message-ID: <87618gjb9x.fsf@belgarion.home>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-16-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com> (Dmitry
	Eremin-Solenikov's message of "Tue, 28 Apr 2015 02:55:52 +0300")
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
> space for it on poodle.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
