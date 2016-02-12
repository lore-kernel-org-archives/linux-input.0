From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Fri, 12 Feb 2016 13:54:23 +0100
Message-ID: <CACRpkdaE91ncWccG9_dsOiC40j9mFpm7A=S_mpeHmP-vjSVjMQ@mail.gmail.com>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34322 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbcBLMyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 07:54:24 -0500
Received: by mail-ob0-f177.google.com with SMTP id wb13so120081578obb.1
        for <linux-input@vger.kernel.org>; Fri, 12 Feb 2016 04:54:24 -0800 (PST)
In-Reply-To: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On Wed, Feb 10, 2016 at 11:23 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> This is the v5 patch series which fixes the issues identified by kbuild
> and coccinelle in the previous patch series. These include:
>
> - Using ARRAY_SIZE instead of a custom macro to calculate the size of the
>   function handler array.
> - Remove setting the .owner field for the driver in rmi_i2c and rmi_spi
>   since the i2c-core and spi set that field.
> - Fix if statment in rmi_f30 which was testing has_led twice instead of
>   testing has_gpio.

Works like a charm.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
