From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: hid-multitouch: Switch to device groups
Date: Wed, 15 Aug 2012 10:38:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208151037280.7026@pobox.suse.cz>
References: <20120808134408.GA25857@elgon.mountain> <20120808172829.GA1001@polaris.bitmath.org> <20120808180758.GC3734@mwanda> <20120808195429.GA1425@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33841 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab2HOIiP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 04:38:15 -0400
In-Reply-To: <20120808195429.GA1425@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org

On Wed, 8 Aug 2012, Henrik Rydberg wrote:

> > > > This is a semi-automatic email about new static checker warnings.
> > > > 
> > > > The patch 4fa3a5837b84: "HID: hid-multitouch: Switch to device 
> > > > groups" from May 1, 2012, leads to the following Smatch complaint:
> > > > 
> > > > drivers/hid/hid-multitouch.c:735 mt_probe()
> > > > 	 error: we previously assumed 'id' could be null (see line 694)
> > > 
> > > Yes, and the same patch also removes the reason 'id' could be null.
> > 
> > Great.  Could you remove the unneeded check in mt_probe() and give
> > me a Reported-by: tag?
> 
> Ok, now I get it - I was pretty sure that test was not in mainline
> anymore, but obviously I was wrong. Jiri, here is a patch for it, at
> your convenience.

Applied, thanks Dan, thanks Henrik.

-- 
Jiri Kosina
SUSE Labs
