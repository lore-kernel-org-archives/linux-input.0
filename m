From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND: PATCH 1/2] mfd: tc3589x: Add device tree bindings
Date: Mon, 9 Jun 2014 14:14:20 +0200
Message-ID: <CACRpkdbhqoywNyHuXzo2Oqjz5ybcM_DhsRDYy28_qN8K0RYE_w@mail.gmail.com>
References: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:57433 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbaFIMOU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jun 2014 08:14:20 -0400
Received: by mail-oa0-f52.google.com with SMTP id j17so2178170oag.39
        for <linux-input@vger.kernel.org>; Mon, 09 Jun 2014 05:14:20 -0700 (PDT)
In-Reply-To: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>

On Wed, Apr 9, 2014 at 9:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This defines the device tree bindings for the Toshiba TC3589x
> series of multi-purpose expanders. Only the stuff I can test
> is defined: GPIO and keypad. Others may implement more
> subdevices further down the road.
>
> This is to complement
> commit a435ae1d51e2f18414f2a87219fdbe068231e692
> "mfd: Enable the tc3589x for Device Tree" which left off
> the definition of the device tree bindings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Fix the keys/rows bindings to be u32 rather than
>   /bits/ 8, inconsistency noted by Mark Rutland.
> ChangeLog v1->v2:
> - Include a verbose example in the DT bindings.
> - Explain why this is a stand-alone bindings patch.

Lee, ping on this - it seems to have fallen to the floor at some
point...

Yours,
Linus Walleij
