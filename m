From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add wakeup support
Date: Fri, 17 May 2019 14:30:16 -0700
Message-ID: <20190517213016.GA93581@dtor-ws>
References: <20190517211741.8906-1-stefano.manni@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190517211741.8906-1-stefano.manni@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Manni <stefano.manni@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Sefano,

On Fri, May 17, 2019 at 11:17:40PM +0200, Stefano Manni wrote:
> Add wakeup support to the maxtouch driver.
> The device can wake up the system from suspend,
> mark the IRQ as wakeup capable, so that device
> irq is not disabled during system suspend.

This should already be handled by I2C core, see lines after "if
(client->flags & I2C_CLIENT_WAKE)" in drivers/i2c/i2c-core-base.c.

Unless there is dedicated wakeup interrupt we configure main interrupt
as wake source.

Thanks.

-- 
Dmitry
