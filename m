From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: add additional checks for the existence of
 optional queries in order to compute the address of Query 12.
Date: Tue, 29 Jul 2014 11:10:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291110090.16390@pobox.suse.cz>
References: <1405114551-24354-1-git-send-email-aduggan@synaptics.com> <20140715190702.GB21045@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140715190702.GB21045@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Jul 2014, Benjamin Tissoires wrote:

> On Jul 11 2014 or thereabouts, Andrew Duggan wrote:
> > There are additional queries which are optional and may not be present depending on the configuration of the firmware. Knowing which queries are present is needed to properly compute the address of Query 12 and all subsequent queries. Additional bits in Query 1 are used to indicate the presence of these optional queries.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > ---
> 
> Looks good to me
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied.

-- 
Jiri Kosina
SUSE Labs
