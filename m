From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: samsung-keypad - Use devm_* functions
Date: Tue, 27 Nov 2012 22:30:34 -0800
Message-ID: <20121128063034.GA23378@core.coreip.homeip.net>
References: <1354010091-31294-1-git-send-email-sachin.kamat@linaro.org>
 <20121127101320.GD25658@core.coreip.homeip.net>
 <20121127101422.GE25658@core.coreip.homeip.net>
 <CAK9yfHwD2gv-F1uMXHtdDTY-OpC-UAnmJC1+LS9fvUMjzbVbxg@mail.gmail.com>
 <CAK9yfHz9HzNGcrW-RWG_mm1ZfTQU8xg5Q-1oi4FQfp6oDB15XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52875 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2K1Gaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 01:30:39 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so6543381pad.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 22:30:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAK9yfHz9HzNGcrW-RWG_mm1ZfTQU8xg5Q-1oi4FQfp6oDB15XA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org, Kukjin Kim <kgene.kim@samsung.com>

On Wed, Nov 28, 2012 at 11:27:35AM +0530, Sachin Kamat wrote:
> Hi Dmitry,
> 
> On 27 November 2012 15:54, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > On 27 November 2012 15:44, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >> On Tue, Nov 27, 2012 at 02:13:21AM -0800, Dmitry Torokhov wrote:
> >>> On Tue, Nov 27, 2012 at 03:24:51PM +0530, Sachin Kamat wrote:
> >>> > devm_* functions are device managed and make error handling
> >>> > and code simpler. While at it also fix error exit paths.
> >>> >
> >>>
> >>> Is this different from the version I sent you?
> >>
> >> Ahh,, I see, there was a typo with extra 'i'... Anything else?
> >
> > No. Just rebased it on top of latest next and updated the commit message a bit.
> 
> Will you be adding this patch to your tree?

Yep, in the process of doing so ;)

Thanks.

-- 
Dmitry
