From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Wed, 9 Mar 2016 14:04:11 +0200
Message-ID: <20160309120411.GF1796@lahna.fi.intel.com>
References: <20160308230323.GA4382@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4093 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbcCIMER (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2016 07:04:17 -0500
Content-Disposition: inline
In-Reply-To: <20160308230323.GA4382@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Benson Leung <bleung@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Mar 08, 2016 at 03:03:23PM -0800, Dmitry Torokhov wrote:
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

Tested on a couple of Intel Skylake and Baytrail based systems and power
management of I2C connected HID devices still seems to work just fine.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
