From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fragmentation of Samsung SoC code (was INPUT][KEYBOARD] Add
	new keypad driver for s3c series SoCs)
Date: Mon, 7 Dec 2009 20:24:28 -0800
Message-ID: <20091208042428.GE11147@core.coreip.homeip.net>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com> <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com> <20090907062658.GS3962@prithivi.gnumonks.org> <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com> <20090907080202.GW3962@prithivi.gnumonks.org> <9c9fda240909070132u64df987cydd5cfacec989819@mail.gmail.com> <20090907093840.GA3962@prithivi.gnumonks.org> <20091020013914.GE24370@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:39163 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935079AbZLHEY0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 23:24:26 -0500
Received: by pxi29 with SMTP id 29so1470860pxi.1
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 20:24:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091020013914.GE24370@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Kyungmin Park <kmpark@infradead.org>, =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAL0UzL+yCvOyEseyghOyekA==?= <ki0351.kim@samsung.com>, =?utf-8?B?6rmA6rWt7KeEL0FQ6rCc67Cc7YyAL0U1L+yCvOyEseyghOyekA==?= <kgene.kim@samsung.com>

Hi,

On Mon, Oct 19, 2009 at 06:39:14PM -0700, Dmitry Torokhov wrote:
> Ressurecting oldish topic...
> 
> On Mon, Sep 07, 2009 at 06:38:40PM +0900, Harald Welte wrote:
> > Hi Kyungmin,
> > 
> > On Mon, Sep 07, 2009 at 05:32:08PM +0900, Kyungmin Park wrote:
> > > 
> > > I think no problem to send several patch or drivers parallel. If so we
> > > can get more feedbacks.
> > 
> > I disagree.  Two departments of Samsung writing two drivers and then submitting
> > them to the mailinglists
> > 
> > 1) makes everyone, esp. the maintainer have to review two drivers
> > 2) confuses the maintainer, as he does not know which one to apply
> > 
> 
> So me being that confused maintainer having to chose between the 2
> drivers is wondering if you guys worked out which driver (if any) should
> go first and if there is an updated version that I need to review and
> apply...
> 

Now that the S3 touchscreen is on the way to Linus (will be in the next
pull request) did you guys get a chance to settle on keybiard driver by
any chance?

-- 
Dmitry
