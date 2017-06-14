From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID
 switch exported by ACPI
Date: Wed, 14 Jun 2017 23:50:17 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CED024F@SHSMSX101.ccr.corp.intel.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <20170607074848.GE27006@gardel-login>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170607074848.GE27006@gardel-login>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

> From: Lennart Poettering [mailto:mzxreary@0pointer.de]
> Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
> 
> On Thu, 01.06.17 20:46, Benjamin Tissoires (benjamin.tissoires@redhat.com) wrote:
> 
> > Hi,
> >
> > Sending this as a WIP as it still need a few changes, but it mostly works as
> > expected (still not fully compliant yet).
> >
> > So this is based on Lennart's comment in [1]: if the LID state is not reliable,
> > the kernel should not export the LID switch device as long as we are not sure
> > about its state.
> 
> Ah nice! I (obviously) like this approach.
> 
> > Note that systemd currently doesn't sync the state when the input node just
> > appears. This is a systemd bug, and it should not be handled by the kernel
> > community.
> 
> Uh if this is borked, we should indeed fix this in systemd. Is there
> already a systemd github bug about this? If not, please create one,
> and we'll look into it!

This is not my opinion.
My opinion is as follows.

We confirmed Ubuntu shipped systemd (version 229) with "reliable|unreliable" platforms.
We can see 2 problems:
1. LID_OPEN cannot cancel an on-going suspend sequence
   After boot, if user space receives "LID_CLOSE" key event,
   systemd may not suspend the platform right after seeing the event,
   it may suspend the platform several seconds later.
   This is not a problem.

   The problem is, if "LID_OPEN" is sent within this deferring period,
   Systemd doesn't cancel previously scheduled "suspend".
   And the platform may be suspended with lid opened.
   Then users need to close and re-open the lid to wake the system up.
   Causing another "LID_CLOSE/LID_OPEN" sequence delivered to the user space after resume.
   Users then can see a suspend/resume loop.
   This problem can even be seen on "reliable" platforms.
   It can be easily triggered by user actions.
2. Need explicit LID_OPEN to stay woken-up
   After boot, systemd seems to be wait for a significant "LID_OPEN".
   If it cannot see a "LID_OPEN" within several seconds,
   it suspends the platform.
   So if a platform doesn't send "LID_OPEN" or fails to send "LID_OPEN" within this period.
   Users then can see a suspend/resume loop.

However we've tested with github cloned systemd (version 233).
The 2 problems seem to have been fixed.
It works well with current ACPI button driver,
but you need to boot linux kernel with button.lid_init_state=ignore.
I don't know the story of the improvement.
Systemd developers should know that better than me.

So IMO, systemd needn't do any further improvement.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

But the kernel button driver implements several "lid_init_state" modes.
It appears "method" mode is determined to be the default mode.
Thus we need to do:
1. improve button driver "method" mode to make systemd 233 work well with it.
2. determine if we need to improve button driver to make it work well with systemd 229.

Thanks and best regards
Lv 

