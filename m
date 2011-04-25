From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: alps.c patch for Dell E5410?
Date: Mon, 25 Apr 2011 12:19:53 -0400
Message-ID: <4DB59F29.9000503@canonical.com>
References: <4DAF46A2.6050703@mail.usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43077 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab1DYQUB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2011 12:20:01 -0400
In-Reply-To: <4DAF46A2.6050703@mail.usask.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Friesen <cbf123@mail.usask.ca>
Cc: dtor@mail.ru, sebastian_kapfer@gmx.net, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On 04/20/2011 04:48 PM, Chris Friesen wrote:
> Hi everyone,
> 
> I've got an E5410 on which I'm trying to get the touchpad working
> properly. I'm running Fedora 14 with 2.6.35 and by default it's just
> recognized as a mouse.
> 
> I found a patch on the web at:
> https://confluence.nau.edu/display/~cmg238@nau.edu/Recognize+ALPS+Touchpad+on+Dell+E6510+in+Ubuntu
> 
> It appears similar (but not identical) to the patch that was added for
> the HP Pavilion dm3 but then backed out.
> 
> With the patch applied, the kernel appears to recognize it as a
> DualPoint Stick and a DualPoint Touchpad.  On this particular machine
> the stick doesn't seem to be actually wired up, but the trackpad looks
> visually identical to the E6510.
> 
> However, even after it was recognized I haven't yet been able to get
> scrolling to work, and "synclient -m 100" doesn't give anything
> useful--but various comments have led me to wonder if it actually should
> at this point.
> 
> So what's the deal here?  Is someone working on getting full support for
> these things?  Should "synclient -m 100" work?

I don't personally have much news to tell you. I don't have the
hardware, and I've been busy with other work. I won't be able to help
out here.

-- Chase
