From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Fri, 29 Jan 2010 10:39:59 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1001291039350.15694@twin.jikos.cz>
References: <1263833399.20565.2905.camel@localhost.localdomain>  <1263886149.5591.166.camel@localhost.localdomain>  <1263897015.20565.3988.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
 <1264037759.1735.5008.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com> <1264719198.29532.3149.camel@localhost.localdomain> <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43650 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab0A2JkD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 04:40:03 -0500
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gunn, Brian" <bgunn@solekai.com>
Cc: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>

On Thu, 28 Jan 2010, Gunn, Brian wrote:

> > > > I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> > > > HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?
> > >
> > > Actually for my application it doesn't.  I use HIDP_TRANS_DATA |
> > HIDP_DATA_RTYPE_OUTPUT.
> > >
> > > Perhaps allowing the user the choice of what do to here is more flexible.
> >
> > Except that it would mean different code for USB and Bluetooth
> > versions...
> 
> So do we need a method of setting which device reports we're sending before writing them?

Having separate methods for feature and output reports should be 
sufficient and general enough, right?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

