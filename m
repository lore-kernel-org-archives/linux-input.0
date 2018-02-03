From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/6] hid-prodikeys: Delete an unnecessary variable
 initialisation in pk_probe()
Date: Sat, 3 Feb 2018 18:38:57 +0100
Message-ID: <fce3ae0c-3467-f6be-519b-79b592691153@users.sourceforge.net>
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 14:45:24 +0100

The local variable "pm" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 9cad4973a67b..2e79dfc92162 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -798,6 +798,6 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	unsigned long quirks = id->driver_data;
 	struct pk_device *pk;
-	struct pcmidi_snd *pm = NULL;
+	struct pcmidi_snd *pm;
 
 	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
-- 
2.16.1

