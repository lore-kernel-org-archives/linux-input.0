From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID bus
Date: Fri, 18 Apr 2008 13:36:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
 <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
 <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz> <480661FE.1040807@gmail.com>
 <20080416164500.ZZRA012@mailhub.coreip.homeip.net> <4806676B.30809@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:41006 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751743AbYDRLgI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 07:36:08 -0400
In-Reply-To: <4806676B.30809@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org

On Wed, 16 Apr 2008, Jiri Slaby wrote:

> > When I added serio bus I had to send patches to Rusty for 
> > module-init-tools... No way around it as far as I understand.
> I have no fear of augmenting the tools, but the regressions. If one 
> compile those as modules, it won't work with older init tools installed, 
> since it won't get loaded. In that way I have been thinking of the 
> option CONFIG_I_HAVE_OLD_MIT which would integrate the drivers into 
> hidbus module or something scary like that.

I don't seem to be smart enough to come up with any clever solution to 
this either.

So please also consider submitting the patch to module-init-tools, thanks.

Maybe introducing CONFIG_HID_COMPAT (which will link everything together 
again) and leaving it there for a few releases might help to leave the 
complaints from users on reasonable level.

Thanks!

-- 
Jiri Kosina
SUSE Labs
