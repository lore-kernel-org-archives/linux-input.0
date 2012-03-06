From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] Input: max8925_onkey - avoid accessing input device too early
Date: Tue, 6 Mar 2012 16:52:01 +0800
Message-ID: <CAN1soZyMkUEMLXHL_b0fQtnGOEdzjOi7fML-o7uY2zN0HNMi=g@mail.gmail.com>
References: <20120306063135.GB27389@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58960 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506Ab2CFIwD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 03:52:03 -0500
Received: by vcqp1 with SMTP id p1so4196322vcq.19
        for <linux-input@vger.kernel.org>; Tue, 06 Mar 2012 00:52:01 -0800 (PST)
In-Reply-To: <20120306063135.GB27389@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-input@vger.kernel.org

On Tue, Mar 6, 2012 at 2:31 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Input device must be allocated (but not necessarily registered) befor=
e
> requesting IRQs, otherwise there is a chance that IRQ handler fires a=
nd
> tries to reference not yet allocated input device.
>
> Also it makes sense to store relative IRQ numbers in max8925_onkey_in=
fo
> structure as they are needed in suspend/resume which we expect to be
> called more often than probe and remove.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/misc/max8925_onkey.c | =A0 91 +++++++++++++++++-----=
--------------
> =A01 files changed, 44 insertions(+), 47 deletions(-)
>
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
