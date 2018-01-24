From: Alberto Ponces <ponces26@gmail.com>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform
 data for the Teclast X3 Plus tablet
Date: Wed, 24 Jan 2018 09:51:28 +0000
Message-ID: <20180124095128.GA2418@NB-003F00054.cmf.criticalmanufacturing.com>
References: <1516706288-177-1-git-send-email-ponces26@gmail.com>
 <1516732419-125-1-git-send-email-ponces26@gmail.com>
 <20180123232754.GC16464@fury>
 <CAKdAkRQWhnNAA72QKmcz6hDw_RUzSzmrRVM_PG_y0dta=VEqhA@mail.gmail.com>
 <20180124010259.GJ16464@fury>
 <20180124011844.k4hfwujev2jkjetk@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124011844.k4hfwujev2jkjetk@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

There is no problem whatsoever!

I'm beginner on this so every correction or warning is welcolme.

Thank you both for your help!

--
Alberto Ponces

On Tue, Jan 23, 2018 at 05:18:44PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 23, 2018 at 05:02:59PM -0800, Darren Hart wrote:
> > On Tue, Jan 23, 2018 at 04:37:43PM -0800, Dmitry Torokhov wrote:
> > > On Tue, Jan 23, 2018 at 3:27 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > > On Tue, Jan 23, 2018 at 06:33:38PM +0000, Alberto Ponces wrote:
> > > >> Add touchscreen platform data for the Teclast X3 Plus tablet.
> > > >>
> > > >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > >>
> > > >> Signed-off-by: Alberto Ponces <ponces26@gmail.com>
> > > >
> > > > Queued, thanks.
> > > >
> > > > Note for the future: Author signoff goes first, then reviewers, then committer.
> > > 
> > > In this case Alberto was the committer, so his sign-off is last, as it
> > > should be. Any reported-by, suggested-by, acked-by or reviewed-by he
> > > collected should go above his sign-off. Once you picked up his patch
> > > you 'll become committer, so any markings you add should go between
> > > his sign-off and yours.
> > 
> > Of course, you're correct. Thank you for the correction - and Alberto, apologies
> > for the noise/confusion.
> > 
> > Dmitry, I reviewed documentation/process/submitting-patches.rst and
> > 5.Posting.rst and didn't find this clearly defined. Have I missed where this is
> > documented, or is an update in order?
> 
> I do not think is was ever stated explicitly, the closest comes "14) The
> canonical patch format" which states that sign off goes before the ---
> divider.
> 
> I think it comes naturally if you consider patch vs pull request: if you
> decided to pull from Alberto's tree (or anyone else's tree) instead of
> taking the patch via email, then if they'd put non-sign-off tags after
> the sign-off, they'd end up in your and then Linus' tree like that, as
> you would not add your sign-off when doing git merge.
> 
> But if you believe this should be called explicitly then adding a few
> more words to section 14 should work.
> 
> Thanks.
> 
> -- 
> Dmitry
