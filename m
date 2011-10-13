From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Thu, 13 Oct 2011 11:49:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110131134270.2026-100000@iolanthe.rowland.org>
References: <20111013082016.GA2209@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59298 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754300Ab1JMPt1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 11:49:27 -0400
In-Reply-To: <20111013082016.GA2209@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, dtor@mail.ru

On Thu, 13 Oct 2011, Henrik Rydberg wrote:

> > It's always a bug.  However, the patch I sent to Matthew should fix the 
> > immediate problem.
> > 
> > In fact, the original autosuspend design intended to allow drivers to 
> > do this -- keep devices awake by failing suspend requests even though 
> > the usage count is 0.  Under some conditions, that's the approach with 
> > the least overhead.  But the code to handle this got lost by mistake, 
> > so now it needs to be added back.
> 
> I tried the patch out, unfortunately it did not work. The second
> suspend request returns with a -EINPROGRESS, here:
> 
> 	if (dev->power.runtime_status == RPM_SUSPENDING) {
> 		DEFINE_WAIT(wait);
> 
> 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> 			retval = -EINPROGRESS;
> 			goto out;
> 		}
> 
> 		/* Wait for the other suspend running in parallel with us. */
> 		for (;;) {
> 
> The reason is above my horizon, although RPM_ASYNC looks suspicious.
> In general, we are re-entering rpm_suspend from within the driver
> handler, so the exit condition of rpm_suspend may not have been
> satisfied yet.

Ah yes, I vaguely remember thinking that another part would have to be
fixed.  But it's not just the part you identified; the error actually
occurred higher up.  The patch below ought to help.

Alan Stern


 drivers/base/power/runtime.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: usb-3.1/drivers/base/power/runtime.c
===================================================================
--- usb-3.1.orig/drivers/base/power/runtime.c
+++ usb-3.1/drivers/base/power/runtime.c
@@ -278,8 +278,9 @@ static int rpm_callback(int (*cb)(struct
  * @rpmflags: Flag bits.
  *
  * Check if the device's runtime PM status allows it to be suspended.  If
- * another suspend has been started earlier, either return immediately or wait
- * for it to finish, depending on the RPM_NOWAIT and RPM_ASYNC flags.  Cancel a
+ * another suspend has been started earlier and the RPM_ASYNC flag isn't set,
+ * either return immediately or wait for it to finish, depending on the
+ * RPM_NOWAIT flag.  Cancel a
  * pending idle notification.  If the RPM_ASYNC flag is set then queue a
  * suspend request; otherwise run the ->runtime_suspend() callback directly.
  * If a deferred resume was requested while the callback was running then carry
@@ -311,8 +312,7 @@ static int rpm_suspend(struct device *de
 		goto out;
 
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
-	if ((rpmflags & RPM_AUTO)
-	    && dev->power.runtime_status != RPM_SUSPENDING) {
+	if (rpmflags & RPM_AUTO) {
 		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
 
 		if (expires != 0) {
@@ -339,10 +339,16 @@ static int rpm_suspend(struct device *de
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	if (dev->power.runtime_status == RPM_SUSPENDING) {
+	/*
+	 * If the request is synchronous, wait for a concurrent suspend attempt
+	 * to finish.  Allow asynchronous requests to go through; they will be
+	 * cancelled if the concurrent suspend succeeds.
+	 */
+	if (dev->power.runtime_status == RPM_SUSPENDING &&
+			!(rpmflags & RPM_ASYNC)) {
 		DEFINE_WAIT(wait);
 
-		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
+		if (rpmflags & RPM_NOWAIT) {
 			retval = -EINPROGRESS;
 			goto out;
 		}

