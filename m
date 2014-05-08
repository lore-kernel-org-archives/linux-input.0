From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 8 May 2014 10:26:35 -0700
Message-ID: <20140508172635.GD11672@core.coreip.homeip.net>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
 <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
 <536963A0.4060506@wwwdotorg.org>
 <536BAA5A.1010809@itdev.co.uk>
 <536BB3C9.8070908@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48570 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaEHR0j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 13:26:39 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so2575819pdj.39
        for <linux-input@vger.kernel.org>; Thu, 08 May 2014 10:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <536BB3C9.8070908@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On Thu, May 08, 2014 at 10:41:45AM -0600, Stephen Warren wrote:
> On 05/08/2014 10:01 AM, Nick Dyer wrote:
> > Stephen Warren wrote:
> >> On 05/06/2014 04:16 PM, Benson Leung wrote:
> >>> Please coordinate with Nick Dyer, who has a long patch series that's
> >>> been approved but not yet merged into the input tree. The few patches
> >>> you've picked from the Chrome OS kernel overlap with his patch series.
> >>
> >> Ah I remember you mentioning that before. Is Nick's work still active?
> >> The link you sent me to the "latest status" was nearly a year ago:
> >>
> >> https://lkml.org/lkml/2013/6/27/311
> > 
> > My latest set of patches for upstream was sent just over a month ago:
> > https://lkml.org/lkml/2014/3/17/403
> > 
> > Dmitry Torokov has signed-off on them but not merged them into his tree
> > yet. It would be good to hear something from him!
> 
> I don't understand the following comment in patch 0 at that link:
> 
> > Hi Dimitry-
> >
> > Here is a set of patches for atmel_mxt_ts that you've already
> > signed-off.
> 
> Surely Dmitry would only have signed off on the patches if he had
> applied them somewhere. I'm puzzled why he would have applied them but
> not pushed them out into linux-next.

I stashed them into a topic branch but never merged it to next because
there were concerns about the firmware loader interface causing long
pauses at startup when driver was built into the kernel. I need to go
over the series again.

Thanks.

-- 
Dmitry
