From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Tue, 19 Jan 2010 15:20:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001191519040.30977@pobox.suse.cz>
References: <1263833399.20565.2905.camel@localhost.localdomain>  <1263886149.5591.166.camel@localhost.localdomain> <1263897015.20565.3988.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38649 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab0ASOU0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 09:20:26 -0500
In-Reply-To: <1263897015.20565.3988.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, bgunn@solekai.com, Ping <pinglinux@gmail.com>

On Tue, 19 Jan 2010, Bastien Nocera wrote:

> On Mon, 2010-01-18 at 23:29 -0800, Marcel Holtmann wrote:
> > Hi Bastien,
> > 
> > > Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
> > > kernel. In the past, it was done in a patch in bluetootd.
> > > 
> > > The first patch is probably completely wrong. Right now,
> > > hid_output_raw_report is done on the intr socket, instead of the ctrl
> > > socket. If it's correct to do it on the intr socket, we'd need to add
> > > some API as a way to select the ctrl socket instead for use in that
> > > driver.
> > 
> > actually the interrupt should be incoming only. So moving the raw output
> > to the control channel seems fine to. Any reason why it is on the
> > interrupt channel in the first place?
> 
> The patch was written by Jiri and tested by Brian. Not sure what sort of
> device Brian tested this with...

Hmm, that's right, ctrl pipe would make much more sense (and this is what 
we do in USB driver as well). I used intr pipe by mistake, but it seems 
that it made things work for Brian anyway, which is quite puzzling.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
