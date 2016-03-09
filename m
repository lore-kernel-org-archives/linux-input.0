From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Wed, 9 Mar 2016 21:53:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603092152420.3656@cbobk.fhfr.pm>
References: <20160308230323.GA4382@dtor-ws> <20160309120411.GF1796@lahna.fi.intel.com> <20160309195638.GK22340@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43950 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933828AbcCIUxn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2016 15:53:43 -0500
In-Reply-To: <20160309195638.GK22340@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Benson Leung <bleung@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 8 Mar 2016, Dmitry Torokhov wrote:

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

Applied to for-4.6/i2c-hid, thanks.

On Wed, 9 Mar 2016, Benjamin Tissoires wrote:

> Well, I have completely no way of testing this myself, and I blindly
> trust Mika, Dmitry and the others for doing the right thing :).

Welcome to the wonderful world of linux kernel maintainers! :p

Thanks,

-- 
Jiri Kosina
SUSE Labs

