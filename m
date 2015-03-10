From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Tue, 10 Mar 2015 14:23:07 +0200
Message-ID: <20150310122307.GM1563@lahna.fi.intel.com>
References: <1425930287-4615-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51333 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbbCJMXM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 08:23:12 -0400
Content-Disposition: inline
In-Reply-To: <1425930287-4615-1-git-send-email-dianders@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 12:44:47PM -0700, Doug Anderson wrote:
> If the i2c-hid device was runtime suspended and then the system
> suspended itself we'd end up disabling interrupts twice (in
> i2c_hid_runtime_suspend and i2c_hid_suspend) and not reenabling them
> until later when the i2c-hid device was runtime resumed.
> Unfortunately the i2c_hid_resume() calls i2c_hid_hwreset() and that
> only works properly if interrupts are enabled.
> 
> We can fix this by taking the advice from "runtime_pm.txt".
> Specifically we'll change i2c-hid to always resume to full power.
> This only works if our parents are also resumed to full power, but
> given the suggestion in "runtime_pm.txt" this seems a reasonable
> assumption.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Note that this was tested on a 3.14 kernel with backports.  Any
> testing that folks can do on ToT is appreciated.
> 
> Changes in v2:
> - Move pm_runtime_enable() higher in resume

Hmm, I tried on one machine with Atmel touch panel. I modified i2c-hid.c
a bit to print out when it is running suspend/resume hooks. Here is what
I got:

  [    7.506455] i2c_hid i2c-ATML1000:00: PM: i2c-hid runtime suspend

This is the initialization and after that the device is runtime
suspended.

Now I put the machine to system sleep (using echo mem >
/sys/power/state):

  [   26.988867] i2c_hid i2c-ATML1000:00: PM: i2c-hid runtime resume
  [   27.002957] i2c_hid i2c-ATML1000:00: PM: i2c-hid suspend

So the PM core will kick the device out of runtime suspend before it
suspends it again.

Pressing power button will resume the device:

  [   28.238934] i2c_hid i2c-ATML1000:00: PM: i2c-hid resume
  [   29.941579] i2c_hid i2c-ATML1000:00: PM: i2c-hid runtime suspend

and since the device is not being used, it will runtime suspend itself.

In other words, I'm not sure if this patch is needed. It would be good
if you could do similar testing using mainline kernel (if possible at
all).
