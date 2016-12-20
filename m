From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: synaptics-rmi4: check for non zero version logically dead code
Date: Tue, 20 Dec 2016 09:56:49 +0000
Message-ID: <20161220095649.7674-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933516AbcLTJ5c (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Dec 2016 04:57:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

version is a u8, the check for version > 0 means that version can only
be zero, so the subsequent check for version != 0 is never true and
hence is redudant code and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/rmi4/rmi_f34.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 9774dfb..c3285ce 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -441,8 +441,6 @@ static int rmi_f34_probe(struct rmi_function *fn)
 	/* v5 code only supported version 0, try V7 probe */
 	if (version > 0)
 		return rmi_f34v7_probe(f34);
-	else if (version != 0)
-		return -ENODEV;
 
 	f34->bl_version = 5;
 
-- 
2.10.2

