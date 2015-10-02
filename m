From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Fri, 2 Oct 2015 03:34:45 -0700
Message-ID: <CACRpkdaCFgNpHcK9q_rbA5igE3vAnQJeAOkYB0c+a_Grwy2NUA@mail.gmail.com>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34111 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbJBKeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 06:34:46 -0400
Received: by oiev17 with SMTP id v17so55502896oie.1
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 03:34:45 -0700 (PDT)
In-Reply-To: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>

On Mon, Jul 27, 2015 at 6:50 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> In the cases where the gpio chip fails to acquire the current state an
> error is reported back to gpio_keys. This is currently interpreted as if
> the line went high, which just confuses the developer.
>
> This patch introduces an error print in this case and skipps the
> reporting of a input event; to aid in debugging this issue.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
