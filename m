From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] Input: samsung-keypad: Add support for pinctrl
Date: Thu, 6 Dec 2012 20:29:14 +0100
Message-ID: <CACRpkdYjmpB7gPd-z9pia=R2NQPxkeVegpKDrLfViET+2=UOXA@mail.gmail.com>
References: <1354789126-28304-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:51254 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423225Ab2LFT3P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Dec 2012 14:29:15 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2625523eaa.19
        for <linux-input@vger.kernel.org>; Thu, 06 Dec 2012 11:29:14 -0800 (PST)
In-Reply-To: <1354789126-28304-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kgene.kim@samsung.com, patches@linaro.org

On Thu, Dec 6, 2012 at 11:18 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> Added support for pin configuration using pinctrl subsystem
> to the Samsung keypad driver.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

So we've tried to add some pinctrl default fetchers into the input drivers
and Dmitry don't like sprinking calls like that all over the drivers so
we're trying to come up with some other scheme.

I sent one patch that tried to pick the pinctrl handles by using
notifiers but it doesn't work basically due to probe deferral.

So next approach will be to try and modify the device core to
fetch default pinctrl states.

You might try to lobby Dmitry to accepting this in the meantime,
as a stepping stone. (I'm OK with it, Acked-by).

Yours,
Linus Walleij
