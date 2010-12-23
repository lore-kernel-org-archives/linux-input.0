From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for the built-in digitizer in the Lenovo W700
Date: Thu, 23 Dec 2010 01:33:22 -0800
Message-ID: <20101223093321.GA30823@core.coreip.homeip.net>
References: <1293046395-2264-1-git-send-email-pinglinux@gmail.com>
 <20101222194703.GA15605@core.coreip.homeip.net>
 <AANLkTi=ptjY6N9Le8ern=jgwCj0k5exZ+5giaDd_hLr-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58770 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab0LWJd3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Dec 2010 04:33:29 -0500
Received: by iyi12 with SMTP id 12so4822474iyi.19
        for <linux-input@vger.kernel.org>; Thu, 23 Dec 2010 01:33:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ptjY6N9Le8ern=jgwCj0k5exZ+5giaDd_hLr-@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ajay Ramaswamy <ajay@ramaswamy.net>

On Wed, Dec 22, 2010 at 11:56:16AM -0800, Ping Cheng wrote:
> On Wed, Dec 22, 2010 at 11:47 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Dec 22, 2010 at 11:33:15AM -0800, Ping Cheng wrote:
> >> From: Ajay Ramaswamy <ajay@ramaswamy.net>
> >>
> >> The patch is based on git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> >>
> >> Signed-off-by: Ajay Ramaswamy <ajay@ramaswamy.net>
> >> Reviewed-by: Ping Cheng <pingc@wacom.com>
> >
> > Don't we need to add HID blacklist for this as well?
> 
> I thought about that as well (I don't have a system to test with).
> Ajay told me that he did not need to do anything in hid-core.c for his
> tablet to work. He has been using/testing the tablet for more than 4
> months.
> 
> Hopefully, we'll get more feedback from the community when the patch
> gets in the tree.
> 

OK, fair enough, applied.

Thanks everyone.

-- 
Dmitry
