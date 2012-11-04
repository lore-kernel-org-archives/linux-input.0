From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] Input: nomadik-ske-keypad - fixup use of clk
Date: Sun, 4 Nov 2012 19:09:49 +0100
Message-ID: <CACRpkdbDo9BDRG2WSD9NU9AhZ8W206jM+zywfy3PCdo_y741jw@mail.gmail.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
	<1351779602-13818-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41403 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2KDSJv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Nov 2012 13:09:51 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so2573189eek.19
        for <linux-input@vger.kernel.org>; Sun, 04 Nov 2012 10:09:49 -0800 (PST)
In-Reply-To: <1351779602-13818-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Nov 1, 2012 at 3:20 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Do proper error handling for clk and make sure clocks are being
> prepared|unprepared as well as enabled|disabled.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
