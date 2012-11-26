From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Drop TOUCHSCREEN_BITSY support
Date: Mon, 26 Nov 2012 00:13:12 -0800
Message-ID: <20121126081312.GC21091@core.coreip.homeip.net>
References: <1353852178-4920-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58435 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2KZINQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 03:13:16 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7833562pbc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 00:13:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353852178-4920-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>

Hi Alexander,

On Sun, Nov 25, 2012 at 06:02:57PM +0400, Alexander Shiyan wrote:
> The kernel does not contain the symbol SA1100_BITSY so the driver
> never compiled and can be removed safely.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/touchscreen/Kconfig          |   12 -
>  drivers/input/touchscreen/Makefile         |    1 -
>  drivers/input/touchscreen/h3600_ts_input.c |  479 ----------------------------

I applied the touchscreen part, thank you. The staging piece should go
through Greg KH.

Thanks.

-- 
Dmitry
