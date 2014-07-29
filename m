From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHES v2] Add support for more Huion tablets
Date: Tue, 29 Jul 2014 11:22:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291121530.16390@pobox.suse.cz>
References: <53CFC950.90703@gmail.com> <1406133117-29243-1-git-send-email-spbnick@gmail.com> <CAN+gG=EPK-KENSFBYLEaX_OzaAUHrvU=1mnBgmPoCQgM9rLuXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39945 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbaG2JWE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 05:22:04 -0400
In-Reply-To: <CAN+gG=EPK-KENSFBYLEaX_OzaAUHrvU=1mnBgmPoCQgM9rLuXA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Mon, 28 Jul 2014, Benjamin Tissoires wrote:

> > This is the second version of the patch set adding support for more Huion
> > tablets [1].
> >
> > This version has the "hid: huion: Invert in-range on specific product" patch
> > removed as requested by Benjamin Tissoires.
> >
> > Tested with Huion H610N.
> >
> > Nick
> >
> > [PATCH 1/4] hid: huion: Use "tablet" instead of specific model
> > [PATCH 2/4] hid: huion: Don't ignore other interfaces
> > [PATCH 3/4] hid: huion: Switch to generating report descriptor
> > [PATCH 4/4] hid: huion: Handle tablets with UC-Logic vendor ID
> >
> >  drivers/hid/hid-core.c  |   2 +-
> >  drivers/hid/hid-huion.c | 265 ++++++++++++++++++++++++++++++++----------------
> >  drivers/hid/hid-ids.h   |   2 +-
> >  3 files changed, 177 insertions(+), 92 deletions(-)
> >
> > [1] http://thread.gmane.org/gmane.linux.kernel.input/37187
> 
> Just so that the info does not get lost, the v2 of the patch series is still:
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Queuing for 3.17, thanks.

-- 
Jiri Kosina
SUSE Labs
