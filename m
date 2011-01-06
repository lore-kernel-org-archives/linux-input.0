From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v2] input: tegra-kbc - Add tegra keyboard driver
Date: Thu, 6 Jan 2011 14:27:14 -0800
Message-ID: <20110106142714.f823dea8.rdunlap@xenotime.net>
References: <1294351512-17035-1-git-send-email-riyer@nvidia.com>
	<alpine.LNX.2.00.1101062311340.13988@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.115.56]:39036 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754590Ab1AFW1Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 17:27:16 -0500
Received: from chimera.site ([173.50.240.230]) by xenotime.net for <linux-input@vger.kernel.org>; Thu, 6 Jan 2011 14:27:15 -0800
In-Reply-To: <alpine.LNX.2.00.1101062311340.13988@swampdragon.chaosbits.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Rakesh Iyer <riyer@nvidia.com>, tsoni@codeaurora.org, shubhrajyoti@ti.com, ccross@android.com, konkers@android.com, olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 6 Jan 2011 23:15:01 +0100 (CET) Jesper Juhl wrote:

> > +fail:
> > +	if (kbc->irq >= 0)
> > +		free_irq(kbc->irq, pdev);
> > +	if (kbc->idev)
> > +		input_free_device(kbc->idev);
> 
> As far as I can tell input_free_device() deals gracefully with being 
> passed a null pointer, so the 'if' seems superfluous.
> 
> 
> -- 
> Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
> Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please.
+ Please trim replies to the relevant part(s) of patches.


thnx,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
