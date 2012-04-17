From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: Baantoo multi-touch screen trouble
Date: Tue, 17 Apr 2012 13:12:23 +0100
Message-ID: <201204171312.23650.tvrtko.ursulin@onelan.co.uk>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204131430.24672.tvrtko.ursulin@onelan.co.uk> <alpine.LNX.2.00.1204171106500.16373@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:34994 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754799Ab2DQMMa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 08:12:30 -0400
In-Reply-To: <alpine.LNX.2.00.1204171106500.16373@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Tuesday 17 Apr 2012 10:07:19 Jiri Kosina wrote:
> On Fri, 13 Apr 2012, Tvrtko Ursulin wrote:
> > > Guys, who of you is going to send me patch adding the device ID into
> > > in-kernel list?
> > 
> > It is unlikely to be me unless someone explains to me in detail what
> > needs to be done, at which point it is probably quicker for that person
> > to do it. I for example don't even understand why this, allegedly HID
> > Multitouch class compliant, device needs explicit adding? Is it not
> > compliant after all? Is it that multiple HID devices it exposes a
> > non-standard thing? Does it then need a vendor specific class (looking
> > at hid-multitouch.c). Sorry this whole area is just new and unknown to
> > me.
> 
> Could you please verify that the patch below works for you? Thanks.


Works fine. I made a typo in the thread subject, one too many 'o' in vendor's 
name - Baanto is correct.

Thanks,

Tvrtko

P.S. I still do not understand why it is needed to explicitly add this device 
for it to work, but nevermind, I asked this enough time to know when to give 
up.
