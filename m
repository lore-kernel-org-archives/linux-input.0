From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 5/5] HID: hidp: Add a comment that some devices depend on the current behavior of uniq
Date: Thu, 20 Feb 2014 11:36:04 -0500
Message-ID: <1392914164-31899-6-git-send-email-frank.praznik@oh.rr.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59700 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbaBTQgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:14 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add a comment noting that some devices depend on the destination address being
stored in uniq.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 net/bluetooth/hidp/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 77c4bad..98e4840 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -767,6 +767,9 @@ static int hidp_setup_hid(struct hidp_session *session,
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);
 
+	/* NOTE: Some device modules depend on the dst address being stored in
+	 * uniq. Please be aware of this before making changes to this behavior.
+	 */
 	snprintf(hid->uniq, sizeof(hid->uniq), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->dst);
 
-- 
1.8.5.3

