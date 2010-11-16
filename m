From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 5/5] qt602240_ts: add mXT224 identifier to id_table,
	to match Intel mid firmware identifier
Date: Tue, 16 Nov 2010 12:42:11 -0800
Message-ID: <20101116204211.28796.93820.stgit@localhost6.localdomain6>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756675Ab0KPUmL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:42:11 -0500
In-Reply-To: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

"mXT224" is used in the SFI tables to identify the presence of this I2C device.

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index efe975e..cdd5a8b 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -1432,6 +1432,7 @@ static int qt602240_resume(struct i2c_client *client)
 
 static const struct i2c_device_id qt602240_id[] = {
 	{ "qt602240_ts", 0 },
+	{ "mXT224", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, qt602240_id);

