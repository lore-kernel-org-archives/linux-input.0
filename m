From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC] input: Add new driver for GPIO beeper
Date: Wed, 21 Nov 2012 10:40:33 -0800
Message-ID: <20121121184033.GC18950@core.coreip.homeip.net>
References: <1353511962-21883-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55031 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab2KUSkh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 13:40:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2275871pad.19
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 10:40:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353511962-21883-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Alexander,

On Wed, Nov 21, 2012 at 07:32:42PM +0400, Alexander Shiyan wrote:
> This patch adds a new driver for the beeper controlled via GPIO pin.
> The driver does not depend on the architecture and is positioned as
> a replacement for the specific drivers that are used for this function,
> for example drivers/input/misc/ixp4xx-beeper.
> Since this patch is only RFC, comments are welcome.

This looks reasonable, but if it is to be a generic solution it should
handle GPIOs that need sleep so you need to schedule a work item from
event() and toggle gpio from there.

Thanks.

-- 
Dmitry
