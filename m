From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - add missing compatible strings
 to OF device table
Date: Wed, 2 May 2018 20:36:43 +0200
Message-ID: <79d51c87-65c8-8cb6-039c-933b114e86cb@redhat.com>
References: <20180410095340.24074-1-javierm@redhat.com>
 <20180501184853.GB52077@dtor-ws>
 <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
 <20180501205713.GA130399@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501205713.GA130399@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-input@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 05/01/2018 10:57 PM, Dmitry Torokhov wrote:
> From: Javier Martinez Canillas <javierm@redhat.com>
> 
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
> 
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
> 
> So add compatible strings for each of the entries in the I2C device table.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [dtor: document which compatibles are deprecated and should not be used]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks for taking care of this. Yes, I should had added as deprecated indeed.

Best regards,
Javier
