From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [WIP PATCH 2/4] ACPI: button: remove the LID input node when the
 state is unknown
Date: Wed, 7 Jun 2017 11:27:50 +1000
Message-ID: <20170607012750.GB13738@jelly>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <20170601184632.2980-3-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEC50F1@SHSMSX101.ccr.corp.intel.com>
 <20170606102209.GA14880@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:48808 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdFGB1y (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 21:27:54 -0400
Content-Disposition: inline
In-Reply-To: <20170606102209.GA14880@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jun 06, 2017 at 12:22:09PM +0200, Benjamin Tissoires wrote:
[...]
> > This is because the aml table puts many Notify(LID, 0x80) in various control methods.
> > And not one of them but multiple of them will be invoked by various OS drivers during suspend/resume period.
> > I think this is not an isolated platform that will invoke multiple redundant "Notify(lid)".
> > 
> > Fortunately, the lid state for the multiple notify(lid) should be same as the first "Notify(lid)".
> > I suppose this is why SW_LID is invented, as it can really filter such redundant events.
> > And user space finally can only see 1 "close" event.
> > 
> > But unconditionally prepending "open" before all "close" events surely can break the logic by
> > delivering multiple "close" events to the user space.
> 
> That doesn't matter. What matters is the state of the switch, not the
> event. So if user space receives (in case we marked the switch as not
> reliable) several close events, all user space will do is realize that
> the state is still closed and will act accordingly.

[...]

> Again, we don't care if the "event" comes from ACPI, the driver itself or
> user space (libinput). All that matters is the current state of the
> input node switch, that needs to match the physical world at any time.

as extra comment on those two: you cannot guarantee when e.g. libinput
checks the state. it may start up after the kernel has updated the EV_SW
state, it may close and re-open a device without notice (disabling a
device in X has that effect for example). So the EV_SW/SW_LID events are
nice to have, but we really rely on the *state* of the switch more than the
events.

Cheers,
   Peter

