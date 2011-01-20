From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move check for same handler in input_pass_event
Date: Thu, 20 Jan 2011 00:56:54 -0800
Message-ID: <20110120085654.GA19696@core.coreip.homeip.net>
References: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
 <20110107060456.GA29038@core.coreip.homeip.net>
 <20110107102434.7776091d@kcaccard-MOBL3>
 <20110107192938.GB28875@core.coreip.homeip.net>
 <4D276A51.5030102@linux.intel.com>
 <20110107194313.GC28875@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43359 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1ATI5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 03:57:05 -0500
Received: by pzk35 with SMTP id 35so59268pzk.19
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 00:57:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107194313.GC28875@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, linux-input@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Fri, Jan 07, 2011 at 11:43:13AM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 07, 2011 at 11:32:33AM -0800, Arjan van de Ven wrote:
> > On 1/7/2011 11:29 AM, Dmitry Torokhov wrote:
> > >On Fri, Jan 07, 2011 at 10:24:34AM -0800, Kristen Carlson Accardi wrote:
> > >>On Thu, 6 Jan 2011 22:04:56 -0800
> > >>Dmitry Torokhov<dmitry.torokhov@gmail.com>  wrote:
> > >>
> > >>>On Thu, Jan 06, 2011 at 02:24:48PM -0800, Kristen Carlson Accardi wrote:
> > >>>>If the handler that injected an event is the same,
> > >>>>just skip the filter, but allow the handler->event()
> > >>>>routine to be called.  This allows evdev to be able to
> > >>>>be used to loopback events.
> > >>>Why is it needed? Could you please give some examples?
> > >>>
> > >>>Thanks.
> > >>>
> > >>We have a customer who has a touchscreen device which sends
> > >>a bitmap into a gesture engine, which then interprets that
> > >>result and feeds it back into the kernel through a virtual
> > >>input driver that X is listening to.
> > >That really should be done though uinput.
> > 
> > quite possible.
> > 
> > but the application already exists, and works just fine in 2.6.35...
> > causing this to be classified as a kernel ABI regression ;-(
> > 
> 
> Hmm... I'd probably call it "relying on implementation details not
> spelled out anywhere".
> 
> Anyway, let me ponder this one a bit...
> 

OK, I think if we apply the patch below and then completely revert
5fdbe44d033d059cc56c2803e6b4dbd8cb4e5e39 we'll get the behavior we
want.

Jason, could you please try this and see if SysRq still works for you?

Thanks!

-- 
Dmitry

Input: sysrq - rework re-inject logic

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Internally 'disable' the filter when re-injecting Alt-SysRq instead
of relying on input core to suppress delivery of injected events
to the originating handler.

This allows to revert commit 5fdbe44d033d059cc56c2803e6b4dbd8cb4e5e39
which causes problems with existing userspace programs trying to
loopback the events via evdev.

Reported-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/tty/sysrq.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)


diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c556ed9..ef3a983 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -571,6 +571,7 @@ struct sysrq_state {
 	unsigned int alt_use;
 	bool active;
 	bool need_reinject;
+	bool reinjecting;
 };
 
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
@@ -581,6 +582,10 @@ static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 	unsigned int alt_code = sysrq->alt_use;
 
 	if (sysrq->need_reinject) {
+		/* we do not want the assignment to be reordered */
+		sysrq->reinjecting = true;
+		mb();
+
 		/* Simulate press and release of Alt + SysRq */
 		input_inject_event(handle, EV_KEY, alt_code, 1);
 		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 1);
@@ -589,6 +594,9 @@ static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 		input_inject_event(handle, EV_KEY, KEY_SYSRQ, 0);
 		input_inject_event(handle, EV_KEY, alt_code, 0);
 		input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
+
+		mb();
+		sysrq->reinjecting = false;
 	}
 }
 
@@ -599,6 +607,13 @@ static bool sysrq_filter(struct input_handle *handle,
 	bool was_active = sysrq->active;
 	bool suppress;
 
+	/*
+	 * Do not filter anything if we are in the process of re-injecting
+	 * Alt+SysRq combination.
+	 */
+	if (sysrq->reinjecting)
+		return false;
+
 	switch (type) {
 
 	case EV_SYN:
@@ -629,7 +644,7 @@ static bool sysrq_filter(struct input_handle *handle,
 				sysrq->alt_use = sysrq->alt;
 				/*
 				 * If nothing else will be pressed we'll need
-				 * to * re-inject Alt-SysRq keysroke.
+				 * to re-inject Alt-SysRq keysroke.
 				 */
 				sysrq->need_reinject = true;
 			}
