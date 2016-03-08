From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3] HID: i2c-hid: Fix suspend/resume when already runtime suspended
Date: Tue, 8 Mar 2016 15:13:01 -0800
Message-ID: <CANLzEkvGhO7B=U9sBopAEzOT_a9k-Mj1-6iwqHuhR5OCp_jvGQ@mail.gmail.com>
References: <20160308230323.GA4382@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34527 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcCHXND (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 18:13:03 -0500
Received: by mail-vk0-f52.google.com with SMTP id e185so36197123vkb.1
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2016 15:13:02 -0800 (PST)
In-Reply-To: <20160308230323.GA4382@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Doug Anderson <dianders@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Mar 8, 2016 at 3:03 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On ACPI-based systems ACPI power domain code runtime resumes device before
> calling suspend method, which ensures that i2c-hid suspend code starts with
> device not in low-power state and with interrupts enabled.
>
> On other systems, especially if device is not a part of any power domain,
> we may end up calling driver's system-level suspend routine while the
> device is runtime-suspended (with controller in presumably low power state
> and interrupts disabled). This will result in interrupts being essentially
> disabled twice, and we will only re-enable them after both system resume
> and runtime resume methods complete. Unfortunately i2c_hid_resume() calls
> i2c_hid_hwreset() and that only works properly if interrupts are enabled.
>
> Also if device is runtime-suspended driver's suspend code may fail if it
> tries to issue I/O requests.
>
> Let's fix it by runtime-resuming the device if we need to run HID driver's
> suspend code and also disabling interrupts only if device is not already
> runtime-suspended. Also on resume we mark the device as running at full
> power (since that is what resetting will do to it).
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>
> This is an uprev of a patch that Doug sent a year ago (see
> https://patchwork.kernel.org/patch/5970731/), adjusted to the latest
> mainline. The change from v2 is that we runtime-resume the device before
> calling into HID driver's suspend callback.




-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
