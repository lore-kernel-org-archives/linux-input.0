From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup control
Date: Fri, 29 Jul 2011 23:04:26 +0200
Message-ID: <201107292304.27055.rjw@sisk.pl>
References: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com> <Pine.LNX.4.44L0.1107281103180.1990-100000@iolanthe.rowland.org> <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34748 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab1G2VDH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jul 2011 17:03:07 -0400
In-Reply-To: <CAGq3pz6J2pma1TxcqUreQ-qi37Tk4VU15uAvH1=dwyAAvxAPLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Daniel Drake <dsd@laptop.org>, Alan Stern <stern@rowland.harvard.edu>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dilinger@queued.net

On Thursday, July 28, 2011, Daniel Drake wrote:
> On 28 July 2011 16:08, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Aren't there?  I have no idea.  But if input devices are never
> > wakeup-capable, why do you name your function "input_may_wakeup()"?
> 
> I guess i8042_may_wakeup() would be a better name for it.

Yes, it would.

> In this case, the only device in the hierarchy (i8042 -> serio -> input) that
> is marked wakeup capable is the i8042 device (and only via my patches). I'd
> welcome a better design.
> 
> > I'm using a normal PC with PS/2 mouse and keyboard.  It is set up with
> > the keyboard as a wakeup source but not the mouse.  Of course, this
> > uses ACPI, which I assume isn't present on OLPC.
> 
> It does depend on how the system is designed, yes. I suspect that the
> device that is actually marked as wakeup capable on your setup is not
> an input device, but rather another part of the /sys tree (perhaps
> part of the ACPI tree?).

If there's an ACPI object corresponding to the device and it allows the
device to be configured for wakeup, then device_can_wakeup() will be true
for the device's struct device object (not the ACPI one).

> Also, I suspect that if your system is woken up by the keyboard, it loses the
> keypress which was used to wake it up.

Yes, it does, because we don't even try to handle the ACPI case.  One reason
is that on some systems keyboard wakeup is handled entirely by the BIOS behind
our back.
 
> I'm definitely open to better ways of doing this. The key considerations are:
> 1. We only have control over wakeups at the i8042 level; i.e. we
> cannot ask for keyboard wakeups but not mouse.
> 2. Our keyboard and mouse hardware is guaranteed to be powered
> throughout suspend
> 3. The key press or mouse movement or click that woke the system must
> not be lost during resume. This means that all 3 layers (i8042, serio,
> input) must not reset or really do anything with the device during
> suspend/resume.

Have you considered marking all of the devices in the chain as "wakeup
capable" in that case?  Then, one would have to enable wakeup for all of
them for things to work, in analogy with the USB case (a USB mouse or
keyboard may be a wakeup-capable device, but you also need to enable the
controller it's attached to to wake up).

Thanks,
Rafael
