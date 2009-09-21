From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] input/keyboard: new driver for
 ADP5520 MFD PMICs
Date: Mon, 21 Sep 2009 11:23:46 -0700
Message-ID: <20090921112346.12832b27.akpm@linux-foundation.org>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org>
	<20090919233044.8361a912.akpm@linux-foundation.org>
	<8bd0f97a0909201540t25dd2337o15ebe63a2a9ca4ec@mail.gmail.com>
	<20090920210451.60ad1b1f.akpm@linux-foundation.org>
	<8bd0f97a0909210640q3ead3467gcccac227a9088d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753120AbZIUSYj@vger.kernel.org>
In-Reply-To: <8bd0f97a0909210640q3ead3467gcccac227a9088d76@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-input@vger.kernel.org

On Mon, 21 Sep 2009 09:40:46 -0400 Mike Frysinger <vapier.adi@gmail.com> wrote:

> On Mon, Sep 21, 2009 at 00:04, Andrew Morton wrote:
> > On Sun, 20 Sep 2009 18:40:41 -0400 Mike Frysinger wrote:
> >> On Sun, Sep 20, 2009 at 02:30, Andrew Morton wrote:
> >> > On Thu, 17 Sep 2009 14:24:10 -0400 Mike Frysinger wrote:
> >> >> +struct adp5520_keys {
> >> >> + __ __ struct input_dev *input;
> >> >> + __ __ struct notifier_block notifier;
> >> >> + __ __ struct device *master;
> >> >> + __ __ unsigned short keycode[ADP5520_KEYMAPSIZE];
> >> >
> >> > Where is ADP5520_KEYMAPSIZE defined?
> >>
> >> all these things are in the common mfd adp5520 patch. __it introduces a
> >> common adp5520 header.
> >
> > err, what common MFD patch? __There was nothing in either the changelog
> > nor the patch title which indicated that this patch had a dependency on
> > other patches. __This makes things harder for mergers and reviewers,
> > especially when the patchset hits multiple subsystems, maintained by
> > multiple developers.
> >
> > Probably the best way to handle this sort of thing is to present it as a
> > sequence-numbered patch series with well-chosen cc's and an overall
> > description of the dependencies and perhaps the merge plan in [patch
> > 0/n].
> 
> the MFD patch has been sent to the MFD guy already for review.  being
> an MFD means it touches like 4 or 5 different subsystems.  but the
> only dependency is on the MFD core.

What you said has nothing to do with what I said.

As the patch was presented, Dmitry or I could well have merged it only
to find out that it doesn't compile.
