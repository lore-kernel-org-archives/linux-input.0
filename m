From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 2/2] Input: ads7846 - extend the driver for ads7845
 controller support
Date: Wed, 30 Jun 2010 10:45:55 +0200
Message-ID: <20100630104555.2289c731@mw.dip.t-dialin.net>
References: <1272630181-5364-2-git-send-email-agust@denx.de>
	<1277803793-15077-1-git-send-email-agust@denx.de>
	<20100630081805.GD4154@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52607 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab0F3Ip5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 04:45:57 -0400
In-Reply-To: <20100630081805.GD4154@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Detlev Zundel <dzu@denx.de>

On Wed, 30 Jun 2010 01:18:05 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
...
> I just noticed that your previous patch alters pdata which I belive is
> wrong thing to do. Could you please try the following patch and let me
> know if I broke anything?

Yes, altering pdata isn't a good idea. I can't try the patch just now
but will test it this evening.

Thanks,

Anatolij
