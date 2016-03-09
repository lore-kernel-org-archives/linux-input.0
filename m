From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Wed, 9 Mar 2016 20:56:38 +0100
Message-ID: <20160309195638.GK22340@mail.corp.redhat.com>
References: <20160308230323.GA4382@dtor-ws>
 <20160309120411.GF1796@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160309120411.GF1796@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Benson Leung <bleung@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-input@vger.kernel.org

On Mar 09 2016 or thereabouts, Mika Westerberg wrote:
> On Tue, Mar 08, 2016 at 03:03:23PM -0800, Dmitry Torokhov wrote:
> > On ACPI-based systems ACPI power domain code runtime resumes device before
> > calling suspend method, which ensures that i2c-hid suspend code starts with
> > device not in low-power state and with interrupts enabled.
> > 
> > On other systems, especially if device is not a part of any power domain,
> > we may end up calling driver's system-level suspend routine while the
> > device is runtime-suspended (with controller in presumably low power state
> > and interrupts disabled). This will result in interrupts being essentially
> > disabled twice, and we will only re-enable them after both system resume
> > and runtime resume methods complete. Unfortunately i2c_hid_resume() calls
> > i2c_hid_hwreset() and that only works properly if interrupts are enabled.
> > 
> > Also if device is runtime-suspended driver's suspend code may fail if it
> > tries to issue I/O requests.
> > 
> > Let's fix it by runtime-resuming the device if we need to run HID driver's
> > suspend code and also disabling interrupts only if device is not already
> > runtime-suspended. Also on resume we mark the device as running at full
> > power (since that is what resetting will do to it).
> > 
> > Signed-off-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> 
> Tested on a couple of Intel Skylake and Baytrail based systems and power
> management of I2C connected HID devices still seems to work just fine.
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Well, I have completely no way of testing this myself, and I blindly
trust Mika, Dmitry and the others for doing the right thing :).

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
