From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] Input: touchscreen: ads7846: add device
 tree bindings
Date: Sun, 30 Jun 2013 20:12:12 -0700
Message-ID: <20130701031212.GB2001@core.coreip.homeip.net>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com>
 <1372626555-29479-2-git-send-email-zonque@gmail.com>
 <20130701013537.GB10755@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65422 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3GADMQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 23:12:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4315660pbb.33
        for <linux-input@vger.kernel.org>; Sun, 30 Jun 2013 20:12:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130701013537.GB10755@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

On Sun, Jun 30, 2013 at 06:35:37PM -0700, Dmitry Torokhov wrote:
>  
> +#ifndef CONFIG_OF

And this of course should be #ifdef, I forgot to change it back...

-- 
Dmitry
