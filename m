From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Logitech G-series drivers
Date: Thu, 19 Feb 2015 10:48:27 +0100
Message-ID: <20150219104827.7f5d4e38@pluto.restena.lu>
References: <2384594.RyRtmbhCrj@pink>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:52137 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbbBSJsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 04:48:36 -0500
In-Reply-To: <2384594.RyRtmbhCrj@pink>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ciprian Ciubotariu <cheepeero@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Ciprian,

Adding linux-input and Jiri (HID maintainer) to CC.

On Sun, 15 Feb 2015 23:17:27 +0200 Ciprian Ciubotariu wrote:
> I would like to submit to your attention for inclusion in the mainline kernel 
> a series of drivers for a set of Logitech keybord devices. I forked the 
> sources under a GPL/GPLv2 license and performed maintenance and stabilization 
> work on them.
> 
> The repository I am working on is at 
> 
>     https://github.com/CMoH/lg4l
> 
> Short description of the modules and files:
> 
>     - hid-g110 - Logitech G110 (tested)
>     - hid-g13 - Logitech G13 (tested)
>     - hid-g15v2 - Logitech G15, version 2 (tested)
>     - hid-g19 - Logitech G19 (tested)
> 
>     - hid-g15 - Logitech G15 (not tested)
>     - hid-g510 - Logitech G510 - not ready
> 
>     - hid-gcore - common functions for other modules
>     - hid-gfb - framebuffer implementation for on-device displays
>     - hid-ids.h - product IDs 
> 
> I would like the opinion of a kernel developer on the possibility of including 
> these drivers in the kernel. If the answer is favorable, I will prepare a 
> series of patches against the kernel's master branch and work towards them 
> being accepted.

>From a quick look at your github tree the drivers are prepared for
building out-of-tree.

Did you check for older work on Logitech keyboards that has been
proposed on linux-input list some time ago and what is currently
present in Linus' tree?

An overview of the features covered by the drivers would help
understand what the new drivers add (and the differences between all
the covered keyboard variants).
There seem to be individual drivers for each keyboard type.
Are the features so different that distinct drivers are needed or can
the drivers be unified?


If you would like to get the drivers merged please create patches
against upstream tree, eventually starting with support for the
keyboard you own, adding support for the other keyboards in separate
patches.
You could also split your patch based on feature support.

It might be worth exploring the option to organize the driver(s) as a
MFD (multi-function-device) device.

Bruno
