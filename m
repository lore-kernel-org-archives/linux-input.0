From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 15/15] Input: synaptics-rmi4 - correct RMI4 spec url
Date: Wed, 5 Feb 2014 17:14:25 -0800
Message-ID: <20140206011424.GC27770@core.coreip.homeip.net>
References: <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-16-git-send-email-courtney.cavin@sonymobile.com>
 <52F1737E.4080509@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50746 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbaBFBO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:14:28 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so1047684pab.3
        for <linux-input@vger.kernel.org>; Wed, 05 Feb 2014 17:14:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52F1737E.4080509@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org

On Tue, Feb 04, 2014 at 03:10:54PM -0800, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >Cc: Christopher Heiny <cheiny@synaptics.com>
> >Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> 
> Acked-by: Christopher Heiny <cheiny@synaptics.com>

Applied, thank you.

> 
> >---
> >  drivers/input/rmi4/rmi_driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> >index 9d8d6ec..9d845a4 100644
> >--- a/drivers/input/rmi4/rmi_driver.c
> >+++ b/drivers/input/rmi4/rmi_driver.c
> >@@ -7,7 +7,7 @@
> >   * The RMI4 specification can be found here (URL split for line length):
> >   *
> >   * http://www.synaptics.com/sites/default/files/
> >- *      511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
> >+ *      511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
> >   *
> >   * This program is free software; you can redistribute it and/or modify it
> >   * under the terms of the GNU General Public License version 2 as published by
> >
> 
> 
> -- 
> 
> Christopher Heiny
> Senior Staff Firmware Engineer
> Synaptics Incorporated

-- 
Dmitry
