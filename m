From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC interrupt
Date: Fri, 05 Jun 2015 14:50:18 +0200
Message-ID: <2953428.ar7Re29b0L@wuerfel>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1433402712-21399-1-git-send-email-yvo@apm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Y Vo <yvo@apm.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Phong Vo <pvo@apm.com>, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, patches@apm.com
List-Id: linux-input@vger.kernel.org

On Thursday 04 June 2015 14:25:12 Y Vo wrote:
> GIC is designed to support two of trigger mechanisms - active level
> high or edge rising. But in the gpio_keys driver, it tries to use both
> edge rising and edge falling trigger. This patch fixes the gpio_keys
> driver to request only the edge rising event when failed to configure the
> interrupt.
> 
> Signed-off-by: Y Vo <yvo@apm.com>

I think you want to use an 'interrupts' property instead of a 'gpios'
property (or possibly both), so you can pass the right polarity.

	Arnd
