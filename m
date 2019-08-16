From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 31/63] Input: atmel_mxt_ts - add memory access
 interface via sysfs
Date: Fri, 16 Aug 2019 10:29:20 -0700
Message-ID: <20190816172920.GK121898@dtor-ws>
References: <20190816083451.18947-1-jiada_wang@mentor.com>
 <20190816083451.18947-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816083451.18947-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2019 at 05:34:19PM +0900, Jiada Wang wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> Atmel maXTouch chips can be addressed via an "Object Based Protocol" which
> defines how i2c registers are mapped to different functions within the
> chips. This interface exposes the register map and allows user-space
> utilities to inspect and alter object configuration, and to view diagnostic
> data, while the device is running.

I'd say if we want this we should look into write support in regmap and
switching the driver over.

Thanks.

-- 
Dmitry
