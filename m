From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/26] Input: synaptics-rmi4 - f11: fix bitmap irq check
Date: Mon, 9 Nov 2015 14:01:41 +0100
Message-ID: <CACRpkdajcd8NnXtstV7jhZMJU+-QgMtr+77S4_Nde-fCwdL8bw@mail.gmail.com>
References: <1446766713-30532-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33662 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbKINBm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:01:42 -0500
Received: by oiad129 with SMTP id d129so98629904oia.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:01:42 -0800 (PST)
In-Reply-To: <1446766713-30532-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:38 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> num_irq_regs is the count of registers of 1 bytes that we use to check
> the irqs. bitmap_and() expects the number of bits.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should just be squashed into the offending commit.

Yours,
Linus Walleij
