From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: mms114: Use devm_* APIs
Date: Thu, 17 Jan 2013 00:30:48 -0800
Message-ID: <20130117083048.GA15384@core.coreip.homeip.net>
References: <1357723353-11144-1-git-send-email-sachin.kamat@linaro.org>
 <50ED3CC0.10302@nvidia.com>
 <20130109170549.GA7564@core.coreip.homeip.net>
 <CAK9yfHx+YqmoQ6qyDjdhu=dGrkMi_3kSjP+dVAYxAWwj0e-=jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58115 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab3AQIav (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 03:30:51 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so1267268pbc.18
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 00:30:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAK9yfHx+YqmoQ6qyDjdhu=dGrkMi_3kSjP+dVAYxAWwj0e-=jQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 17, 2013 at 08:28:15AM +0530, Sachin Kamat wrote:
> Hi Dmitry,
> 
> On 9 January 2013 22:35, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Jan 09, 2013 at 03:17:44PM +0530, Laxman Dewangan wrote:
> >> On Wednesday 09 January 2013 02:52 PM, Sachin Kamat wrote:
> >> >devm_* APIs are device managed and make the exit and clean up code
> >> >simpler.
> >> >
> >> >Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> >Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> >> >---
> >>
> >> Acked-by: Laxman Dewangan<ldewangan@nvidia.com>
> >>
> >
> > Applied, thank you.
> 
> I did not find this patch in your tree at [1].
> Or did I look in the wrong place?
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=shortlog;h=refs/heads/next

No, apparently I forgot to push my branch out. Should be there now.

-- 
Dmitry
