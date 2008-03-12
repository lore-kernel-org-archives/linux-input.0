From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Regression with a Mac (on a "Geyser")
Date: Wed, 12 Mar 2008 11:07:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803121104140.7266@twin.jikos.cz>
References: <20080311222500.b9329708.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:36708 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYCLKI0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2008 06:08:26 -0400
In-Reply-To: <20080311222500.b9329708.zaitcev@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org, alex@malexmedia.net

On Tue, 11 Mar 2008, Pete Zaitcev wrote:

> One of my users is hitting a problem with the touchpad on a Mac
> dying after a period of time. Although it's possible that an
> application action is involved, we have established that kernel
> 2.6.23 works, but 2.6.24 fails.
> Would Johannes or someone versed in HID be so kind to look at this:
>  https://bugzilla.redhat.com/show_bug.cgi?id=435419

Well, this touchpad is handled by 'appletouch' module, so 
hid/usbhid/hiddev shouldn't be involved at all. Does the user even have 
the hid modules loaded?

I'd try to revert 2a3e480d4b to see whether it fixes the problem for that 
user.

-- 
Jiri Kosina
SUSE Labs

