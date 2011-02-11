From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Skip matrix size check
Date: Fri, 11 Feb 2011 09:38:50 -0800
Message-ID: <20110211173849.GB17932@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB605.4080106@atmel.com>
 <20110204085906.GF13046@core.coreip.homeip.net>
 <4D553A61.1090608@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48909 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192Ab1BKRi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 12:38:59 -0500
Received: by iyj8 with SMTP id 8so2641140iyj.19
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 09:38:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D553A61.1090608@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

Hi Iiro,

On Fri, Feb 11, 2011 at 03:32:17PM +0200, Iiro Valkonen wrote:
> 
> Ok, I think the "matrix size check" should be really skipped
> altogether. It is currently setting the CTE mode to match xline/yline
> info that is in the platform data, but it does not take into account
> for example the fact that we could have a key array in use too (key
> array would need some x/y lines too). I think it would be best to just
> rely on the config data, and make sure that the CTE mode set in there
> matches the touch object (touchscreen, key array, proximity)
> configuration (which are set in the config data too). Here's a patch
> removing the check.
> 

OK, this explanation totally makes sense, I will be applying the patch.

Next time please put such reasoning directly into patch's changelog so
that people looking through git history have this information readily
available. Commit changelogs should not only say what has been done (the
first line - subject - reflects that, as well as teh patch itself) but
more importantly _why_ the change has been made.

Thanks.

-- 
Dmitry
