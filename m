From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
Date: Fri, 2 Jun 2017 09:24:26 +0200
Message-ID: <20170602072426.GJ1293@mail.corp.redhat.com>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
 <1496353434.2570.5.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbdFBHYe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Jun 2017 03:24:34 -0400
Content-Disposition: inline
In-Reply-To: <1496353434.2570.5.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-input@vger.kernel.org

On Jun 01 2017 or thereabouts, Bastien Nocera wrote:
> On Thu, 2017-06-01 at 20:46 +0200, Benjamin Tissoires wrote:
> > Hi,
> > 
> > Sending this as a WIP as it still need a few changes, but it mostly
> > works as
> > expected (still not fully compliant yet).
> > 
> > So this is based on Lennart's comment in [1]: if the LID state is not
> > reliable,
> > the kernel should not export the LID switch device as long as we are
> > not sure
> > about its state.
> > 
> > That is the basic idea, and here are some more general comments:
> > Lv described the 5 cases in "RFC PATCH v3" regarding the LID switch.
> > Let me rewrite them here (they are in patch 2):
> > 
> > 1. Some platforms send "open" ACPI notification to the OS and the
> > event
> >    arrive before the button driver is resumed;
> > 2. Some platforms send "open" ACPI notification to the OS, but the
> > event
> >    arrives after the button driver is resumed, ex., Samsung N210+;
> > 3. Some platforms never send an "open" ACPI notification to the OS,
> > but
> >    update the cached _LID return value to "open", and this update
> > arrives
> >    before the button driver is resumed;
> > 4. Some platforms never send an "open" ACPI notification to the OS,
> > but
> >    update the cached _LID return value to "open", but this update
> > arrives
> >    after the button driver is resumed, ex., Surface Pro 3;
> > 5. Some platforms never send an "open" ACPI notification to the OS,
> > and
> >    _LID ACPI method returns a value which stays to "close", ex.,
> >    Surface Pro 1.
> 
> In which case does the Surface 3 lie? I believe we still needed your
> "gpiolib-acpi: make sure we trigger the events at least once" patch to
> make that one work.

Well, the surface 3 is using a different driver for the LID switch
(surface3-wmi). From what I can remember, we don't need this patch when
using this driver (which is why I did not submitted it further). But I
might be wrong...

Cheers,
Benjamin
