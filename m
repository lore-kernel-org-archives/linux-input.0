From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 09:25:13 +0100
Message-ID: <20090420082513.GC21187@n2100.arm.linux.org.uk>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44843 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbZDTIZn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 04:25:43 -0400
Content-Disposition: inline
In-Reply-To: <20090418231018.GA32346@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Dooks <ben-linux-arm@fluff.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Sat, Apr 18, 2009 at 04:10:28PM -0700, Dmitry Torokhov wrote:
> Hi Russell,
> 
> On Sat, Apr 18, 2009 at 03:20:50PM +0100, Russell King wrote:
> > +static int __init lx_keyb_init(void)
> > +{
> > +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec Electronics\n");
> 
> Is this needed? Input core will already add printk when input device is
> added and our boot is already chatty enough...

Simtec themselves would need to remove that line.
