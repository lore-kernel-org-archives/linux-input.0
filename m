From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Add maxtouch to I2C table for
 module autoload
Date: Fri, 20 Nov 2015 11:15:58 -0800
Message-ID: <20151120191558.GD26895@dtor-ws>
References: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 20, 2015 at 04:09:42PM -0300, Javier Martinez Canillas wrote:
> The Atmel maxtouch DT binding documents that the compatible string for
> the device is "atmel,maxtouch" and the I2C core always reports a module
> alias of the form i2c:alias where alias is the compatible string model:
> 
> $ grep MODALIAS /sys/devices/platform/12e00000.i2c/i2c-8/8-004b/uevent
> MODALIAS=i2c:maxtouch

Do we know why we are not reporting modalias as "of:..." so that
autoloading using the of table works properly?

It sounds like the of matching and modalias is quite a mess at the
moment.

Thanks.

-- 
Dmitry
