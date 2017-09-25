From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] HID: hyperv: pr_err() strings should end with newlines
Date: Mon, 25 Sep 2017 17:34:27 +0530
Message-ID: <c8e6ee81076db223671e9ad93966a8c89145ab7f.1506340963.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: devel@linuxdriverproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 6039f07..3aa2bb9 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -313,7 +313,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 
 		break;
 	default:
-		pr_err("unsupported hid msg type - type %d len %d",
+		pr_err("unsupported hid msg type - type %d len %d\n",
 		       hid_msg->header.type, hid_msg->header.size);
 		break;
 	}
-- 
1.9.1
