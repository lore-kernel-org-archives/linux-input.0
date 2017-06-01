From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [WIP PATCH 0/4] Rework the unreliable LID switch exported by
 ACPI
Date: Thu, 01 Jun 2017 23:43:54 +0200
Message-ID: <1496353434.2570.5.camel@hadess.net>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46479 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFAVoB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Jun 2017 17:44:01 -0400
In-Reply-To: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-input@vger.kernel.org

On Thu, 2017-06-01 at 20:46 +0200, Benjamin Tissoires wrote:
> Hi,
> 
> Sending this as a WIP as it still need a few changes, but it mostly
> works as
> expected (still not fully compliant yet).
> 
> So this is based on Lennart's comment in [1]: if the LID state is not
> reliable,
> the kernel should not export the LID switch device as long as we are
> not sure
> about its state.
> 
> That is the basic idea, and here are some more general comments:
> Lv described the 5 cases in "RFC PATCH v3" regarding the LID switch.
> Let me rewrite them here (they are in patch 2):
> 
> 1. Some platforms send "open" ACPI notification to the OS and the
> event
>    arrive before the button driver is resumed;
> 2. Some platforms send "open" ACPI notification to the OS, but the
> event
>    arrives after the button driver is resumed, ex., Samsung N210+;
> 3. Some platforms never send an "open" ACPI notification to the OS,
> but
>    update the cached _LID return value to "open", and this update
> arrives
>    before the button driver is resumed;
> 4. Some platforms never send an "open" ACPI notification to the OS,
> but
>    update the cached _LID return value to "open", but this update
> arrives
>    after the button driver is resumed, ex., Surface Pro 3;
> 5. Some platforms never send an "open" ACPI notification to the OS,
> and
>    _LID ACPI method returns a value which stays to "close", ex.,
>    Surface Pro 1.

In which case does the Surface 3 lie? I believe we still needed your
"gpiolib-acpi: make sure we trigger the events at least once" patch to
make that one work.

Cheers
