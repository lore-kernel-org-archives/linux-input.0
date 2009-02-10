From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Logitech MX5000 extra keys
Date: Tue, 10 Feb 2009 10:54:29 +0000
Message-ID: <1234263269.5677.939.camel@cookie.hadess.net>
References: <1233948279.8950.75.camel@cookie.hadess.net>
	 <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz>
	 <1234179115.8950.3991.camel@cookie.hadess.net>
	 <alpine.LNX.1.10.0902101113360.11630@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33854 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbZBJKyg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 05:54:36 -0500
In-Reply-To: <alpine.LNX.1.10.0902101113360.11630@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Tue, 2009-02-10 at 11:31 +0100, Jiri Kosina wrote:
> On Mon, 9 Feb 2009, Bastien Nocera wrote:
> 
> > Problem is that it's not just a mapping problem, as the keys don't get 
> > out of the kernel at all. The code in hid-lg.c looks more like what's 
> > required. Not sure whether the magic is the same to enable the extra 
> > keys on this keyboard.
> 
> It's possible (and, in fact, quite probable), that quirk similar (or even 
> the very same) to what is implemented in lg_report_fixup() would be 
> neeeded.
> 
> You can verify by adding the VID/PID of your device to struct 
> hid_device_id lg_devices[] with LG_RDESC flag.

I did, but without success (I didn't see the line "fixing up Logitech
keyboard report descriptor" in the kernel logs). In user-space, the
device needs to be poked to get the device to do something when the
extra keys are pressed. I guess something similar is needed here.

I'll leave work on this for a while until I get more time to experiment.

Cheers

