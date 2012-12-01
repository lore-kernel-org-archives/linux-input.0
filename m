From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys - report initial state when opening the device
Date: Sat, 1 Dec 2012 17:58:09 +0100
Message-ID: <CACRpkdZV9zLds9c7=a6bmtmdRmojmAkvWxz70M6WQp7tcvqC=A@mail.gmail.com>
References: <20121125083121.GA29530@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57651 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab2LAQ6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 11:58:12 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so858329eek.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 08:58:11 -0800 (PST)
In-Reply-To: <20121125083121.GA29530@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Bengt Jonsson <bengt.g.jonsson@stericsson.com>, linux-kernel@vger.kernel.org

On Sun, Nov 25, 2012 at 9:31 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of reporting the initial stage when the device is registered we
> should do it when the device is opened (so there are users).
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Makes perfect sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
