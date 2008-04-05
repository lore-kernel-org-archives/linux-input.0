From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: multi-input quirk and skip output reports quirk
Date: Sat, 5 Apr 2008 08:01:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804050759500.32130@jikos.suse.cz>
References: <20080405055825.EA9F42FE066C@sam.liddicott.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:53946 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750762AbYDEGBC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Apr 2008 02:01:02 -0400
In-Reply-To: <20080405055825.EA9F42FE066C@sam.liddicott.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sam Liddicott <sam@liddicott.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

On Sat, 5 Apr 2008, Sam Liddicott wrote:

> I'm all for setting quirks dynamically from user space during the plug 
> event, as the delay between posting a patch and having it appear in 
> distro of choice can be well over a year which is too long to remember 
> and too long to be useful.

This can be done by using a 'quirks' module parameter to usbhid.

> I do remember that there were two quirks set for the same brand of dual 
> controller and I copied them both to the quad controller. I was asked to 
> check if both quirks were actually needed, I still haven't had the 
> required couple of hours to rebuild my kernel to do this and it became 
> simpler to use the quad controller as a single controller.

You don't have to rebuild if you have a kernel that supports dynamic 
quirks for usbhid.

-- 
Jiri Kosina
SUSE Labs
