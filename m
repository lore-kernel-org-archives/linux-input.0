From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] input: remove use of gpiochip_remove() retval
Date: Wed, 8 Oct 2014 14:31:48 +0200
Message-ID: <CACRpkdYneTDfzd_Y8UMnEpvA9r4rJjKtyzme9VTadT8U_C8SWw@mail.gmail.com>
References: <1412087693-8277-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:51393 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbaJHMbs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 08:31:48 -0400
Received: by mail-ig0-f170.google.com with SMTP id hn18so1477507igb.5
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2014 05:31:48 -0700 (PDT)
In-Reply-To: <1412087693-8277-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Sep 30, 2014 at 4:34 PM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:

> Get rid of using return value from gpiochip_remove() as it returns
> void.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

A similar patch is already ACKed by Dmitry and merged in the GPIO tree.

Yours,
Linus Walleij
