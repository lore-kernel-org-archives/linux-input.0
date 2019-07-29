From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: applespi - Fix build error
Date: Mon, 29 Jul 2019 16:04:38 +0200
Message-ID: <20190729140438.GA2372@penguin>
References: <20190729031455.59400-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729031455.59400-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: ronald@innovation.ch, nikolas@gnu.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 29, 2019 at 11:14:55AM +0800, YueHaibing wrote:
> If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
> building fails:
> 
> drivers/input/keyboard/applespi.o: In function `applespi_probe':
> applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'
> 
> Wrap it in LEDS_CLASS macro to fix this.

No, we should add "depends on LEDS_CLASS" to the Konfig instead.

Thanks.

-- 
Dmitry
