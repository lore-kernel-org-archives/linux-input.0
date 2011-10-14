From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Date: Fri, 14 Oct 2011 09:56:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110140955030.2036-100000@iolanthe.rowland.org>
References: <201110141018.28446.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41433 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752621Ab1JNN42 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 09:56:28 -0400
In-Reply-To: <201110141018.28446.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Benson Leung <bleung@chromium.org>, jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 14 Oct 2011, Oliver Neukum wrote:

> Am Freitag, 14. Oktober 2011, 09:54:48 schrieb Benson Leung:
> > This patch enables remote wakeup by default on USB mouse
> > devices. This only covers USB mice that support
> > the boot protocol. See commit 3d61510f for the
> > equivalent patch for USB keyboard devices.
> 
> This doesn't loo like a very good idea.
> Firstly your patch introduces gratious change in the hid driver.
> Secondly you are changing the usbmouse driver, which is to
> be used under special circumstances only, only.
> Thirdly a fundamental change like that needs a commit entry
> explaining the reason for the change.

In addition, unlike keyboards, a lot of mice don't work very well when 
they are suspended.  For example, many won't wake up when they are 
moved (especially optical mice) and some don't even wake up when a 
button is pressed.

This patch definitely should not be merged.

Alan Stern

