From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 06/18] HID: Improve another size determination in
 hid_scan_report()
Date: Tue, 7 Feb 2017 20:48:06 +0100
Message-ID: <9e4f4fea-3608-5a11-8f7d-56f0242c46a4@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 19:10:53 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 16c73bf49d55..b943b2ebadc1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -787,7 +787,7 @@ static int hid_scan_report(struct hid_device *hid)
 		hid_parser_reserved
 	};
 
-	parser = vzalloc(sizeof(struct hid_parser));
+	parser = vzalloc(sizeof(*parser));
 	if (!parser)
 		return -ENOMEM;
 
-- 
2.11.1
