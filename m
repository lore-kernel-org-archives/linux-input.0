From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atkbd - Fix broken keyboard in another LG laptop
Date: Thu, 11 Sep 2014 10:03:44 -0700
Message-ID: <20140911170344.GA13083@core.coreip.homeip.net>
References: <1410372374-11591-1-git-send-email-jsagarribay@gmail.com>
 <20140910205213.GD38736@core.coreip.homeip.net>
 <87mwa6xfnv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47901 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbaIKRDt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 13:03:49 -0400
Content-Disposition: inline
In-Reply-To: <87mwa6xfnv.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaime Velasco Juan <jsagarribay@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, Sheng-Liang Song <ssl@chromium.org>

On Thu, Sep 11, 2014 at 05:53:08PM +0100, Jaime Velasco Juan wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
> > Hi Jamie,
> >
> > On Wed, Sep 10, 2014 at 07:06:14PM +0100, Jaime Velasco Juan wrote:
> >> This model has the same quirk as others, see 3d725caa9dcc "Input:
> >> atkbd - fix keyboard not working on some LG laptops"
> >> 
> >
> > How about the patch below instead?
> >
> 
> It works for me just the same, thanks.

Thanks, I'll add you as also "tested-by" and queue for the next push.

-- 
Dmitry
