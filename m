From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Touchpad toggle mess
Date: Sat, 06 Nov 2010 17:17:04 +0000
Message-ID: <1289063824.5418.95.camel@novo.hadess.net>
References: <1288915209.5418.72.camel@novo.hadess.net>
	 <20101106153031.GA2215@piware.de>
	 <1289059101.5418.93.camel@novo.hadess.net>
	 <20101106163339.GE2215@piware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:57145 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0KFRRP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 13:17:15 -0400
In-Reply-To: <20101106163339.GE2215@piware.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Pitt <martin.pitt@ubuntu.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-hotplug@vger.kernel.org, xorg@lists.freedesktop.org, Peter Hutterer <peter.hutterer@who-t.net>, Matthew Garrett <mjg59@srcf.ucam.org>

On Sat, 2010-11-06 at 12:33 -0400, Martin Pitt wrote:
> Hello Bastien,
> 
> Bastien Nocera [2010-11-06 15:58 +0000]:
> > No, for about a year:
> > http://cgit.freedesktop.org/xkeyboard-config/commit/?id=1d05eda8dfc706d6450cab5883120e0d5e1100c0
> 
> Ah, right, I missed that it didn't actually work all the way up to the
> session, only at the evdev level.
> 
> > You don't need to update gnome-settings-daemon. gnome-settings-daemon
> > doesn't see F21, F22 or F23, it'll see XF86TouchpadOn, etc.
> 
> Ah, ok.
> 
> So, that makes a lot of sense then, I committed your patch with a
> little more verbiage in the changelog. It would be nice if we could
> get the X.org counterpart in as well, so that the udev keymaps and
> X.org don't run out of sync.

We actually need 2 patches into X, one for adding the keysyms, one for
setting the keysyms to the Function keys.

