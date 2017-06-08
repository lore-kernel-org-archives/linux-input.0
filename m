From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Thu, 8 Jun 2017 13:17:12 -0700
Message-ID: <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk> <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36543 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdFHURN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 16:17:13 -0400
In-Reply-To: <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Hans de Goede <hdegoede@redhat.com>, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jun 8, 2017 at 12:49 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> So maybe CONFIG_HID_ASUS should default to Y?  I'll leave it up to Hans
> to straighten this out.

No, I think the main problem is that the hid_have_special_driver[]
array change is garbage.

It adds the ASUS ID, regardless of whether the special driver exists or not.

We *really* shouldn't do that. We had a very similar regression wrt
the "improved" synaptics RMI handling in commit 279967a65b32.

If you didn't have HID_RMI enabled at all, that commit made the
regular HID driver not take care of the device, and without an RMI
driver there was nothing else that took care of it either.

So when you add things like "don't react to this device", you damn
well should make sure that something else *does* react to the device
instead.

So those ASUSTEK entries that get disabled in hid-core.c should be
protected by something like

  #if IS_ENABLED(CONFIG_HID_ASUS)
    ...
  #endif

exactly so that the core HID subsystem doesn't ignore them when
nothing else picks up the slack.

I note that *some* cases do do that. Too few, apparently.

PLEASE STOP THIS MINDLESS "DISABLE GENERIC DEVICE DISCOVERY" CRAP!

It's only ok to disable a generic device if you actually have a real
working fallback that is actually enabled!

So that commit 76dd1fbebbae ("HID: asus: Add support for T100
keyboard") is actively buggy, because it incorrectly assumes a
particular config.

              Linus
