From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Tue, 6 Oct 2015 16:07:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510061606440.2758@pobox.suse.cz>
References: <1443451630-144023-1-git-send-email-mika.westerberg@linux.intel.com> <20150929090431.GA30386@mail.corp.redhat.com> <20150930084557.GE1551@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150930084557.GE1551@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 30 Sep 2015, Mika Westerberg wrote:

> > I would be in favor of applying the patch in its current shape, but if
> > Jiri thinks we need a little bit more caution here, we would need to add
> > a test regarding the Win8 capability here.
> 
> What about adding following on top of this patch? It checks the device
> in question belongs to "win8 class".
> 
> I can send a new version of the patch if this seems reasonable.

If this actually maintains the backwards compatibility for that particular 
device Benjamin mentioned (no idea what mtclass does it have?), I'd be in 
favor of doing that.

Thanks,

-- 
Jiri Kosina
SUSE Labs
