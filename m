From: Joe Perches <joe@perches.com>
Subject: [PATCH 3/8] hid: Remove OOM message after input_allocate_device
Date: Wed, 23 Oct 2013 12:14:49 -0700
Message-ID: <890e072c3487378bf1203acf65cc0e204dea89bb.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1382555436.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-input.c        | 1 -
 drivers/hid/hid-picolcd_core.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 8741d95..aed8238 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1263,7 +1263,6 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	if (!hidinput || !input_dev) {
 		kfree(hidinput);
 		input_free_device(input_dev);
-		hid_err(hid, "Out of memory during hid input probe\n");
 		return NULL;
 	}
 
diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index acbb0210..f34ba0f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -431,10 +431,9 @@ static int picolcd_init_keys(struct picolcd_data *data,
 	}
 
 	idev = input_allocate_device();
-	if (idev == NULL) {
-		hid_err(hdev, "failed to allocate input device\n");
+	if (idev == NULL)
 		return -ENOMEM;
-	}
+
 	input_set_drvdata(idev, hdev);
 	memcpy(data->keycode, def_keymap, sizeof(def_keymap));
 	idev->name = hdev->name;
-- 
1.8.1.2.459.gbcd45b4.dirty
