From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/3] Proposal for making hid_have_special_driver obsolete
Date: Wed, 14 Jun 2017 12:07:01 +0200
Message-ID: <BB2CF2B2-67D7-4DD4-BA36-23362CF9FB05@hadess.net>
References: <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm> <20170614082441.5270-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37321 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdFNKHH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 06:07:07 -0400
In-Reply-To: <20170614082441.5270-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org



> On 14 Jun 2017, at 10:24, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi,
> 
> As mentioned by Jiri, I found a way to have this horrible list a thing from
> the past (to some extends).
> 
> The basic observation is that now, since v4.12, hid-generic should not be an
> issue for any device, given that all it does is parsing the report descriptor
> and starting the IRQs/URBs.
> 
> So it should not be an issue to have hid-generic handling all incoming devices
> until the specialized driver comes in and replace it.
> 
> For users, that means that they will see an input node appearing and
> disappearing as soon as hid-XXX.ko gets loaded.

That's way ugly, and slower, when a "multi" quirk is used.

> I have tested this on the Logitech Unifying Receiver and some Wacom devices,
> and all seem happy with the situation.
> 
> Patches 1 and 2 are HID cleanup and something I wanted to put in from a long
> time.
> 
> Patch 3 is the one that does the magic and where I need input from the drivers
> specialists.
> 
> To make things easier to handle, I deported the logic of unbinding hid-generic
> into hid-generic itself. I would think a bus_notifier would be better than
> instrumenting struct hid_driver for drivers (un)registering on the bus, but
> we are missing those events in bus_notifiers.
> Would such events (BUS_NOTIFY_ADD_DRIVER, BUS_NOTIFY_REMOVED_DRIVER) make sense
> outside of this particular case?
> 
> The second question I have is whether or not I need locks around the unbinding
> magic in hid-generic. After a lot of thinking I believe I don't, but I'd prefer
> having a second pair of eyes on this.
> 
> Jiri, this series is on top of a merge of your for-next and your other
> for-4.12/driver-matching-fix branch. I'll resubmit a proper patch that will
> apply properly to for-next as soon as for-4.12/driver-matching-fix gets merged.
> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (3):
>  HID: core: move the dynamic quirks handling in core
>  HID: quirks: move the list of special devices into a quirk
>  HID: core: remove the absolute need of hid_have_special_driver[]
> 
> drivers/hid/Makefile            |    2 +-
> drivers/hid/hid-core.c          |  918 ++---------------------------
> drivers/hid/hid-generic.c       |   68 ++-
> drivers/hid/hid-quirks.c        | 1236 +++++++++++++++++++++++++++++++++++++++
> drivers/hid/usbhid/Makefile     |    2 +-
> drivers/hid/usbhid/hid-core.c   |   10 +-
> drivers/hid/usbhid/hid-quirks.c |  399 -------------
> include/linux/hid.h             |   19 +-
> net/bluetooth/hidp/core.c       |    2 +-
> 9 files changed, 1380 insertions(+), 1276 deletions(-)
> create mode 100644 drivers/hid/hid-quirks.c
> delete mode 100644 drivers/hid/usbhid/hid-quirks.c
> 
> -- 
> 2.9.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

