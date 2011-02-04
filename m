From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Fri, 4 Feb 2011 12:23:14 +0100
Message-ID: <20110204112314.GA1501@polaris.bitmath.org>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
 <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
 <20110127114727.GA15626@polaris.bitmath.org>
 <87pqrir1r2.fsf@macbook.be.48ers.dk>
 <20110127122625.GD15626@polaris.bitmath.org>
 <87lj26qzyy.fsf@macbook.be.48ers.dk>
 <20110204084652.GB13046@core.coreip.homeip.net>
 <20110204102405.GA1567@polaris.bitmath.org>
 <877hdgrrn7.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:60753 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202Ab1BDLXy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Feb 2011 06:23:54 -0500
Content-Disposition: inline
In-Reply-To: <877hdgrrn7.fsf@macbook.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, baruch@tkos.co.il

>  Henrik> The code below will return -EINVAL even if some parts of the buffer
>  Henrik> was successfully read, though.
> 
> You mean written? I don't see that. The only place we return -EINVAL is
> at the initial check.

Right, it should have been written, and -EFAULT, referring to the code
in the loop.

Henrik
