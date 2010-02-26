From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 23/28] keyboard, input: Add hook to input to allow low
 level event clear
Date: Fri, 26 Feb 2010 00:03:29 -0800
Message-ID: <20100226080329.GD17062@core.coreip.homeip.net>
References: <1267132893-23624-1-git-send-email-jason.wessel@windriver.com>
 <1267132893-23624-24-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:49417 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935455Ab0BZIDg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2010 03:03:36 -0500
Content-Disposition: inline
In-Reply-To: <1267132893-23624-24-git-send-email-jason.wessel@windriver.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Henrik Rydberg <rydberg@euromail.se>, Greg Kroah-Hartman <gregkh@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>, linux-input@vger.kernel.org

On Thu, Feb 25, 2010 at 03:21:28PM -0600, Jason Wessel wrote:
> When using a keyboard with kdb, on resuming the system there needs to
> be a hook to allow for the keyboard state to get reset.
> 
> This is mainly because there is no way to force the end user to hold
> down the original keys that were pressed prior to entering kdb.
> 

Instead of adding all the new hook can't you copy the bitmap of
currently pressed keys when you invoke kdb and theni, on exit, use
input_inject_event() to clear bitmasks in the devices?

-- 
Dmitry
