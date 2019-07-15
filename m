From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Date: Mon, 15 Jul 2019 11:27:57 -0700
Message-ID: <20190715182757.GA136092@dtor-ws>
References: <20190711222346.5245-1-lukma@denx.de>
 <20190711222346.5245-3-lukma@denx.de>
 <20190715071048.GB153485@dtor-ws>
 <20190715104344.3f17b660@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190715104344.3f17b660@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 15, 2019 at 10:43:44AM +0200, Lukasz Majewski wrote:
> Hi Dmitry,
> 
> Thank you for your reply.
> 
> > On Fri, Jul 12, 2019 at 12:23:45AM +0200, Lukasz Majewski wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > The platform data once was optional, make it optional again. This
> > > is a first step towards device tree support for the mc13xxx
> > > touchscreen driver.  
> > 
> > I would prefer seeing it together with patches introducing device tree
> > support.
> 
> Ok, I will merge this patch to patch 3/3.

Uh, I must be missing something, but I do not see anything dedicated to
device tree handling in 3/3...

Thanks.

-- 
Dmitry
