From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
 Mouse"(with newly dmesg information)
Date: Thu, 19 Jul 2012 12:47:40 -0700
Message-ID: <20120719194740.GA21315@ubuntu-530U>
References: <20120706113942.40152322.dashing.meng@gmail.com>
 <20120706051141.GA2937@thinkpad-t410>
 <20120707133519.25bf82d4.dashing.meng@gmail.com>
 <20120709144508.GB4985@thinkpad-t410>
 <20120710121627.22558c22.dashing.meng@gmail.com>
 <20120710045714.GA3429@ubuntu-mba>
 <20120715101557.e20a039b.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36701 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab2GSTrn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 15:47:43 -0400
Content-Disposition: inline
In-Reply-To: <20120715101557.e20a039b.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com

On Sun, Jul 15, 2012 at 10:15:57AM +0800, littlebat wrote:
> In the Windows 7 guest OS, the touchpad "Lenovo pointing device"
> disappeared from the hardwares list. And, the log file in Ubuntu 11.10
> has the content below: 
> y@y-PC:~$ cat ./psmouse-reverse/reverse.log 
> S ff
> R fe
> S ff
> R fe
> S ff
> R fe
> S ed
> R fe

>From the outset this doesn't look right. When reset is sent (0xff) the
touchpad should respond with and acknowledge (0xfa) and a couple more
bytes. Something obviously isn't working right, but I'm not sure what.

The only suggestion I have is to start debugging and try to see what's
going wrong. Is the data from the guest OS getting to the hardware okay,
and vice versa? Are you sure you've got the correct device?

Seth
