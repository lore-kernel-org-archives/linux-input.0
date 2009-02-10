From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech MX5000 extra keys
Date: Tue, 10 Feb 2009 18:13:45 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902101812440.11630@jikos.suse.cz>
References: <1233948279.8950.75.camel@cookie.hadess.net>  <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz>  <1234179115.8950.3991.camel@cookie.hadess.net>  <alpine.LNX.1.10.0902101113360.11630@jikos.suse.cz> <1234263269.5677.939.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:54713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbZBJRNs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 12:13:48 -0500
In-Reply-To: <1234263269.5677.939.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Tue, 10 Feb 2009, Bastien Nocera wrote:

> > You can verify by adding the VID/PID of your device to struct 
> > hid_device_id lg_devices[] with LG_RDESC flag.
> I did, but without success (I didn't see the line "fixing up Logitech 
> keyboard report descriptor" in the kernel logs). In user-space, the 
> device needs to be poked to get the device to do something when the 
> extra keys are pressed. I guess something similar is needed here.

Please compile the kernel with CONFIG_HID_DEBUG, modprobe the hid module 
with 'debug=2' and send me the report descriptor of the device (that 
appears in the dmesg output when the device is connected) as well as the 
output that appears when you press the non-working keys.

-- 
Jiri Kosina
SUSE Labs
