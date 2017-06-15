From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch
 exported by ACPI
Date: Thu, 15 Jun 2017 16:47:15 +1000
Message-ID: <20170615064715.GA6195@jelly>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <20170607074848.GE27006@gardel-login>
 <20170613100617.GD29589@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:51860 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdFOGrZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Jun 2017 02:47:25 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jun 15, 2017 at 02:52:57AM +0000, Zheng, Lv wrote:
> Hi, Benjamin
> 
> > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
> > 
> > Hi,
> > 
> > [Sorry for the delay, I have been sidetracked from this]
> > 
> > On Jun 07 2017 or thereabouts, Lennart Poettering wrote:
> > > On Thu, 01.06.17 20:46, Benjamin Tissoires (benjamin.tissoires@redhat.com) wrote:
> > >
> > > > Hi,
> > > >
> > > > Sending this as a WIP as it still need a few changes, but it mostly works as
> > > > expected (still not fully compliant yet).
> > > >
> > > > So this is based on Lennart's comment in [1]: if the LID state is not reliable,
> > > > the kernel should not export the LID switch device as long as we are not sure
> > > > about its state.
> > >
> > > Ah nice! I (obviously) like this approach.
> > 
> > Heh. Now I just need to convince Lv that it's the right approach.
> 
> I feel we don't have big conflicts.
> And I already took part of your idea into this patchset:
> https://patchwork.kernel.org/patch/9771121/
> https://patchwork.kernel.org/patch/9771119/
> I tested my surface pros with Ubuntu, they are working as expected.
> 
> > > > Note that systemd currently doesn't sync the state when the input node just
> > > > appears. This is a systemd bug, and it should not be handled by the kernel
> > > > community.
> > >
> > > Uh if this is borked, we should indeed fix this in systemd. Is there
> > > already a systemd github bug about this? If not, please create one,
> > > and we'll look into it!
> > 
> > I don't think there is. I haven't raised it yet because I am not so sure
> > this will not break again those worthless unreliable LID, and if we play
> > whack a mole between the kernel and user space, things are going to be
> > nasty. So I'd rather have this fixed in systemd along with the
> > unreliable LID switch knowledge, so we are sure that the kernel behaves
> > the way we expect it to be.
> 
> This is my feeling:
> We needn't go that far.
> We can interpret "input node appears" into "default input node state".

Sorry, can you clarify this bit please? I'm not sure what you mean here.
Note that there's an unknown amount of time between "device node appearing
in the system" and when a userspace process actually opens it and looks at
its state. By then, the node may have changed state again.

Cheers,
   Peter

> That's what you want for acpi button driver - we now defaults to "method" mode.
> 
> What's your opinion?
> 
> Thanks
> Lv
> 
