From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Sat, 22 Nov 2014 11:02:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411221100220.23393-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1411221043060.23393-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44096 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750783AbaKVQC7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Nov 2014 11:02:59 -0500
In-Reply-To: <Pine.LNX.4.44L0.1411221043060.23393-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

On Sat, 22 Nov 2014, Alan Stern wrote:

> There is no USB wrapper for pm_runtime_idle calls, but one could be
> added.  Still, in the meantime can you check to see what happens if you
> add
> 
> 	pm_runtime_idle(&usbhid->intf->dev);
> 
> in usbhid_close() just after needs_remote_wakeup is set to 0?  You can 
> do the same thing in usbhid_stop() if you want.

Come to think of it, we probably need

	pm_runtime_idle(usbhid->intf->dev->parent);

in addition to the function call above.  When a USB wrapper is written,
it can take care of these details.

Alan Stern

