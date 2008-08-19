From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Tue, 19 Aug 2008 16:04:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808191603350.3391-100000@iolanthe.rowland.org>
References: <681431.40736.qm@web82201.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56226 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753952AbYHSUEp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 16:04:45 -0400
In-Reply-To: <681431.40736.qm@web82201.mail.mud.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: juanslayton@dslextreme.com, Aivils Stoss <aivils@latnet.lv>, jkosina@suse.cz, lud <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linuxconsole-dev@lists.sourceforge.net, linux-input@vger.kernel.org

On Tue, 19 Aug 2008, David Brownell wrote:

> The OHCI scheduling is pretty simple and compact.  I'd think it would
> be easy enough to make UHCI do the same sort of thing:  track bandwidth
> assigned to 2^N frames (OHCI hardware imposes a smaller limit for N
> than UHCI hardware does), and pick the least loaded of those frames to
> use for new transfers.  In ohci-q.c see balance(), periodic_{,un}link().
> 
> Thing is that would involve changing how UHCI manages periodic transfers;
> assuming it hasn't changed those structures since last I looked.

Yes.  That's the messy part; the scheduling itself is easy.

Alan Stern

