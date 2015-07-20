From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/6] Input: tc3589x-keypad - change name of wakeup property
Date: Mon, 20 Jul 2015 11:21:10 +0200
Message-ID: <CACRpkdaxb9CD5cG6tW=PhEr_f_XRP6OUC=EukwGfoqSjmgU5pA@mail.gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
	<1437179781-21124-7-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437179781-21124-7-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jul 18, 2015 at 2:36 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Wakeup property of device is not Linux-specific, it describes intended
> system behavior regardless of the OS being used. Therefore let's drop
> "linux," prefix, and, while at it, use the same name as I2C bus does:
> "wakeup-source".
>
> We keep parsing old name to keep compatibility with old DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
