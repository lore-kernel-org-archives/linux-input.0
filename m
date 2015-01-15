From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 13:50:53 -0800
Message-ID: <20150115215053.GF19367@dtor-ws>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <6357346.RjFSG892rq@avalon>
 <20150115210632.GE19367@dtor-ws>
 <2883445.zFsE3pF3jL@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2883445.zFsE3pF3jL@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 15, 2015 at 11:34:00PM +0200, Laurent Pinchart wrote:
> On Thursday 15 January 2015 13:06:32 Dmitry Torokhov wrote:
> > On Thu, Jan 15, 2015 at 10:34:29PM +0200, Laurent Pinchart wrote:
> > > On Thursday 15 January 2015 21:00:37 Geert Uytterhoeven wrote:
> > > > On Thu, Jan 15, 2015 at 7:54 PM, Dmitry Torokhov wrote:
> > > > > I still do not understand what we are trying to fix here. Why is
> > > > > "adi,adxl34x" compatible string no good anymore? If we start using
> > > > > exact models and the physical device does not match do we abort probe?
> > > > > What is the problem that we are solving here?
> > > > 
> > > > Because there's no guarantee that the driver actually supports all
> > > > "adi,adxl34<x>" with <x> = 0..9, some of which don't exist yet.
> > 
> > So, what? When we encounter such devices and decide that we actually
> > want a different driver for them (instead of enhancing the existing one)
> > we'll give them their own compatible string. It's not like "adi,adxl348"
> > will automatically match with "adi,adxl34x", is it?
> 
> Please remember that compatible strings shouldn't be decided based on a 
> particular operating system implementation.

In this case we can never have generic compatible strings of whatever
since in 10 years there might appear an OS that handles them
differently. Let's be a bit realistic here as well.

> 
> > > That's one of the reasons. Another one is that the adxl34x driver won't
> > > match DT nodes that list the "adi,adxl34x" compatible value in positions
> > > other than the first.
> > 
> > Will it match anything else in the position other than 1st (i.e.
> > if device has compatible sting like "adi,adxl345-1", "adi,adxl345")?
> > Why "adi,adxl34x" is special?
> 
> The problem on the driver side is that the automatic I2C DT compatible to 
> device name matching implementation only tries to match with the first 
> compatible string without looking at the other ones. The driver thus needs to 
> be enhanced with an explicit OF match table to be able to match on DT nodes 
> that specify "adi,adxl345" or "adi,adxl346" as the first compatible entry.

Why don't we enhance I2C core instead to do proper matching?

-- 
Dmitry
