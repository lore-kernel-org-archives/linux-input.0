From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] Input: gpio_keys - convert to use devm_*
Date: Tue, 25 Feb 2014 09:46:15 +0100
Message-ID: <CACRpkdb0Bay_kaknN-Vk55OzpVvotC=Gz=jPmT_ht_=Jk6o6sA@mail.gmail.com>
References: <1392816071-23839-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1392816071-23839-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:44731 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaBYIqP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Feb 2014 03:46:15 -0500
Received: by mail-ob0-f169.google.com with SMTP id wn1so3244738obc.14
        for <linux-input@vger.kernel.org>; Tue, 25 Feb 2014 00:46:15 -0800 (PST)
In-Reply-To: <1392816071-23839-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Wed, Feb 19, 2014 at 2:21 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This makes the error handling much more simpler than open-coding everything and
> in addition makes the probe function smaller an tidier.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
