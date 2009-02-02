From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.29rc1 breakes usb: hiddev device no longer available
Date: Mon, 2 Feb 2009 13:33:41 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902021333180.22097@twin.jikos.cz>
References: <20090126170130.GG6158@vanheusden.com> <20090126182707.GI6158@vanheusden.com> <200901262005.08168.oliver@neukum.org> <20090127195229.GA6158@vanheusden.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:46952 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbZBBMdr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2009 07:33:47 -0500
In-Reply-To: <20090127195229.GA6158@vanheusden.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 27 Jan 2009, Folkert van Heusden wrote:

> > > > Since version 2.6.29rc1 querying cleware USb devices no longer works.
> > > > 2.6.28 works fine. 2.6.29-rc2 also no longer works.
> > > the is the FAILURE situation (2.6.29-rc*):
> > > open("/dev/usb/hiddev0", O_RDWR)        = 3
> > > ioctl(3, HIDIOCGDEVINFO, 0xbf90c0d8)    = 0
> > > ioctl(3, HIDIOCAPPLICATION, 0)          = -6291455
> > > ioctl(3, HIDIOCGSTRING, 0x804e2c0)      = -1 ENODEV (No such device)
> > Please try this patch.
> Yes, that fixes it! Thanks!

Fixed in Linus' tree now. Thanks,

-- 
Jiri Kosina
SUSE Labs

