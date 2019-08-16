From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 36/63] Input: atmel_mxt_ts - configure and use gpios
 as real gpios
Date: Fri, 16 Aug 2019 10:24:22 -0700
Message-ID: <20190816172422.GH121898@dtor-ws>
References: <20190816083525.19071-1-jiada_wang@mentor.com>
 <20190816083525.19071-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816083525.19071-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 16, 2019 at 05:34:58PM +0900, Jiada Wang wrote:
> From: Kautuk Consul <kautuk_consul@mentor.com>
> 
> The upstream Atmel mXT driver implementation seems to handle the
> T19 GPIO/PWM object as a key pad. Keys can be defined in the
> device tree ("linux,gpio-keymap") and will be transported as key
> events to the Linux input device if GPIO state changes.
> 
> With our hardware, the GPIO pins of the touch controller are
> connected to a PWM/backlight controller and used as supervision
> inputs. We like to read the status of the pins by a script or an
> application in the sysfs.
> 
> Adding newer sysfs entries which shall be placed in the input
> class directory eg:
> /sys/class/input/input<n>/backlight_error1

No, if you want to export GPIO lines for external use create a gpiochip
instance and register it with GPIO subsystem. No ad-hoc sysfs please.

Thanks.

-- 
Dmitry
