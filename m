From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/10] Input: bu21013_ts - Move GPIO init and exit
 functions into the driver
Date: Tue, 2 Oct 2012 11:18:32 +0200
Message-ID: <CACRpkdYE1GgLPMjQ-Oz_ap022OykhfK8D7BoN6oTXGYwttxN9A@mail.gmail.com>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
	<1349165603-24401-5-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45503 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2JBJSe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 05:18:34 -0400
Received: by wibhr7 with SMTP id hr7so605217wib.1
        for <linux-input@vger.kernel.org>; Tue, 02 Oct 2012 02:18:33 -0700 (PDT)
In-Reply-To: <1349165603-24401-5-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> These GPIO init and exit functions have no place in platform data.
> Instead they should be part of the driver. This patch moves them to
> their rightful place, which subsequently elevates platform data of
> yet more cruft.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
