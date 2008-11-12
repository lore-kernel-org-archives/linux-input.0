From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Wed, 12 Nov 2008 15:56:51 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811121555490.32143@jikos.suse.cz>
References: <200810311031.39083.oliver@neukum.org> <200810311610.11604.oliver@neukum.org> <alpine.LNX.1.10.0811121547400.32143@jikos.suse.cz> <200811121555.48488.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38692 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752075AbYKLO4x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 09:56:53 -0500
In-Reply-To: <200811121555.48488.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 12 Nov 2008, Oliver Neukum wrote:

> > +	if (!list->hiddev->open++) {
> > +		if (list->hiddev->exist) {
> The order of checks is inverted. If the device no longer exists opening 
> should fail, even if the device is already opened. 

Right.

> Didn't I post a patch that does this? My memory is a bit clouded.

I don't seem to have it, but I have been buried in hundreds of pending 
e-mails after coming back from vacation. So if you have it handy with 
changelog and Signed-off-by, I'd appreciate if you resend it to me. 
Otherwise I'll dig for it a little bit harder.

Thanks,

-- 
Jiri Kosina
