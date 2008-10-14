From: "Phil Endecott" <phil_dubhl_endecott@chezphil.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Wed, 15 Oct 2008 00:17:29 +0100
Message-ID: <1224026249108@dmwebmail.dmwebmail.chezphil.org>
References: <20081014113709.5a2f2c2e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:1393 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbYJNXRc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 19:17:32 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_dubhl_endecott@chezphil.org>)
	id 1Kpt8s-0004Q7-A3
	for linux-input@vger.kernel.org; Wed, 15 Oct 2008 00:17:30 +0100
In-Reply-To: <20081014113709.5a2f2c2e@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>

Arjan van de Ven wrote:
> On Tue, 14 Oct 2008 11:29:55 -0400
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> On Tue, Oct 14, 2008 at 11:12:36AM -0400, Arjan van de Ven wrote:
>> > On Tue, 14 Oct 2008 10:54:36 -0400
>> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> > > On Tue, Oct 14, 2008 at 03:19:28PM +0100, Phil Endecott wrote:
>> > > > What can be done about this?  Is it unreasonable for the mouse
>> > > > probing to take 2 seconds?  Should it not be holding the
>> > > > conflicting lock while it is probing?  Does the platform
>> > > > matching code really need to hold the lock when it's just
>> > > > comparing the string names of the device and driver?
>> > > >
>> > 
>> > the real thing is to not wait on this while booting;
>> > my fastboot git tree has the patches to fix that part..
>> > 
>> 
>> Could you please be more specific?
>
> right now, the linux kernel boot will wait for this probing to be done
> before mounting the root fs and then exec()ing /sbin/init.
> On my test laptop this takes 7 seconds of .. nothing ;-)
>
> the patch I have makes the kernel NOT wait for this, but just it tries
> to mount root right away (and if that fails, it THEN waits and retries)

So I worked out how to enable fastboot - the cunningly-named 
CONFIG_FASTBOOT option - and I now see initcalls running concurrently.  
I've saved a bootgraph at http://chezphil.org/tmp/bootgraph1.svg

The pcspkr delay symptom still exists, and as far as I can see the 
kernel doesn't try to mount root and start init until afterwards.  
Arjan, what do you mean by "right away" in the last line quoted above?  
Is there something that I have to do to get the pcspkr init off the 
path to mounting root?

Note also that in the graph serial8250_pci_init and uhci_hcd_init run 
concurrently and seem to terminate almost exactly simulataneously.  
Looking at the dmesg output, it's clear that serial8250_pci_init has 
been blocked waiting from uhci_hcd_init to terminate:

[    0.937759] calling  uhci_hcd_init+0x0/0x8e @ 14
[    0.937770] USB Universal Host Controller Interface driver v3.0
snip lots of sane UHCI messages
[    0.941187] calling  serial8250_pci_init+0x0/0x11 @ 1
snip lots more sane UHCI messages (root hub enumeration)
[    1.353134] initcall uhci_hcd_init+0x0/0x8e returned 0 after 396 msecs
[    1.353186] initcall serial8250_pci_init+0x0/0x11 returned 0 after 
392 msecs

It looks to me as if uhci holds some lock that 8250 needs before it can 
complete.  Now those are both PCI drivers in the same way that the last 
two that seemed to contend were both input drivers (touchpad and 
speaker) [hmm, except that as Dmitry pointed out there's a distinction 
between the platform bus and the serio bus].  Anyway, my ignorant 
suspicion is that there's some lock related to the bus or subsystem 
that they both need.  Maybe something in sysfs?

I tried running with CONFIG_LOCK_STAT set but I didn't see a huge 
amount of interest; but as I understand it, that only tracks locks not 
other locking things like semaphores and spinlocks.  The two 
conspicuous entries for my previous kernel build without 
CONFIG_FASTBOOT were

&type->i_mutex_dir_key#2  [<c017fb0c>] do_lookup+0x69/0x11d
  - looks like something fundamental in the filesystem

&battery->lock [<c022a524>] acpi_battery_get_state+0x50/0xc9
  - probably the reason for the acpi_battery_init which takes a few 
hundred miliseconds at the start of the boot; I think this is the first 
code to use ACPI, or something.

Any suggestions anyone?

Phil.




