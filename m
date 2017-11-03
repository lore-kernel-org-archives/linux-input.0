From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyttsp4 - Fix error on calculating memory size
 passed to krealloc.
Date: Fri, 3 Nov 2017 12:09:39 -0700
Message-ID: <20171103190939.eibdhyg4kqapzdkn@dtor-ws>
References: <1509477598-7010-1-git-send-email-vince.k.kim@gmail.com>
 <CAJRpnq5CtGDHjSpa_mBqsJmZxvdrkAwPYwFk1tM20h4vvEbb4A@mail.gmail.com>
 <20171102235451.wc7l22vpuxr4n32c@dtor-ws>
 <CAJRpnq5CdTk0UHhyN8D-n4U3cutA11KDPYXsRQATc+BHmpzNqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:44319 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdKCTJn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Nov 2017 15:09:43 -0400
Content-Disposition: inline
In-Reply-To: <CAJRpnq5CdTk0UHhyN8D-n4U3cutA11KDPYXsRQATc+BHmpzNqQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vince Kim <vince.k.kim@gmail.com>
Cc: Ferruh Yigit <fery@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 02, 2017 at 08:49:35PM -0700, Vince Kim wrote:
> Hello Dmitry,
> 
> I attached patch with signed-off-by.

*sigh* did you try compile that?

+       if (si->si_ofs.test_ofs <= si->si_ofs.cydata_ofs)
+               dev_err(cd->dev, "%s: invalid offset  test_ofs:%zd, cydata_ofs:%zd \n", __func__, si->si_ofs.test_ofs, si->si_ofs.cydata_ofs);
+               return -EINVAL;
+       }
+

There is an opening curly brace missing. Same goes for the other 3
chunks of the patch. I fixed it up.

> If you need a patch inline, please let me know.

The inline patch formatted according to Documentation/SubmittingPatches
is preferred, but I'd settle on something that compiles.

Thanks.

> 
> Thanks,
> Vince
> 
> 
> 
> 
> On Thu, Nov 2, 2017 at 4:54 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
> 
> > Hi Vince,
> >
> > On Wed, Nov 01, 2017 at 09:13:58PM -0700, Vince Kim wrote:
> > > It looks patch send to the maintainer rejected.
> > >
> >
> > I can take the patch, but I need your signed-off-by please.
> >
> > > Can anyone take a look?
> > >
> > >
> > >
> > > *==============================*
> > >
> > > *Delivery has failed to these recipients or groups:*
> > >
> > > Ferruh Yigit (fery@cypress.com) <fery@cypress.com>
> > > Your message wasn't delivered due to a permission or security issue. It
> > may
> > > have been rejected by a moderator, the address may only accept e-mail
> > from
> > > certain senders, or another restriction may be preventing delivery.
> > > *==============================*
> > >
> > > On Tue, Oct 31, 2017 at 12:19 PM, Vince Kim <vince.k.kim@gmail.com>
> > wrote:
> > >
> > > > There are several places to perform subtraction to calculate buffer
> > > > size such as:
> > > >
> > > > si->si_ofs.cydata_size = si->si_ofs.test_ofs - si->si_ofs.cydata_ofs;
> > > > ...
> > > > p = krealloc(si->si_ptrs.cydata, si->si_ofs.cydata_size, GFP_KERNEL);
> > > >
> > > > Actually, data types of above variables during subtraction are size_t,
> > so
> > > > it is
> > > > unsigned. That means if second operand(si->si_ofs.cydata_ofs) is
> > > > greater than the first operand(si->si_ofs.test_ofs), then resulting
> > > > si->si_ofs.cydata_size could result in an unsigned integer wrap which
> > is
> > > > not desiarable.
> > > >
> > > > The properway to correct this problem is to perform a test of both
> > > > operands to avoid having unsigned wrap.
> > > > ---
> > > >  drivers/input/touchscreen/cyttsp4_core.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/input/touchscreen/cyttsp4_core.c
> > > > b/drivers/input/touchscreen/cyttsp4_core.c
> > > > index beaf61c..eecc7f1 100644
> > > > --- a/drivers/input/touchscreen/cyttsp4_core.c
> > > > +++ b/drivers/input/touchscreen/cyttsp4_core.c
> > > > @@ -201,6 +201,11 @@ static int cyttsp4_si_get_cydata(struct cyttsp4
> > *cd)
> > > >         void *p;
> > > >         int rc;
> > > >
> > > > +       if (si->si_ofs.test_ofs <= si->si_ofs.cydata_ofs)
> > > > +               dev_err(cd->dev, "%s: invalid offset  test_ofs:%zd,
> > > > cydata_ofs:%zd \n", __func__, si->si_ofs.test_ofs,
> > si->si_ofs.cydata_ofs);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         si->si_ofs.cydata_size = si->si_ofs.test_ofs -
> > > > si->si_ofs.cydata_ofs;
> > > >         dev_dbg(cd->dev, "%s: cydata size: %zd\n", __func__,
> > > >                         si->si_ofs.cydata_size);
> > > > @@ -270,6 +275,11 @@ static int cyttsp4_si_get_test_data(struct
> > cyttsp4
> > > > *cd)
> > > >         void *p;
> > > >         int rc;
> > > >
> > > > +       if (si->si_ofs.pcfg_ofs <= si->si_ofs.test_ofs)
> > > > +               dev_err(cd->dev, "%s: invalid offset  pcfg_ofs:%zd,
> > > > test_ofs:%zd \n", __func__, si->si_ofs.pcfg_ofs, si->si_ofs.test_ofs);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         si->si_ofs.test_size = si->si_ofs.pcfg_ofs -
> > si->si_ofs.test_ofs;
> > > >
> > > >         p = krealloc(si->si_ptrs.test, si->si_ofs.test_size,
> > GFP_KERNEL);
> > > > @@ -321,6 +331,11 @@ static int cyttsp4_si_get_pcfg_data(struct
> > cyttsp4
> > > > *cd)
> > > >         void *p;
> > > >         int rc;
> > > >
> > > > +       if (si->si_ofs.opcfg_ofs <= si->si_ofs.pcfg_ofs)
> > > > +               dev_err(cd->dev, "%s: invalid offset  opcfg_ofs:%zd,
> > > > pcfg_ofs:%zd \n", __func__, si->si_ofs.opcfg_ofs, si->si_ofs.pcfg_ofs);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         si->si_ofs.pcfg_size = si->si_ofs.opcfg_ofs -
> > si->si_ofs.pcfg_ofs;
> > > >
> > > >         p = krealloc(si->si_ptrs.pcfg, si->si_ofs.pcfg_size,
> > GFP_KERNEL);
> > > > @@ -367,6 +382,11 @@ static int cyttsp4_si_get_opcfg_data(struct
> > cyttsp4
> > > > *cd)
> > > >         void *p;
> > > >         int rc;
> > > >
> > > > +       if (si->si_ofs.ddata_ofs <= si->si_ofs.opcfg_ofs)
> > > > +               dev_err(cd->dev, "%s: invalid offset  ddata_ofs:%zd,
> > > > opcfg_ofs:%zd \n", __func__, si->si_ofs.ddata_ofs,
> > si->si_ofs.opcfg_ofs);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         si->si_ofs.opcfg_size = si->si_ofs.ddata_ofs -
> > > > si->si_ofs.opcfg_ofs;
> > > >
> > > >         p = krealloc(si->si_ptrs.opcfg, si->si_ofs.opcfg_size,
> > GFP_KERNEL);
> > > > --
> > > > 2.7.4
> > > >
> > > >
> >
> > --
> > Dmitry
> >



-- 
Dmitry
