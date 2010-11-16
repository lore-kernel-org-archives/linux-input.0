From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 1/5] qt602240_ts: fix wrong sizeof in object table allocation
Date: Tue, 16 Nov 2010 12:41:50 -0800
Message-ID: <20101116204150.28796.21244.stgit@localhost6.localdomain6>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14454 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114Ab0KPUlv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:41:51 -0500
In-Reply-To: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

The kcalloc call for the object table is using sizeof(struct qt602240_data)
when it should be using sizeof(struct qt6602240_object), resulting in a larger
allocation than is required.

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 66b26ad..0b92c9d 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -969,7 +969,7 @@ static int qt602240_initialize(struct qt602240_data *data)
 		return error;
 
 	data->object_table = kcalloc(info->object_num,
-				     sizeof(struct qt602240_data),
+				     sizeof(struct qt602240_object),
 				     GFP_KERNEL);
 	if (!data->object_table) {
 		dev_err(&client->dev, "Failed to allocate memory\n");

