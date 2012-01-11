From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] Input: nomadik-ske-keypad - do not assign driver's
 probe() method
Date: Wed, 11 Jan 2012 10:24:21 +0100
Message-ID: <CACRpkdZKYRGcLsfgexkV2rnsek5V1uL-w1LzeLodpzAjGi0yBg@mail.gmail.com>
References: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:56289 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755599Ab2AKJYV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 04:24:21 -0500
Received: by obbup16 with SMTP id up16so581564obb.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 01:24:21 -0800 (PST)
In-Reply-To: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Wed, Jan 11, 2012 at 8:35 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Because we are using platform_device_probe() to register the driver
> we do not need to assign driver's probe method. We also can mark
> ske_keypad_probe(), together with ske_keypad_chip_init(), as __init
> instead of __devinit.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Dmitry!
Linus Walleij
