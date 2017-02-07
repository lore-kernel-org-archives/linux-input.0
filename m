From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 07/18] HID: Improve another size determination in
 hid_register_report()
Date: Tue, 7 Feb 2017 20:49:32 +0100
Message-ID: <de8a2dfa-1154-2f27-aeb2-a7af405c7d61@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 19:12:56 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b943b2ebadc1..1f75c1c022f0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -67,7 +67,7 @@ struct hid_report *hid_register_report(struct hid_device *device, unsigned type,
 	if (report_enum->report_id_hash[id])
 		return report_enum->report_id_hash[id];
 
-	report = kzalloc(sizeof(struct hid_report), GFP_KERNEL);
+	report = kzalloc(sizeof(*report), GFP_KERNEL);
 	if (!report)
 		return NULL;
 
-- 
2.11.1

