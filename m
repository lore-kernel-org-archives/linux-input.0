From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Baantoo multi-touch screen trouble
Date: Tue, 17 Apr 2012 14:19:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204171418310.16373@pobox.suse.cz>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204131430.24672.tvrtko.ursulin@onelan.co.uk> <alpine.LNX.2.00.1204171106500.16373@pobox.suse.cz> <201204171312.23650.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898Ab2DQMTn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 08:19:43 -0400
In-Reply-To: <201204171312.23650.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Tue, 17 Apr 2012, Tvrtko Ursulin wrote:

> > > It is unlikely to be me unless someone explains to me in detail what
> > > needs to be done, at which point it is probably quicker for that person
> > > to do it. I for example don't even understand why this, allegedly HID
> > > Multitouch class compliant, device needs explicit adding? Is it not
> > > compliant after all? Is it that multiple HID devices it exposes a
> > > non-standard thing? Does it then need a vendor specific class (looking
> > > at hid-multitouch.c). Sorry this whole area is just new and unknown to
> > > me.
> > 
> > Could you please verify that the patch below works for you? Thanks.
> 
> Works fine. I made a typo in the thread subject, one too many 'o' in vendor's 
> name - Baanto is correct.

Thanks, I will fix that up before applying.

> P.S. I still do not understand why it is needed to explicitly add this device 
> for it to work, but nevermind, I asked this enough time to know when to give 
> up.

Because currently there is no way how to auto-load proper module if the 
device is multitouch. Henrik is working in this area.

-- 
Jiri Kosina
SUSE Labs
