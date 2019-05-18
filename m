From: stefano.manni@gmail.com
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add wakeup support
Date: Sat, 18 May 2019 18:55:10 +0200
Message-ID: <6f94097bb9192424f92e055e8af8062b2ae3e19f.camel@gmail.com>
References: <20190517211741.8906-1-stefano.manni@gmail.com>
         <20190517213016.GA93581@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517213016.GA93581@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, 2019-05-17 at 14:30 -0700, Dmitry Torokhov wrote:
> Hi Sefano,
> 
> On Fri, May 17, 2019 at 11:17:40PM +0200, Stefano Manni wrote:
> > Add wakeup support to the maxtouch driver.
> > The device can wake up the system from suspend,
> > mark the IRQ as wakeup capable, so that device
> > irq is not disabled during system suspend.
> 
> This should already be handled by I2C core, see lines after "if
> (client->flags & I2C_CLIENT_WAKE)" in drivers/i2c/i2c-core-base.c.
> 
> Unless there is dedicated wakeup interrupt we configure main
> interrupt
> as wake source.
> 

what's about the other drivers (e.g. ili210x.c) doing like this?
Shall they be purged?

Thank you.
