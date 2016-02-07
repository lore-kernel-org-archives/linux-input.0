From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Pull USB plug while fftest on PS4 pad --> Kernel panic
Date: Sun, 7 Feb 2016 20:59:54 +0100
Message-ID: <20160207205954.965227df774b56a6a23f2463@ao2.it>
References: <n932md$odm$1@ger.gmane.org>
	<n97j48$219$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:51679 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcBGUAE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Feb 2016 15:00:04 -0500
In-Reply-To: <n97j48$219$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: linux-input@vger.kernel.org

On Sun, 7 Feb 2016 15:08:08 +0100
Manuel Reimer <Manuel.Spam@nurfuerspam.de> wrote:

> Hello,
>

Hi Manuel,

> I did some more testing (now with a virtual machine).
> 
> I've updated to Kernel version 4.4.1. The problem stays the same.
> 
> Then I tried with a PS3 controller and (as somehow expected, as the same 
> driver is involved), I have the same problem.
>

I'll try to reproduce the issue with a PS3 controller then.

> The kernel panic, directly after unplugging, only occured once, but the 
> following is 100% reproducible:
> 
> - Open fftest and run some effect on the controller.
> - Unplug the controller while fftest is still running. It doesn't matter 
> if an effect is still playing.
> - After doing so, plug *any* USB HID game controller, you like. I used 
> some cheap noname controller. For me plugging whatever USB HID game 
> controller finally crashes the kernel with 100% success rate.
> 
> So it seems to be the case, that the hid-sony module somehow breaks 
> parts deeper in the USB HID stack in the kernel.
> 
> This problem doesn't occur with the xpad driver and a Xbox 360 gamepad, 
> so it is no general problem which happens with every supported game 
> controller.
> 
> Any feedback would be nice. Am I in the right mailing list for bug reports?
>

You are. However when reporting crashes you get more chances to have
people looking at the issue if you paste the exact "Oops" text from the
kernel logs.

You can see it with "dmesg" or with "journactl -k" maybe passing "-b -1"
to the latter if you need to look at the log from the previous boot.

If you wanted to try looking at the issue yourself, here is a brief
tutorial on how to debug some kinds of kernel crashes:

http://ao2.it/it/blog/2010/11/02/bug-hunting-linux-kernel-land-unpretentious-primer

Ciao ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
