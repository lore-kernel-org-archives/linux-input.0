From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 27 May 2010 22:38:52 -0400
Message-ID: <AANLkTintgcMO_Ew7Up2NrRUGfVuyzTbXBwwr2wcRfFB5@mail.gmail.com>
References: <20100513075728.GF30110@core.coreip.homeip.net>
	<alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org>
	<20100514145539.GA5598@srcf.ucam.org> <alpine.LFD.2.00.1005140814380.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45928 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0E1CjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 22:39:13 -0400
In-Reply-To: <alpine.LFD.2.00.1005140814380.3711@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>

On Fri, May 14, 2010 at 11:16, Linus Torvalds wrote:
> On Fri, 14 May 2010, Matthew Garrett wrote:
>> I've done some experimentation under qemu. On ACPI systems, Windows will
>> *only* touch the keyboard controller if there's a device with an
>> appropriate PNP HID or CID and if _STA evaluates to 0x0b or 0x0f.
>> Otherwise it'll simply ignore the hardware entirely. By the looks of it
>> their keyboard probing is also somewhat different to ours, but that's
>> probably another story.
>
> Well, I'd hate to lose the keyboard hotplug capability, but at the same
> time, it _is_ 2010, and while I have personally used it historically, I
> don't really foresee ever using it again.
>
> So we _could_ decide to just try it, and see if anybody screams. If nobody
> does, that would be a very simple solution to the problem.

i still actively use it on my linux router (normally headless and no
input), as well as my main desktop from time to time :x.  although
"actively" might not be the correct term as i dont usually have to
poke my linux router anymore ... it doesnt break very often anymore
which means i dont plug in anything at all.
-mike
