From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Prevent the NULL dereferencing
Date: Wed, 6 Apr 2011 15:31:49 -0700
Message-ID: <20110406223149.GC11611@core.coreip.homeip.net>
References: <1301997495-20876-1-git-send-email-shubhrajyoti@ti.com>
 <4D9AEE22.3050602@ti.com>
 <BANLkTi=m+mmnResbhBKZ+7oeR7RtvrTvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64855 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab1DFWby (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 18:31:54 -0400
Received: by iwn34 with SMTP id 34so1887017iwn.19
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 15:31:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=m+mmnResbhBKZ+7oeR7RtvrTvWw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-input@vger.kernel.org, Shubhrajyoti D <a0393217@india.ti.com>

On Wed, Apr 06, 2011 at 08:47:12PM +0800, Axel Lin wrote:
> 2011/4/5 Shubhrajyoti <shubhrajyoti@ti.com>:
> > On Tuesday 05 April 2011 03:28 PM, shubhrajyoti@ti.com wrote:
> >>
> >> From: Shubhrajyoti D<a0393217@india.ti.com>
> >>
> >>
> >> Signed-off-by: Shubhrajyoti D<a0393217@india.ti.com>
> >
> > Axel's patch added changes to prevent NULL access if pdata is NULL adding a
> > check for keymap_data.
> >>
> 
> Acked-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Shubhrajyoti.

-- 
Dmitry
