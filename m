From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
 Mouse"(with newly dmesg information)
Date: Mon, 9 Jul 2012 23:57:14 -0500
Message-ID: <20120710045714.GA3429@ubuntu-mba>
References: <20120706113942.40152322.dashing.meng@gmail.com>
 <20120706051141.GA2937@thinkpad-t410>
 <20120707133519.25bf82d4.dashing.meng@gmail.com>
 <20120709144508.GB4985@thinkpad-t410>
 <20120710121627.22558c22.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47778 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab2GJE5S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 00:57:18 -0400
Content-Disposition: inline
In-Reply-To: <20120710121627.22558c22.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com

On Tue, Jul 10, 2012 at 12:16:27PM +0800, littlebat wrote:
> 1, Can you provide a simple tutorial (or web page address) of how to
> reverse-engineer a Linux ALPS driver if possible? I have very basic
> programming knowledge(shell script, read basic C code except hardware
> driver). Maybe, I can provide more detail hardware information about
> this ALPS touchpad in this way?

I did a write-up a while back about how I did it.

http://swapspace.forshee.me/2011/11/touchpad-protocol-reverse-engineering.html

> 2, Is there a tool, it can show the message when I operate on touchpad
> edge scrolling? So, according to the output, it is able to get a dirty
> solution about edge scrolling function of Lenovo G360 touchpad.
> The funciton of "disable touchpad when typing" has a solution using
> python script I have mentioned in the previous posts.

I'm sorry, I can't quite tell what you're asking. If you're asking for a
way to enable edge scrolling without having a functioning touchpad
driver, I don't know of any. I doubt it's even possible to detect that
you're near the edge of the touchpad with only relative motion events.

> 3, If you are interest in this and have time and it is helpful, I can
> provide a root password for this laptop to you and run ssh service for
> you all the time. Then you can operate this laptop via ssh connection
> in this way. You can do anything on this machine even format the
> disk :-)

I'm afraid it's just not practical to do this remotely. Being able to
physically interact with the touchpad is pretty crucial.

Seth
