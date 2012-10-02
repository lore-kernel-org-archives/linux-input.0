From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/10] Input: bu21013_ts - Request a regulator that
 actually exists
Date: Tue, 2 Oct 2012 11:16:23 +0200
Message-ID: <CACRpkdatjOMxS_pQNPQjoNXgSTYhh7iQoxhKGzdTL=bdQMtwvg@mail.gmail.com>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
	<1349165603-24401-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51279 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab2JBJQZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 05:16:25 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so361446wgb.1
        for <linux-input@vger.kernel.org>; Tue, 02 Oct 2012 02:16:24 -0700 (PDT)
In-Reply-To: <1349165603-24401-4-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently the BU21013 Touch Screen driver requests a regulator by the
> name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> correct name, as referenced in platform regulator code is 'avdd'. Here,
> when we request a regulator, we use the correct name instead.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Mark Brown requested this (real) name of the regulator a while back.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This should go separately into the -rc fixes or directly upstream.

Yours,
Linus Walleij
