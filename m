From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Mon, 13 May 2013 13:55:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305131354220.23038@pobox.suse.cz>
References: <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com> <51891425.5070300@redhat.com> <1367997792.29283.23.camel@smile> <CAN+gG=GFahJ9YG02nFYNyH4dEjkKfD0CMh9hPcdiZ5XyGBrcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36772 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab3EMLzP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 07:55:15 -0400
In-Reply-To: <CAN+gG=GFahJ9YG02nFYNyH4dEjkKfD0CMh9hPcdiZ5XyGBrcSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

On Mon, 13 May 2013, Benjamin Tissoires wrote:

> On Wed, May 8, 2013 at 9:23 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, 2013-05-07 at 16:48 +0200, Benjamin Tissoires wrote:
> >> On 05/07/2013 04:38 PM, Andy Shevchenko wrote:
> >> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> > ---
> >>
> >> I bet it will be easier to track for Jiri if you resend the full series:
> >> - the egalax reordering
> >> - the remove of the duplicate ID
> >>
> >> As mentioned previously, also remove the entry in hid-multitouch (the
> >> one containing MT_CLS_EGALAX, not the _SERIAL one).
> >
> > Then it repeats v1, doesn't it?
> 
> I can not speak for Jiri, but IMO, it's easier to say:
> "Hey Jiri, pick up the patch series  v3 for this topic", instead of
> "Hey Jiri, please pick the patch 1 from v1 and patch 2 from v4 about
> this topic."
> 
> So I would say yes, repeat v1 but add a comment in the cover letter
> explaining the changes (for example, no changes in patch 1/2, patch
> 2/2 amended like this and that).

Yes, exactly, please just do a fresh resend of the series with all the 
feedback incorporated.

Thanks,

-- 
Jiri Kosina
SUSE Labs
