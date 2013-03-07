From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/8] Input: nomadik-ske-keypad: Use module_platform_driver_probe
 macro
Date: Thu, 7 Mar 2013 05:16:52 +0100
Message-ID: <CACRpkdZRrA6eo21BKNzEF8VEoZ=PafjVOZ316XcS=Oy6NeBkMQ@mail.gmail.com>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
	<1362453827-18129-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:65241 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415Ab3CGEQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Mar 2013 23:16:53 -0500
Received: by mail-ia0-f177.google.com with SMTP id y25so38916iay.36
        for <linux-input@vger.kernel.org>; Wed, 06 Mar 2013 20:16:52 -0800 (PST)
In-Reply-To: <1362453827-18129-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 5, 2013 at 4:23 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> module_platform_driver_probe() eliminates the boilerplate and simplifies
> the code.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
