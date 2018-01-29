From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 5/8] Input: mms114 - use lower case for hexadecimal
 values
Date: Tue, 30 Jan 2018 08:41:58 +0900
Message-ID: <20180129234158.GX7575@gangnam.samsung>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p29c39450d723f7d2085fc10a74a74e53c@epcas2p2.samsung.com>
        <20180129113323.18961-6-andi.shyti@samsung.com>
        <20180129185631.wvgl3il6tu6nk7ew@dtor-ws>
        <20180129232923.GW7575@gangnam.samsung>
        <20180129233335.ikqioeetkkvocblm@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20180129233335.ikqioeetkkvocblm@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Jan 29, 2018 at 03:33:35PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 30, 2018 at 08:29:23AM +0900, Andi Shyti wrote:
> > Hi Dmitry,
> > 
> > On Mon, Jan 29, 2018 at 10:56:31AM -0800, Dmitry Torokhov wrote:
> > > On Mon, Jan 29, 2018 at 08:33:20PM +0900, Andi Shyti wrote:
> > > > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > > 
> > > But why?
> > 
> > I think this patch is trivial and the subject itself is quite
> > self-explanatory and the commit message would be a copy-paste of
> > it.
> 
> Here is where we disagree. Why lowercase is preferred over uppercase? Do
> we have this in coding style (and I completely forgot about it)? Or is
> it your preference (mine is too to be fair, but I also do not care
> about churning the code for it)?

I think this is the case where the cultural habits become law, I've
been writing lower case hex values from years and my eyes are so
used to it that it looks wrong to have them written upper case.
Many maintainers reject upper case hex values.

As well as many reject the " ? : " conditional form.

In any case, you're basically right here, at this point I
don't mind if you drop it :)

Thanks,
Andi
