From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: Baantoo multi-touch screen trouble
Date: Fri, 13 Apr 2012 14:30:24 +0100
Message-ID: <201204131430.24672.tvrtko.ursulin@onelan.co.uk>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204131033.00596.tvrtko.ursulin@onelan.co.uk> <alpine.LNX.2.00.1204131442050.16373@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [195.8.89.34] ([195.8.89.34]:55624 "EHLO
	claranet-outbound-smtp01.uk.clara.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751473Ab2DMNao (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 09:30:44 -0400
In-Reply-To: <alpine.LNX.2.00.1204131442050.16373@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Friday 13 Apr 2012 13:42:24 Jiri Kosina wrote:
> On Fri, 13 Apr 2012, Tvrtko Ursulin wrote:
> > > Oops, I think I assumed that the features that will come in 3.4 are
> > > already in 3.3... sorry.
> > > 
> > > Once hid-multitouch is loaded, you have to manually tell him to handle
> > > your device:
> > > # echo 3 2453 0100 0 >
> > > /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id
> > > 
> > > That should do the trick.
> > 
> > Yep, that makes it work.
> > 
> > Thanks for your help!
> > 
> > If you would want to have any additional data about this panel just
> > shout, I will have access to it for a couple of more days.
> 
> Guys, who of you is going to send me patch adding the device ID into
> in-kernel list?

It is unlikely to be me unless someone explains to me in detail what needs to 
be done, at which point it is probably quicker for that person to do it. I for 
example don't even understand why this, allegedly HID Multitouch class 
compliant, device needs explicit adding? Is it not compliant after all? Is it 
that multiple HID devices it exposes a non-standard thing? Does it then need a 
vendor specific class (looking at hid-multitouch.c). Sorry this whole area is 
just new and unknown to me.

Tvrtko
