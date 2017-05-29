From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] Input: synaptics - clear device info before filling in
Date: Sun, 28 May 2017 22:27:07 -0700
Message-ID: <20170529052707.2144-1-ebiggers3@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33014 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdE2FaM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 01:30:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

synaptics_query_hardware() was being passed a
'struct synaptics_device_info' in uninitialized stack memory, then not
always initializing all fields.  This caused garbage to show up in
certain fields, making the touchpad unusable.

Fix by zeroing the device info, so all fields default to 0.

Fixes: 6c53694fb222 ("Input: synaptics - split device info into a separate structure")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 131df9d3660f..4f97970abc94 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -397,6 +397,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse,
 {
 	int error;
 
+	memset(info, 0, sizeof(*info));
+
 	error = synaptics_identify(psmouse, info);
 	if (error)
 		return error;
-- 
2.13.0

