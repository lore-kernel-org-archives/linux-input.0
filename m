From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calibrating a hid device
Date: Mon, 24 May 2010 21:59:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005242151320.8440-100000@netrider.rowland.org>
References: <4BFB03B5.5030404@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53369 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758749Ab0EYB7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 21:59:08 -0400
In-Reply-To: <4BFB03B5.5030404@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-usb@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 24 May 2010, Rafi Rubin wrote:

> Ok, pardon that excessive attachments.  Attached is a snip of the kernel code,
> just the sysfs function, the user space equivalent, and logs of both (with the
> time stamps cropped out for comparison.

Since the logs are the same, up to the point where the interrupt-IN 
request is cancelled, it's logical to assume that the difference was 
caused by something that happened before you began the usbmon traces.

Do it again, only this time start the traces before plugging in the
device.  That way we'll get a complete record.  And don't worry about
cropping out the timestamps; sometimes they reveal useful information.  
For example, here they would have told us if the interrupt-IN request
failed because it timed out too quickly.

> Also please put on slop code filter glasses before reading the code, I hold no
> responsibility to damaged eyes or loss of sanity.  It will be cleaned up, later.

Aside from not using the predefined constants for the bRequestType
values, what stands out most is that you're using I/O buffers allocated
on the stack.  That's a no-no (not all architectures are capable of
doing DMA to stack-based locations); I/O buffers should be allocated
dynamically using kmalloc.

Alan Stern

