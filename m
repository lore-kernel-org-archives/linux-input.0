From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: synaptics-rmi4: Get IRQ flags from the IRQ subsystem
Date: Fri, 5 Feb 2016 13:40:08 +0100
Message-ID: <CACRpkdYF9BdGLdxOFwZ_OOD2=WHku_biuRDFBCNErZHUbTYJSA@mail.gmail.com>
References: <1454675797-10065-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33944 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcBEMkJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2016 07:40:09 -0500
Received: by mail-oi0-f43.google.com with SMTP id w5so39963192oie.1
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 04:40:08 -0800 (PST)
In-Reply-To: <1454675797-10065-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>
Cc: Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Feb 5, 2016 at 1:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
>  #include <linux/of.h>
> +#include <linux/irq.h>
(...)
> diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c

Ooops maybe I didn't compile the SPI driver. You probably need to
include <linux/irq.h> in rmi_spi.c too.

Tell me if I should send a new version of the patch or if it's OK
like this.

Yours,
Linus Walleij
