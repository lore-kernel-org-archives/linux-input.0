From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: wacom - Allow any multi-input Intuos device
 to set prox
Date: Thu, 4 Oct 2012 00:25:19 -0700
Message-ID: <20121004072519.GC14217@core.coreip.homeip.net>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
 <CAF8JNhKrkbLCTLUpsWJVCbgtdaDSYa1S7tdH=KHi=LXXc2Ac7w@mail.gmail.com>
 <CANRwn3Qjx75e5tXu0bSredFOrscYJ2SuWZ+myU=866Aa0tTzmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60996 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab2JDHZ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Oct 2012 03:25:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so224218pad.19
        for <linux-input@vger.kernel.org>; Thu, 04 Oct 2012 00:25:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANRwn3Qjx75e5tXu0bSredFOrscYJ2SuWZ+myU=866Aa0tTzmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, chris@cnpbagwell.com

Hi Jason,

On Mon, Oct 01, 2012 at 10:09:24AM -0700, Jason Gerecke wrote:
> On Fri, Sep 28, 2012 at 2:18 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > On Thu, Sep 6, 2012 at 3:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> >> The ability to set the proximity flag should apply to any device
> >> that has both pen and touch input. Rather than listing classes of
> >> devices known to meet this criteria, simply filter on the quirk
> >> defining all such devices.
> >>
> >> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> >
> > Tested-by: Ping Cheng <pingc@wacom.com> for the whole set.
> >
> > Dmitry, do you have questions about this patchset and "input: wacom:
> > Report correct touch contact size for I5/Bamboo"? We hope they can be
> > merged soon since we have more patches coming.
> >
> > Thank you.
> >
> > Ping
> >
> The 24HD touch patches from September 6th as well ("Input: wacom - Add
> touch sensor support for Cintiq 24HD touch"). I was hoping to get them
> accepted before yesterday's 3.7 merge window opened.
> 

Could you please take a peek at my 'next' branch and see if anything
wacom-related is missing?

Thanks!

-- 
Dmitry
