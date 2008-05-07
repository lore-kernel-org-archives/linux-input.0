From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 17:49:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805071747210.11363@jikos.suse.cz>
References: <Pine.LNX.4.44L0.0805071145130.3701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47919 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755815AbYEGPtg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2008 11:49:36 -0400
In-Reply-To: <Pine.LNX.4.44L0.0805071145130.3701-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, 7 May 2008, Alan Stern wrote:

> One big problem we always faced with autosuspend for keyboards is that 
> most of them were not able to autoresume quickly enough to avoid losing 
> keystrokes.  Isn't that still a problem?

Hi Alan,

it definitely is, but with autosuspend defaulting to off, and possibility 
of whitelisting known-good keyboards, we (or HAL, respectively) can still 
turn autosupend on those that are known to work properly, and still save 
some power on some systems.

Unfortunately, I vaguely remember that some keyboards exposed the 
behaviors only when connected to certain HCI controllers, so building the 
whitelist might not be completely trivial.

-- 
Jiri Kosina
SUSE Labs
