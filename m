From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Fri, 12 Aug 2016 11:29:07 +0200
Message-ID: <20160812092907.GP17850@mail.corp.redhat.com>
References: <20160811232759.Horde.nOLGcvRFRNEDDDHWRQr1nXw@horde.stefanseidel.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbcHLJ3N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2016 05:29:13 -0400
Content-Disposition: inline
In-Reply-To: <20160811232759.Horde.nOLGcvRFRNEDDDHWRQr1nXw@horde.stefanseidel.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Seidel <lkml@stefanseidel.info>
Cc: smueller@chronox.de, jkosina@suse.cz, linux-input@vger.kernel.org

Hi Stefan,

On Aug 11 2016 or thereabouts, Stefan Seidel wrote:
> Hi,
> 
> I'm hijacking on that very old conversation you had here:
> http://linux-input.vger.kernel.narkive.com/78cpvzuC/sony-vaio-duo-11-getting-middle-mouse-button-to-work
> 
> I took Wireshark dumps of the USB traffic when the Windows configuration
> tools switches between "use middle button for scroll" and "send middle
> button as button 2" (they're not named like this, but that's what they do).
> I also have a second dump of enabling and disabling "touch trackpoint to
> send mouse button 1". I can see that there is a clear key/value mapping. I
> don't know anything about HID or USB (or Wireshark), but it seems like the
> *device* is sending different values back to the *host* when these settings
> are changed.
> 
> Anyway, is there a way I can "decrypt" this and write either a usespace
> helper or write or amend a kernel driver to be able to switch those two
> options in Linux? Or did I miss something in my capture? Those were taken
> with Wireshark 2.0.

If you can manage to get the beginning of the enumeration of the USB
device, Wireshark will decrypt most of the informations for you (if the
commands are SET_FEATURE or GET_FEATURE, etc...).

It's unclear to me which settings triggers the change, but it's clear
that when the host does a Set_Report Request on the Output 2:
 - bmRequestType: 0x21 -> Set_Report Request
 - bRequest: 9 -> SET_REPORT 
 - wValue: 0x0202 -> Report Type Output, Report ID 02
 - wIndex: 0 -> Interface 0
 - wLength: 5 -> Report Length
 - Data: ???

(see http://www.usb.org/developers/hidpage/HID1_11.pdf section 7.2.2 to
decrypt the raw USB events)

The answer is different in the first case and 7 seconds after (I assume
you toggled the setting there) -> frame 16 and 33 in the first log.

I'd say the first log would be:
- 1.  -> SET_IDLE (you can ignore it)
- 3.  -> SET_REPORT on OUTPUT 2, length 5 no data
      -> answer in 4.  -> 02 04 02 00 00
- 5.  -> SET CONFIGURATION Status (ignore this as well I think)
- 6.  -> SET_REPORT on OUTPUT 2, length 5 no data
      -> answer in 7.  -> 02 06 00 00 00
- 9.  -> SET_REPORT on OUTPUT 2, length 5 no data
      -> answer in 10. -> 02 05 01 00 00
- 12. -> SET_REPORT on OUTPUT 2, length 5 no data
      -> answer in 13. -> 02 02 01 00 00
- 16. -> SET_REPORT on OUTPUT 2, length 5 no data
      -> answer in 14. -> 02 03 01 00 00

The second sequence (frames 18 to 34) provides the same output except
for the last answer 02 03 00 00 00.

The "no data" part seems weird, but there is a chance if you output a
report with 02 03 00 00 00 or 02 03 01 00 00, this toggles the behavior.

I'll let you decrypt the second log :)

Anyway, once you got enough information, you can either directly work in
kernel space, in a driver, or in userspace, using hidraw.

If you start working in kernel space, start with a small hid driver and
in .probe() try accessing the device with the event sequences you got.

If you start working with hidraw, there is an example in the kernel
tree: samples/hidraw/hid-example.c.

Cheers,
Benjamin

