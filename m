From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 13:06:32 -0800
Message-ID: <20150115210632.GE19367@dtor-ws>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150115185431.GG33214@dtor-ws>
 <CAMuHMdXrRtgAahaEUh8x61E-koE25VL-6LOJrkjx4_fohKQtwQ@mail.gmail.com>
 <6357346.RjFSG892rq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6357346.RjFSG892rq@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 10:34:29PM +0200, Laurent Pinchart wrote:
> On Thursday 15 January 2015 21:00:37 Geert Uytterhoeven wrote:
> > On Thu, Jan 15, 2015 at 7:54 PM, Dmitry Torokhov wrote:
> > > I still do not understand what we are trying to fix here. Why is
> > > "adi,adxl34x" compatible string no good anymore? If we start using exact
> > > models and the physical device does not match do we abort probe? What is
> > > the problem that we are solving here?
> > 
> > Because there's no guarantee that the driver actually supports all
> > "adi,adxl34<x>" with <x> = 0..9, some of which don't exist yet.

So, what? When we encounter such devices and decide that we actually
want a different driver for them (instead of enhancing the existing one)
we'll give them their own compatible string. It's not like "adi,adxl348"
will automatically match with "adi,adxl34x", is it?

> 
> That's one of the reasons. Another one is that the adxl34x driver won't match 
> DT nodes that list the "adi,adxl34x" compatible value in positions other than 
> the first.

Will it match anything else in the position other than 1st (i.e.
if device has compatible sting like "adi,adxl345-1", "adi,adxl345")?
Why "adi,adxl34x" is special?

Thanks.

-- 
Dmitry
