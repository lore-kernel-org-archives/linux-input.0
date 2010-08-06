From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] input: cy8ctmg100_ts: signedness bug
Date: Fri, 6 Aug 2010 09:40:49 +0200
Message-ID: <20100806074049.GQ9031@bicker>
References: <20100806063006.GM9031@bicker> <20100806064609.GA27764@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34426 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911Ab0HFHmA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 03:42:00 -0400
Content-Disposition: inline
In-Reply-To: <20100806064609.GA27764@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Aug 05, 2010 at 11:46:09PM -0700, Dmitry Torokhov wrote:
> 
> Thanks Dan. It looks like cy8ctmg110_write_regs has siilar issue. Do you
> thiks the following will work?
> 
> Thanks.
> 

Ah right.  That should be signed as well.  Thanks.

regards,
dan carpenter


