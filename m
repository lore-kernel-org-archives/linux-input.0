From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 02:04:12 -0700
Message-ID: <200904200204.12612.dmitry.torokhov@gmail.com>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com> <20090420082513.GC21187@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:14142 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZDTJES (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 05:04:18 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1802894rvb.1
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2009 02:04:17 -0700 (PDT)
In-Reply-To: <20090420082513.GC21187@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben-linux-arm@fluff.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

On Monday 20 April 2009 01:25:13 Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2009 at 04:10:28PM -0700, Dmitry Torokhov wrote:
> > Hi Russell,
> >
> > On Sat, Apr 18, 2009 at 03:20:50PM +0100, Russell King wrote:
> > > +static int __init lx_keyb_init(void)
> > > +{
> > > +	printk(KERN_INFO "LX Keyboard Driver, (c) 2004 Simtec
> > > Electronics\n");
> >
> > Is this needed? Input core will already add printk when input device is
> > added and our boot is already chatty enough...
>
> Simtec themselves would need to remove that line.

Umm, why? We not removing copyright notice from the file, just the
message...

-- 
Dmitry
