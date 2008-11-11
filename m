From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Mon, 10 Nov 2008 19:45:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811101939100.15552-100000@netrider.rowland.org>
References: <20081111003117.GA10904@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:1357 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751068AbYKKApa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2008 19:45:30 -0500
In-Reply-To: <20081111003117.GA10904@basil.nowhere.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 11 Nov 2008, Andi Kleen wrote:

> Hi,
> 
> I have a box here which has a couple of USB devices connected.
> That includes several HID devices (keyboards, mouse) and a couple
> of others including a USB powerswitch driven through a user space
> program.
> 
> Now what happened is that I changed some of the HID devices
> around (moving from a direct port to a hub) and also moved
> the USB power switch from one port to another. But after that
> the power switch didn't work anymore, just giving a flood 
> of
> 
> usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
> 
> (sispm is the user space driver)
> 
> Kernel is 2.6.28-rc3

This sounds like a userspace problem.  The sispm program should unbind 
usbhid from interface 0 before trying to set the config.

I don't know why it should start showing up now.  Perhaps you need to 
add the power switch to usbhid's blacklist.

At any rate, you should be able to get it working again by unbinding 
usbhid manually:

	echo -n 2-2:1.0 >/sys/bus/usb/drivers/usbhid/unbind

Alan Stern

