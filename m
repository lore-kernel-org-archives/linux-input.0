From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/6] hid: Introduce device groups
Date: Mon, 30 Apr 2012 10:44:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204301043340.1856@pobox.suse.cz>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1204301032410.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53213 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab2D3IoX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 04:44:23 -0400
In-Reply-To: <alpine.LNX.2.00.1204301032410.1856@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 30 Apr 2012, Jiri Kosina wrote:

> > Here is the third version of the extension to the device-driver
> > matching mechanism. AFAICT, there are no outstanding issues. I think
> > we are getting close. :-)
> 
> I think so, and overall I like the aproach and the implementation. Thanks!
> 
> Just got the stacktrace on [1] though when running kernel with this 
> patchset. The trace popped during shutdown, and the machine froze 
> completely; I didn't have any kind of external console connected, so 
> unfortunately I don't have the beginning of the whole thing.
> 
> I haven't been able to reproduce it so far. This was after several 
> "parallel" plug/remove cycles of multiple HID devices driven by multiple 
> different drivers.
> 
> I haven't performed any analysis what this might be yet.
> 
> [1] http://www.jikos.cz/jikos/junk/autoloading-trace.jpg

It actually seems to be spinlock lockup (due to the NMI trigger being 
apparent at the very first line) on kbd_event_lock ...

-- 
Jiri Kosina
SUSE Labs
