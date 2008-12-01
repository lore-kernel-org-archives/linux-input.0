From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [patch 3/8] input: ads7846.c sparse lock annotation
Date: Mon, 01 Dec 2008 15:18:48 -0800
Message-ID: <1228173529.5482.9.camel@brick>
References: <200812012220.mB1MKERa012626@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:21299 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYLAXSv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2008 18:18:51 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2881132wfd.4
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2008 15:18:50 -0800 (PST)
In-Reply-To: <200812012220.mB1MKERa012626@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: dtor@mail.ru, linux-input@vger.kernel.org

On Mon, 2008-12-01 at 14:20 -0800, akpm@linux-foundation.org wrote:
> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 

Small nit with this patch I just noticed (sorry).  It's more
conventional to do the annotation in the other order (was done
late after some other annotations), please apply the following instead:

--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -761,6 +761,8 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 
 /* Must be called with ts->lock held */
 static void ads7846_disable(struct ads7846 *ts)
+__releases(&ts->lock)
+__acquires(&ts->lock)
 {
 	if (ts->disabled)
 		return;


