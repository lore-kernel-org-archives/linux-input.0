From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform
 data for the Teclast X3 Plus tablet
Date: Tue, 23 Jan 2018 17:02:59 -0800
Message-ID: <20180124010259.GJ16464@fury>
References: <1516706288-177-1-git-send-email-ponces26@gmail.com>
 <1516732419-125-1-git-send-email-ponces26@gmail.com>
 <20180123232754.GC16464@fury>
 <CAKdAkRQWhnNAA72QKmcz6hDw_RUzSzmrRVM_PG_y0dta=VEqhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57731 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbeAXBDC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 20:03:02 -0500
Content-Disposition: inline
In-Reply-To: <CAKdAkRQWhnNAA72QKmcz6hDw_RUzSzmrRVM_PG_y0dta=VEqhA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alberto Ponces <ponces26@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Tue, Jan 23, 2018 at 04:37:43PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 23, 2018 at 3:27 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Tue, Jan 23, 2018 at 06:33:38PM +0000, Alberto Ponces wrote:
> >> Add touchscreen platform data for the Teclast X3 Plus tablet.
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Signed-off-by: Alberto Ponces <ponces26@gmail.com>
> >
> > Queued, thanks.
> >
> > Note for the future: Author signoff goes first, then reviewers, then committer.
> 
> In this case Alberto was the committer, so his sign-off is last, as it
> should be. Any reported-by, suggested-by, acked-by or reviewed-by he
> collected should go above his sign-off. Once you picked up his patch
> you 'll become committer, so any markings you add should go between
> his sign-off and yours.

Of course, you're correct. Thank you for the correction - and Alberto, apologies
for the noise/confusion.

Dmitry, I reviewed documentation/process/submitting-patches.rst and
5.Posting.rst and didn't find this clearly defined. Have I missed where this is
documented, or is an update in order?

-- 
Darren Hart
VMware Open Source Technology Center
