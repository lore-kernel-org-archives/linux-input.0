From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL][for 3.8] pull request from arch-pxa tree on
 input/keyboard branch
Date: Tue, 20 Nov 2012 22:42:05 -0800
Message-ID: <20121121064205.GA16772@core.coreip.homeip.net>
References: <CAN1soZzDgmGDypbTMiFt+44xO=ZCeojHiyReaPO=vzv+Dpwz+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50313 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2KUGmJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 01:42:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1849037pad.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 22:42:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN1soZzDgmGDypbTMiFt+44xO=ZCeojHiyReaPO=vzv+Dpwz+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Haojian,

On Wed, Nov 21, 2012 at 01:34:58PM +0800, Haojian Zhuang wrote:
> Hi Dmitry,
> 
> Please help to merge input/keyboard branch from arch-pxa git tree.
> There's one patch on pxa27x keypad driver.

This patch is already in mainline:

commit 904adede088f2a6976e417d1d5cf72c9fe686814
Author: Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon Oct 29 23:45:09 2012 -0700

    Input: pxa27x_keypad - clear pending interrupts on keypad config
    
    Bootloader can leave interrupt bit pending, and it confuses driver.
    
    Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
    Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
