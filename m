From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Thu, 03 Dec 2009 16:53:54 -0500
Message-ID: <4B183372.30104@redhat.com>
References: <20091203194736.GM2970@sliepen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbZLCVyC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2009 16:54:02 -0500
In-Reply-To: <20091203194736.GM2970@sliepen.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guus Sliepen <guus@sliepen.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-input@vger.kernel.org

On 12/3/09 2:47 PM, Guus Sliepen wrote:
> Hello,
>
> Some years ago I wrote a tool called "inputlirc" that translates evdev events
> into LIRC events, to allow remotes that then already used the input system to
> work with LIRC.  At the time, lircd itself could do this, but you had to
> "train" it to "decode" evdev bitstreams. Instead, inputlirc uses a fixed
> mapping between evdev names and LIRC key names, so you don't need to train or
> configure anything.

No longer necessary, there's a proper devinput lircd userspace driver 
that when paired with an lircd.conf (auto-generated based on 
linux/input.h) Just Works.

http://lirc.sourceforge.net/remotes/devinput/lircd.conf.devinput

> It seems that if you want to merge LIRC into the kernel, and have it generate
> standard events,

It already can. If your button names in lircd.conf match button names in 
input.h, lircd can reinject the key presses into the input subsystem via 
uinput.

-- 
Jarod Wilson
jarod@redhat.com
