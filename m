From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 18/26] Input: synaptics-rmi4: Add SPI transport driver
Date: Mon, 9 Nov 2015 14:17:37 +0100
Message-ID: <CACRpkdb2RdLUWv1kykDi-RBA0PVM7QfRkyLB4oRC0CUmW+Wjzg@mail.gmail.com>
References: <1446766900-31032-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35996 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbKINRh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:17:37 -0500
Received: by oiww189 with SMTP id w189so74922671oiw.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:17:37 -0800 (PST)
In-Reply-To: <1446766900-31032-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:41 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Add a transport driver for devices using RMI4 over SPI.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>


>  .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  57 +++

Split off bindings in a separate patch and send to
devicetree@vger.kernel.org

This binding
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +config RMI4_SPI
> +       tristate "RMI4 SPI Support"
> +       depends on RMI4_CORE && SPI
> +       help
> +         Say Y here if you want to support RMI4 devices connected to a SPI
> +         bus.
> +
> +         If unsure, say N.

It never hurts to put Mark Brown on CC for SPI drivers.
The patch looks good to me (TM)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
