From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 11:56:07 +0100
Message-ID: <20090420105607.GB3653@n2100.arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com> <20090420082513.GC21187@n2100.arm.linux.org.uk> <200904200204.12612.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56487 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZDTK4f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 06:56:35 -0400
Content-Disposition: inline
In-Reply-To: <200904200204.12612.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux-arm@fluff.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Mon, Apr 20, 2009 at 02:04:12AM -0700, Dmitry Torokhov wrote:
> On Monday 20 April 2009 01:25:13 Russell King - ARM Linux wrote:
> > On Sat, Apr 18, 2009 at 04:10:28PM -0700, Dmitry Torokhov wrote:
> > > Hi Russell,
> > >
> > > On Sat, Apr 18, 2009 at 03:20:50PM +0100, Russell King wrote:
> > > > +static int __init lx_keyb_init(void)
> > > > +{
> > > > +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec
> > > > Electronics\n");
> > >
> > > Is this needed? Input core will already add printk when input device is
> > > added and our boot is already chatty enough...
> >
> > Simtec themselves would need to remove that line.
> 
> Umm, why? We not removing copyright notice from the file, just the
> message...

Because it's polite to at least ask them.  I'm just the third party in
this (although I've already done substantial cleaning up of this code.)

They've agreed to remove the line, so it's now gone.
