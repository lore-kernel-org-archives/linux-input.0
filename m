From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] input: pegasus_notetaker: add license information
Date: Sun, 26 Nov 2017 09:59:51 +0100
Message-ID: <20171126085951.GA10018@kroah.com>
References: <20171118084518.8437-1-martink@posteo.de>
 <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>
Cc: Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Nov 25, 2017 at 04:42:59PM -0800, Dmitry Torokhov wrote:
> Hi Martin,
> 
> On Sat, Nov 18, 2017 at 09:45:18AM +0100, Martin Kepplinger wrote:
> > This adds an SPDX license identifier to this driver I wrote some time back.
> > 
> > Signed-off-by: Martin Kepplinger <martink@posteo.de>
> > ---
> >  drivers/input/tablet/pegasus_notetaker.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> > index 47de5a81172f..cdf75c989469 100644
> > --- a/drivers/input/tablet/pegasus_notetaker.c
> > +++ b/drivers/input/tablet/pegasus_notetaker.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Should this be GPL-2.0+? The MODULE_LICENSE specifies that the module is
> "GPL" which in kernel land means GPLv2+. Or we should change the module
> license to strict "GPLv2"?

That is up to Martin, given that he is the author, as to what he wants
to mark this as.  Odd that it missed the big "fix up all files with no
license information" sweep.

Philippe, how did we miss this one?

> Also, why do we use C++ -style comments for this?

That is what Linus wants, see the thread on lkml in the past few hours
for his reasoning here.

> Greg, do you have any plans on dropping MODULE_LICENSE() altogether and
> generating the appropriate string from SPDX markings in the source?

At this time, no, it's not a simple solution as it gets messy quickly
(multiple c files make up modulues, what about .h files, etc...)

> Doing this would prevent mismatches between license notices, SPDX tags
> and MODULE_LCENSE() strings, which happen very often.

I agree, but now that we are getting SPDX tags, we can fix up all of the
mismatches in MODULE_LICENSE() strings, of which there are a lot.

thanks,

greg k-h
