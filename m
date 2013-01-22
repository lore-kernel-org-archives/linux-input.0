From: Brad Tilley <brad@16s.us>
Subject: Re: PROBLEM: 3.8.0-rc4 keyboard failure at boot
Date: Tue, 22 Jan 2013 09:05:32 -0500
Message-ID: <20130122140532.GB27683@16s.us>
References: <20130121213604.GA31225@16s.us>
 <20130122001346.GD16638@core.coreip.homeip.net>
 <alpine.LNX.2.00.1301221122380.20374@pobox.suse.cz>
 <20130122121947.GB27072@16s.us>
 <alpine.LNX.2.00.1301221341550.20374@pobox.suse.cz>
 <20130122134658.GA27683@16s.us>
 <alpine.LNX.2.00.1301221449090.20374@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxout-07.mxes.net ([216.86.168.182]:45718 "EHLO
	mxout-07.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3AVOFf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 09:05:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1301221449090.20374@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, Jan 22, 2013 at 02:51:08PM +0100, Jiri Kosina wrote:
> On Tue, 22 Jan 2013, Brad Tilley wrote:
> 
> > > Could you please provide dmesg output from both working and non-working 
> > > case?
> > 
> > See attached. Two dmesgs from the same machine. One from 3.7.3, the 
> > other from 3.8-rc4 (with a ps2 keyboard). USB keyboards on this machine 
> > never work with 3.8, but always works with 3.7.
> > 
> > I used an old ps2 keyboard to enter the dm-crypt password. After that, 
> > the boot process continues and the USB keyboard and mouse become active 
> > and begin to work. However, USB keyboards do not work when the user is 
> > prompted to enter the dm-crypt decryption password early in the boot 
> > process. That's the primary issue.
> 
> Ah, I see, that's a very important piece of information. This might be 
> related to USB BIOS handoff then.
> 
> Do you happen to have "Legacy USB" option (or similar, such as "USB 
> emulation" the name is not consistent between different BIOS vendors and 
> versions) in your BIOS? Does toggling it change the behavior?

3.6 and 3.7 kernels on the same machine work with the standard BIOS settings. We did flash the BIOS to the latest revision when the issue was first noticed with 3.8 kernels. I do not see such a setting in the BIOS, and as I said, earlier kernels work just fine with the existing BIOS settings.

To me, this seems like a race condition. Sometimes USB keyboards work when the user is prompted to enter the dm-crypt password, other times they do not. The problem never occurs on single-core machines (that we have noticed), only occurs about 50% of the time on AMD multi-core machines and 100% of the time on Intel multi-core machines. And none of the machine have encountered the issue with 3.6 or 3.7 kernels.

The possibility of a race condition is just a guess on my part and may be incorrect. I did not mention it earlier as I did not want to misguide you.

Brad

