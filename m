From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Date: Wed, 17 Jul 2019 06:35:59 +0300
Message-ID: <20190717033559.GB621@penguin>
References: <20190716221929.3782-1-lukma@denx.de>
 <20190716221929.3782-3-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716221929.3782-3-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 17, 2019 at 12:19:28AM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The platform data once was optional, make it optional again. This
> is a first step towards device tree support for the mc13xxx touchscreen
> driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I suppose it will go together with the 1st patch through Lee's MFD tree?

Thanks.

-- 
Dmitry
