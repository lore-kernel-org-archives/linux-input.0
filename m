From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: i2c-hid: fix memory leak during probe
Date: Tue, 20 Nov 2012 17:09:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211201706300.4609@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58633 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab2KTQJp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 11:09:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

In case we are returning from i2c_hid_probe() through the 'err' or 
err_mem_free labels, there is noone freeing the buffers allocated by 
i2c_hid_alloc_buffers().

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/i2c-hid/i2c-hid.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 11140bd..67ab5b7 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -892,6 +892,7 @@ err:
 	if (ihid->irq)
 		free_irq(ihid->irq, ihid);
 
+	i2c_hid_free_buffers(ihid);
 	kfree(ihid);
 	return ret;
 }

-- 
Jiri Kosina
SUSE Labs
