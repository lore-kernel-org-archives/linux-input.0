From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 35022: hid-magicmouse broken
Date: Thu, 19 May 2011 13:59:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39699 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1ESL7p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 07:59:45 -0400
In-Reply-To: <4DD2C913.4000403@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On Tue, 17 May 2011, Chase Douglas wrote:

> >> It seems hid_output_raw_report() is returning a different (incorrect?)
> >> value than in the past. Do you know what might be going on?
> > 
> > So we are getting EIO from the transport-level _raw callback.
> > 
> > Hmm, commit 0825411ade seems like a suspect here. Might be possible that 
> > magicmouse doesn't send ACK back, right?
> > 
> > Could you please try reverting that commit and re-test?
> 
> Yes, reverting that commit makes it work.
> 
> I'm just speculating here, based on commit message names and what you've
> said, that the magicmouse is not protocol compliant because it is not
> sending an ACK back? 

Yes, I believe that's what is happening. Could you please report what is 
the dmesg output with the patch below, just to make sure that we 
understand the situation precisely?

> What do you think we should do in the driver? Should we ignore the 
> return, or should we look specifically for EIO? (neither sounds very 
> good to me, so I'm hoping you have a better solution :).

Well if the device indeed doesn't send the ACK and it should (I will have 
to check the specs first), we'll have to put a quirk into the driver. 
Otherwise if the ACK is not mandatory, we'll have to revert that commit 
(or at least make it non-fatal failure).

But I'll have to check the specs first.


 net/bluetooth/hidp/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 5ec1297..21025ed 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -403,6 +403,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 	struct hidp_session *session = hid->driver_data;
 	int ret;
 
+	printk(KERN_DEBUG "hidp_output_raw_report, report_type: %d\n", report_type);
 	switch (report_type) {
 	case HID_FEATURE_REPORT:
 		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
@@ -434,6 +435,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 			10*HZ);
 		if (res == 0) {
 			/* timeout */
+			printk(KERN_DEBUG "hidp: returning -EIO because of timeout\n");
 			ret = -EIO;
 			goto err;
 		}
@@ -445,6 +447,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 	}
 
 	if (!session->output_report_success) {
+		printk(KERN_DEBUG "hidp: returnign -EIO because of !output_report_success\n");
 		ret = -EIO;
 		goto err;
 	}
@@ -480,7 +483,7 @@ static inline void hidp_del_timer(struct hidp_session *session)
 static void hidp_process_handshake(struct hidp_session *session,
 					unsigned char param)
 {
-	BT_DBG("session %p param 0x%02x", session, param);
+	printk(KERN_DEBUG "session %p param 0x%02x", session, param);
 	session->output_report_success = 0; /* default condition */
 
 	switch (param) {

-- 
Jiri Kosina
SUSE Labs
