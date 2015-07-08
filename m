From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Call device suspend callback before disabling irq
Date: Wed, 08 Jul 2015 12:24:50 +0200
Message-ID: <2307888.TWO9u1uPK9@xps13>
References: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com> <alpine.LNX.2.00.1507072248020.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36745 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934625AbbGHKYy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2015 06:24:54 -0400
In-Reply-To: <alpine.LNX.2.00.1507072248020.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 07 July 2015 22:49:30 Jiri Kosina wrote:
> On Tue, 7 Jul 2015, Gabriele Mazzotta wrote:
> 
> > The irq is most likely required by the suspend callback, so disable it
> > only after the callback had been executed.
> 
> It would be nice to have a more verbose changelog here -- i.e. why we want 
> to do such change and what could go wrong if IRQ is disabled too early 
> (i.e. what bug is this exactly fixing).
> 
> > 
> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> 
> I'd see this as a 4.2 material still. Please let me know if you'd rather 
> want to wait for 4.3.
> 
> Thanks,

I would have given an instance showing the problem, but AFAIK there
isn't one yet as there are no drivers doing something with IRQs on
suspend. I encounterd problems while modifying hid-rmi.c, but since
the changes aren't there yet, I couldn't mention them. Still, I could
have written something better.

What about something like the following? I can resend the patch with
the new message if it's OK.
---

i2c-hid takes care of requesting and handling IRQs for HID devices
which in turns might expect them to be always active when working
in normal conditions. Hence, disabling IRQs before calling the suspend
callbacks can potentially cause problems since device drivers might
try to perform operations needing them.

Fix this by disabling IRQs only after the suspend callbacks had been
executed.
