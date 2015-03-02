From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Tue, 03 Mar 2015 00:52:39 +0200
Message-ID: <1968183.sojkhep644@avalon>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2747724.u7aGnnSiv7@avalon> <20150302064049.GA1401@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150302064049.GA1401@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

(CC'ing Dmitry)

On Monday 02 March 2015 07:40:49 Wolfram Sang wrote:
> On Thu, Feb 26, 2015 at 04:27:49PM +0200, Laurent Pinchart wrote:
> > On Monday 26 January 2015 13:09:47 Wolfram Sang wrote:
> >>>>> If you drop adi,adxl346, checkpatch will start complaining if it
> >>>>> encounters it in a .dts.
> >>>> 
> >>>> Boah, this is annoying. That means we need an 346 entry even if it
> >>>> is not different from 345 (which is fine by me).
> >>>
> >>> To be clear: you need the entry in the documentation. It can be
> >>> omitted from the driver if it's not (yet) used for matching.
> >> 
> >> Well, I don't really like that behaviour, but I don't like
> >> i2c/trivial-devices.txt as well, so I'll just apply the patch and live
> >> with it :)
> > 
> > What happened to this patch ?
> 
> My idea was that Dmitry takes them both because they are related:
> 
> http://article.gmane.org/gmane.linux.drivers.i2c/21763

I'm fine with that. Dmitry ?

-- 
Regards,

Laurent Pinchart
