From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] Use hid blacklist in usbmouse/usbkbd
Date: Mon, 26 Nov 2007 13:50:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711261348470.19853@twin.jikos.cz>
References: <1196074688.12642.10.camel@plop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:35947 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbXKZMu6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 07:50:58 -0500
In-Reply-To: <1196074688.12642.10.camel@plop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Terjan <pterjan@mandriva.com>
Cc: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

On Mon, 26 Nov 2007, Pascal Terjan wrote:

> That means that if usbmouse is already loaded when a wacom tablet gets 
> plugged it, it will take it. This patch fixes this behaviour by using 
> hid's blacklist in usbmouse and usbkbd, but I don't know much about 
> interactions between hid and usbmouse/usbkbd so I'm not sure this is the 
> correct way to do it.

Hi Pascal,

usbmouse and usbkbd shouldn't be loaded at all on a standard system. These 
modules are pretty non-standard and should be used only in really extreme 
cases.

On the other hand you are right that making them honor the 
HID_QUIRK_IGNORE* blacklist entries makes sense.

Could you please add your Signed-off-by to your patch, so that I can take 
it through my tree?

Thanks,

-- 
Jiri Kosina
