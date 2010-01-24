From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: evdev regression on macbook with 2.6.33-rc5
Date: Sun, 24 Jan 2010 01:30:55 -0800
Message-ID: <20100124093055.GA17607@core.coreip.homeip.net>
References: <3d8471ca1001231053k512011dcnfab50052ce3667fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:45097 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0AXJbA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jan 2010 04:31:00 -0500
Content-Disposition: inline
In-Reply-To: <3d8471ca1001231053k512011dcnfab50052ce3667fa@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guillaume Chazarain <guichaz@gmail.com>
Cc: ajax@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi Guillaume,

On Sat, Jan 23, 2010 at 07:53:58PM +0100, Guillaume Chazarain wrote:
> Hi,
> 
> Since 2.6.33-rc5, the keyboard on my MacBookPro 3,1 stopped working
> when using X.
> It works fine in console mode, but in X, pressing keys does not have
> any effect until I hit the touchpad or an USB mouse and then all the
> keystrokes are delivered.
> I'm using the nvidia proprietary drivers on Ubuntu 9.10 x86_64
> (config.gz and dmesg.gz attached).
> 
> A git bisection found this commit as the culprit and reverting it
> indeed fixes the problem:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=30a589fde0162aa4dac7c69803aeee8fbe8d1b82
> 
> commit 30a589fde0162aa4dac7c69803aeee8fbe8d1b82
> Author: Adam Jackson <ajax@redhat.com>
> Date:   Tue Jan 5 17:56:04 2010 -0800
> 
>     Input: evdev - be less aggressive about sending SIGIO notifies
> 
> Thanks.
> 


DOes the same behavior happens when you try using 'evtest' utility while
in console? Also, do you have external USB keyboard by any chance and if
you do does it exibit the same problem?

Thanks.

-- 
Dmitry
