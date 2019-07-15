From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Date: Mon, 15 Jul 2019 00:10:48 -0700
Message-ID: <20190715071048.GB153485@dtor-ws>
References: <20190711222346.5245-1-lukma@denx.de>
 <20190711222346.5245-3-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711222346.5245-3-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 12, 2019 at 12:23:45AM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The platform data once was optional, make it optional again. This
> is a first step towards device tree support for the mc13xxx touchscreen
> driver.

I would prefer seeing it together with patches introducing device tree
support.

Thanks.

-- 
Dmitry
