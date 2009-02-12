From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch for 2.6.29? 1/2] input: introduce a tougher i8042.reset
Date: Thu, 12 Feb 2009 01:45:15 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902120142500.22097@twin.jikos.cz>
References: <200902112110.n1BLAfJA008014@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:34605 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZBLAqI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 19:46:08 -0500
In-Reply-To: <200902112110.n1BLAfJA008014@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: dtor@mail.ru, linux-input@vger.kernel.org, arjan@linux.intel.com

On Wed, 11 Feb 2009, akpm@linux-foundation.org wrote:

> Some touchpads don't reset right the first time (MSI Wind U-100 for
> example).  This patch will retry the reset up to 5 times.

Yes, I agree we should seriously consider this a 2.6.29 material if we 
want to avoid a lot of repeating bugreports in the future, as more and 
more people start buying these toys.

In addition to that, I'd propose the patch below also for 2.6.29. Dmitry, 
what do you think?



From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] psmouse/synaptics: ensure we reset the device on resume

When resuming from suspend newer Synaptics touchpads do not recover
correctly.  Analysis of the resume sequence as applied in Linux was
compared to that of other operating systems.  This indicated that the
other OSs were resetting the mouse before attempting to detect it (for
all Synaptics touchpads, old and new).  Applying this same modification
fixes these newer Synaptics touchpads and brings the driver into line
with common OS reset behaviour.

This patch adds this reset by default providing a module option to
restore the previous non-reset behaviour:

	psmouse.synaptics_resume_reset=N

Also a message is emmitted on resume hinting as to how to fix a broken
touchpad.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/input/mouse/synaptics.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index d349c4a..5b01c14 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -60,11 +60,21 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
 	return 0;
 }
 
+static int synaptics_resume_reset = 1;
+module_param(synaptics_resume_reset, bool, 0);
+MODULE_PARM_DESC(synaptics_resume_reset,
+				"Enable reset on resume for Synaptics");
+
 int synaptics_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
+	if (synaptics_resume_reset) {
+		printk(KERN_CRIT "WARNING: synaptics was reset on resume, see synaptics_resume_reset if you have trouble on resume\n");
+		psmouse_reset(psmouse);
+	}
+
 	param[0] = 0;
 
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
