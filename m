From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] Input: nomadik-ske-keypad - convert to using SIMPLE_DEV_PM_OPS
Date: Wed, 11 Jan 2012 10:25:03 +0100
Message-ID: <CACRpkdZJfXjHC2KRxhWOFBsgGLEzE_VJh=Hn-_GVa4PO=onqmw@mail.gmail.com>
References: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
	<20120111073537.18870.17178.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38456 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab2AKJZF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 04:25:05 -0500
Received: by iabz25 with SMTP id z25so843453iab.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 01:25:03 -0800 (PST)
In-Reply-To: <20120111073537.18870.17178.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org

On Wed, Jan 11, 2012 at 8:35 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Also proper guard for system suspend/resume methods is CONFIG_PM_SLEEP,
> not CONFIG_PM.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
