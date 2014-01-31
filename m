From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/6] HID: hidp: Store the device MAC in client_addr.
Date: Fri, 31 Jan 2014 12:32:49 -0500
Message-ID: <1391189573-2591-3-git-send-email-frank.praznik@oh.rr.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34862 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbaAaRdD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 12:33:03 -0500
In-Reply-To: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Have hidp store the client device MAC address in client_addr

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 net/bluetooth/hidp/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 292e619..f256f33 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -772,6 +772,9 @@ static int hidp_setup_hid(struct hidp_session *session,
 	snprintf(hid->uniq, sizeof(hid->uniq), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->dst);
 
+	memcpy(hid->client_addr, &l2cap_pi(session->ctrl_sock->sk)->chan->dst,
+		sizeof(hid->client_addr));
+
 	hid->dev.parent = &session->conn->hcon->dev;
 	hid->ll_driver = &hidp_hid_driver;
 
-- 
1.8.5.3

