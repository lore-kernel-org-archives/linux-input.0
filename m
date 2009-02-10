From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech MX5000 extra keys
Date: Tue, 10 Feb 2009 11:31:15 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902101113360.11630@jikos.suse.cz>
References: <1233948279.8950.75.camel@cookie.hadess.net>  <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz> <1234179115.8950.3991.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41600 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbZBJKbT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 05:31:19 -0500
In-Reply-To: <1234179115.8950.3991.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Mon, 9 Feb 2009, Bastien Nocera wrote:

> Problem is that it's not just a mapping problem, as the keys don't get 
> out of the kernel at all. The code in hid-lg.c looks more like what's 
> required. Not sure whether the magic is the same to enable the extra 
> keys on this keyboard.

It's possible (and, in fact, quite probable), that quirk similar (or even 
the very same) to what is implemented in lg_report_fixup() would be 
neeeded.

You can verify by adding the VID/PID of your device to struct 
hid_device_id lg_devices[] with LG_RDESC flag.

-- 
Jiri Kosina
SUSE Labs
