From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [WIP PATCH 0/4] Rework the unreliable LID switch exported by
 ACPI
Date: Mon, 5 Jun 2017 02:25:49 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CEC50AF@SHSMSX101.ccr.corp.intel.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63700 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdFEC0K (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 4 Jun 2017 22:26:10 -0400
In-Reply-To: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi, Benjamin

> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Subject: [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
> 
> Hi,
> 
> Sending this as a WIP as it still need a few changes, but it mostly works as
> expected (still not fully compliant yet).
> 
> So this is based on Lennart's comment in [1]: if the LID state is not reliable,
> the kernel should not export the LID switch device as long as we are not sure
> about its state.
> 
> That is the basic idea, and here are some more general comments:
> Lv described the 5 cases in "RFC PATCH v3" regarding the LID switch.
> Let me rewrite them here (they are in patch 2):
> 
> 1. Some platforms send "open" ACPI notification to the OS and the event
>    arrive before the button driver is resumed;
> 2. Some platforms send "open" ACPI notification to the OS, but the event
>    arrives after the button driver is resumed, ex., Samsung N210+;
> 3. Some platforms never send an "open" ACPI notification to the OS, but
>    update the cached _LID return value to "open", and this update arrives
>    before the button driver is resumed;
> 4. Some platforms never send an "open" ACPI notification to the OS, but
>    update the cached _LID return value to "open", but this update arrives
>    after the button driver is resumed, ex., Surface Pro 3;
> 5. Some platforms never send an "open" ACPI notification to the OS, and
>    _LID ACPI method returns a value which stays to "close", ex.,
>    Surface Pro 1.
> 
> We we consider that we can mark the LID switch as unreliable and make it
> disappear when we are not certain of the state, we can consider cases 1, 2, 3
> are solved:

I have concerns with case 2.

> cases 1 and 3 are solved when the LID state is reliable (majority
> of existing laptops),

Agreed.

> and case 2 is solved just by marking when the LID is not
> reliable. When we go to sleep, we unregister the input node. We wait for
> the next ACPI notification to re-export the LID switch input node with the
> correct state.

According to the test, both case 2,4,5 have already been solved in systemd.
So we needn't do anything in kernel.

If you still want to improve in acpi button.
IMO, for case 2, 4, we really have chance to improve.

For example, we could just add a timer right after resume.
And before it is timed out, if we can see the BIOS notify, we delete the timer.
And after it is timed out, we report "lid init value" to input layer.

> Given that the "close" event is reliable, on platforms where the LID switch is
> not reliable for "open", we will get the "close" event when we will start
> exporting the switch at the input level.
> 
> Note that systemd currently doesn't sync the state when the input node just
> appears. This is a systemd bug, and it should not be handled by the kernel
> community.

According to the test, systemd should be ok now.
Why do we need to change it again?

> 
> For case 4, we are not aware at the acpi/button.c level when the state is valid.
> We can solve this by polling every seconds for let's say 1 min, and if we detect
> a change, then we can re-export the input node (this hasn't been implemented
> yet). After this delay, we can consider the state as valid and export the input
> node with the current reported state in the ACPI.

Looks similar as the timer solution mentioned above.

> 
> However, this will conflict with case 5 where the ACPI value reported by
> the _LID method can be wrong anytime. We will need to treat this separately
> or find some other magic to make cases 4 and 5 compatible.

Case 5 is not compliant to SW_LID anyway.
However it works well with latest systemd.
Maybe we should just let it be and wait for further user request.

> 
> libinput will help cases 4 and 5 to restore the proper state, but that's
> assuming we have exported a wrong state. It might happen in case 5, but
> shouldn't in case 4.

IMO, if we improved case 2,4, libinput should only help to handle case 5.
Which is entirely not SW_LID compliant.

Thanks
Lv

> 
> Anyway, that is just a WIP which IMO is less hacky than the few other series.
> I still need to work on the udev/hwdb rules to have the list of problematic
> platforms in hwdb to not have them in the kernel, but that shouldn't be much
> of an issue. I also need to work on the polling but I'd like to get some inputs
> from Lv, Peter and others before spending too much time on it.
> 
> Note: yes, there is a lot of boilerplate for the input handler and for the
> reliable state, but I think this simplifies the logic as we are all reliying
> on the input stack to filter duplicate events.
> One other benefit of this boilerplate is that when libinput changes the LID
> state, i915 and nouveau will get notified.
> 
> Cheers,
> Benjamin
> 
> 
> [1] https://github.com/systemd/systemd/issues/2807
> 
> Benjamin Tissoires (3):
>   ACPI: button: extract input creation/destruction helpers
>   ACPI: button: remove the LID input node when the state is unknown
>   ACPI: button: Let input filter out the LID events
> 
> Lv Zheng (1):
>   ACPI: button: Fix lid notification locks
> 
>  drivers/acpi/button.c | 453 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 320 insertions(+), 133 deletions(-)
> 
> --
> 2.9.4

