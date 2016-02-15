From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Mon, 15 Feb 2016 14:48:25 -0800
Message-ID: <CAOCOHw5dywRQNNEtFHDHHVKROJKPQAwFbzRur6w8LnYQWMApZA@mail.gmail.com>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33024 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbcBOWs0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2016 17:48:26 -0500
Received: by mail-ob0-f171.google.com with SMTP id jq7so47898053obb.0
        for <linux-input@vger.kernel.org>; Mon, 15 Feb 2016 14:48:25 -0800 (PST)
In-Reply-To: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On Wed, Feb 10, 2016 at 2:23 PM, Andrew Duggan <aduggan@synaptics.com> wrote:
> This is the v5 patch series which fixes the issues identified by kbuild
> and coccinelle in the previous patch series. These include:
>
> - Using ARRAY_SIZE instead of a custom macro to calculate the size of the
>   function handler array.
> - Remove setting the .owner field for the driver in rmi_i2c and rmi_spi
>   since the i2c-core and spi set that field.
> - Fix if statment in rmi_f30 which was testing has_led twice instead of
>   testing has_gpio.
>
> Thanks,
> Andrew
>
> Andrew Duggan (10):
>   Input: synaptics-rmi4: Add support for Synaptics RMI4 devices
>   Input: synaptics-rmi4: Add I2C transport driver
>   Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
>   Input: synaptics-rmi4: Add support for 2D sensors and F11
>   Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
>   Input: synaptics-rmi4: Add support for F12
>   Input: synaptics-rmi4: Add support for F30
>   Input: synaptics-rmi4: Add SPI transport driver
>   Input: synaptics-rmi4: Add device tree support to the SPI transport
>     driver
>   HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
>

My rmi4 device is powered by two regulators that are left disabled by
the boot, so I have a patch to acquire those and toggle them
appropriately. I plan to send that out once your patches lands.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
