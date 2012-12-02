From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: Add Apple wireless keyboard 2011 ANSI to special driver
 list
Date: Sun, 2 Dec 2012 21:09:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212022108580.27624@pobox.suse.cz>
References: <20121127151808.30093.1958.reportbug@ari> <1354459103.7995.103.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59618 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2LBUJY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2012 15:09:24 -0500
In-Reply-To: <1354459103.7995.103.camel@deadeye.wl.decadent.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: 694546@bugs.debian.org, Ari Pollak <ari@scvngr.com>, linux-input@vger.kernel.org, Alexey Kaminsky <me@akaminsky.net>

On Sun, 2 Dec 2012, Ben Hutchings wrote:

> Commit 0a97e1e9f9a6 ('HID: apple: Add Apple wireless keyboard 2011 ANSI PID')
> did not update the special driver list in hid-core.c, so hid-generic may
> still bind to this device.
> 
> Reported-by: Ari Pollak <ari@scvngr.com>
> References: http://bugs.debian.org/694546
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks for the fix, appiled.

-- 
Jiri Kosina
SUSE Labs
