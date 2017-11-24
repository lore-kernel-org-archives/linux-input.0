From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/5] gpio: pca953x: Name the gpiochip after the I2C
 address
Date: Fri, 24 Nov 2017 15:26:27 +0100
Message-ID: <20171124142627.GG30167@lunn.ch>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
 <20171124093045.5961-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:34567 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbdKXO03 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 09:26:29 -0500
Content-Disposition: inline
In-Reply-To: <20171124093045.5961-3-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 24, 2017 at 10:30:42AM +0100, Linus Walleij wrote:
> Just putting the name of the I2C device as name for the
> GPIO chip (label) is ambigous, and makes it hard for us
> to use GPIO descriptor tables on systems such as DaVinci
> DA850EVM which has two chips but on I2C address 0x20 and 0x21.
> 
> Instead, append "-XX" to the GPIOchip name using the I2C
> address so we get a unique chip name that can be used
> in descriptor tables, such as "tca6416-20" and
> "tca6416-21" on the DaVinci DA850EVM.

Hi Linus

Are you making the assumption that there are not two devices at the
same address but on different I2C busses?

How safe is that assumption? Can you include the adapter ID in the
string?

	Andrew
