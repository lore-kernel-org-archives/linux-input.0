From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Sun, 20 Nov 2011 10:36:07 -0800
Message-ID: <20111120183607.GA18116@core.coreip.homeip.net>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
 <20111114172809.GD12659@core.coreip.homeip.net>
 <4EC94254.8000700@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63724 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab1KTSgU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Nov 2011 13:36:20 -0500
Received: by ggnr5 with SMTP id r5so1618610ggn.19
        for <linux-input@vger.kernel.org>; Sun, 20 Nov 2011 10:36:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC94254.8000700@emcraft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

On Sun, Nov 20, 2011 at 10:09:24PM +0400, Ilya Yanok wrote:
> Hi Dmitry,
> 
> one quick question before I repost the updated patch:
> 
> On 14.11.2011 21:28, Dmitry Torokhov wrote:
> >> +err0:
> >> +	dev_set_drvdata(&client->dev, NULL);
> > 
> > Not needed.
> 
> Do you really think leaving a pointer to a non-existing structure is a
> good idea?

I2C core takes care of clearing it after remove() or failed probe().

Thanks.

-- 
Dmitry
