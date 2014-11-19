From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] hid: sony: Use kernel allocated buffers for HID
 reports
Date: Wed, 19 Nov 2014 10:24:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411191024480.4454@pobox.suse.cz>
References: <1415819409-4408-1-git-send-email-frank.praznik@oh.rr.com> <20141113235830.GB40569@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50065 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaKSJYx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2014 04:24:53 -0500
In-Reply-To: <20141113235830.GB40569@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org, ao2@ao2.it

On Thu, 13 Nov 2014, Dmitry Torokhov wrote:

> On Wed, Nov 12, 2014 at 02:10:09PM -0500, Frank Praznik wrote:
> > Replace stack buffers with kernel allocated buffers for sending
> > and receiving HID reports to prevent issues with DMA transfers
> > on certain hardware.
> > 
> > Output report buffers are allocated at initialization time to avoid
> > excessive calls to kmalloc and kfree.
> > 
> > Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Now applied, thanks guys.

-- 
Jiri Kosina
SUSE Labs
