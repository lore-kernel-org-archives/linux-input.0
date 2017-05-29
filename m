From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] gpio: adp5588: move header file out of I2C realm
Date: Mon, 29 May 2017 13:37:27 +0200
Message-ID: <CACRpkdbFvN=Xzb3znQLVgjTcAW+stkeNCDLAHrmZWorTWU-kpQ@mail.gmail.com>
References: <20170521215727.1243-1-wsa@the-dreams.de> <20170521215727.1243-4-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170521215727.1243-4-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> This driver could also go via the input-tree or my tree. I don't really care
> and just picked some subsystem :) Let me know if you are okay with that.

Patch applied to the GPIO tree with Dmitry's ACK.

Yours,
Linus Walleij
