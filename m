From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: tc3589x-keypad - fix row shift
Date: Mon, 18 Mar 2013 16:32:52 +0100
Message-ID: <CACRpkdb=48VT=RNK7rzeM+eJ3YzDsPAek0oK0ZPk2ACXkXaiCQ@mail.gmail.com>
References: <1363017202-4556-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39836 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab3CRPcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 11:32:53 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so1298188iac.19
        for <linux-input@vger.kernel.org>; Mon, 18 Mar 2013 08:32:52 -0700 (PDT)
In-Reply-To: <1363017202-4556-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-input@vger.kernel.org, rabin@rab.in

On Mon, Mar 11, 2013 at 4:53 PM, Rabin Vincent
<rabin.vincent@stericsson.com> wrote:

> Since 1932811f426fee ("Input: matrix-keymap - uninline and prepare for
> device tree support"), the row_shift used by the driver does not match
> the one used by matrix_keypad_build_keymap(), leading to misdetection of
> keys.  Fix it.
>
> Cc: <stable@vger.kernel.org> # 3.8
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Given that the other patch sent a week ago already made it into the
fixes, was this one missed for some reason? It looks like another
clear regression...

Yours,
Linus Walleij
