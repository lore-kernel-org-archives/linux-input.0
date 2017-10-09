From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: allow matching device IDs on property bits
Date: Mon,  9 Oct 2017 15:34:09 -0700
Message-ID: <20171009223410.17164-2-dmitry.torokhov@gmail.com>
References: <20171009223410.17164-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009223410.17164-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Let's allow matching input devices on their property bits, both in-kernel
and when generating module aliases.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c             | 3 ++-
 include/linux/input.h             | 4 ++++
 include/linux/mod_devicetable.h   | 3 +++
 scripts/mod/devicetable-offsets.c | 1 +
 scripts/mod/file2alias.c          | 6 +++++-
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a8d4f1653588..58c0b7344fdf 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -965,7 +965,8 @@ bool input_match_device_id(const struct input_dev *dev,
 	    !bitmap_subset(id->ledbit, dev->ledbit, LED_MAX) ||
 	    !bitmap_subset(id->sndbit, dev->sndbit, SND_MAX) ||
 	    !bitmap_subset(id->ffbit, dev->ffbit, FF_MAX) ||
-	    !bitmap_subset(id->swbit, dev->swbit, SW_MAX)) {
+	    !bitmap_subset(id->swbit, dev->swbit, SW_MAX) ||
+	    !bitmap_subset(id->propbit, dev->propbit, INPUT_PROP_MAX)) {
 		return false;
 	}
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 066093fb8b3c..9e27e6d1d7d2 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -238,6 +238,10 @@ struct input_dev {
 #error "SW_MAX and INPUT_DEVICE_ID_SW_MAX do not match"
 #endif
 
+#if INPUT_PROP_MAX != INPUT_DEVICE_ID_PROP_MAX
+#error "INPUT_PROP_MAX and INPUT_DEVICE_ID_PROP_MAX do not match"
+#endif
+
 #define INPUT_DEVICE_ID_MATCH_DEVICE \
 	(INPUT_DEVICE_ID_MATCH_BUS | INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT)
 #define INPUT_DEVICE_ID_MATCH_DEVICE_AND_VERSION \
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3f74ef2281e8..72f0b7f19c59 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -293,6 +293,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
 #define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_PROP_MAX	0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
 #define INPUT_DEVICE_ID_MATCH_VENDOR	2
@@ -308,6 +309,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_MATCH_SNDBIT	0x0400
 #define INPUT_DEVICE_ID_MATCH_FFBIT	0x0800
 #define INPUT_DEVICE_ID_MATCH_SWBIT	0x1000
+#define INPUT_DEVICE_ID_MATCH_PROPBIT	0x2000
 
 struct input_device_id {
 
@@ -327,6 +329,7 @@ struct input_device_id {
 	kernel_ulong_t sndbit[INPUT_DEVICE_ID_SND_MAX / BITS_PER_LONG + 1];
 	kernel_ulong_t ffbit[INPUT_DEVICE_ID_FF_MAX / BITS_PER_LONG + 1];
 	kernel_ulong_t swbit[INPUT_DEVICE_ID_SW_MAX / BITS_PER_LONG + 1];
+	kernel_ulong_t propbit[INPUT_DEVICE_ID_PROP_MAX / BITS_PER_LONG + 1];
 
 	kernel_ulong_t driver_info;
 };
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index e4d90e50f6fe..812657ab5aa3 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -105,6 +105,7 @@ int main(void)
 	DEVID_FIELD(input_device_id, sndbit);
 	DEVID_FIELD(input_device_id, ffbit);
 	DEVID_FIELD(input_device_id, swbit);
+	DEVID_FIELD(input_device_id, propbit);
 
 	DEVID(eisa_device_id);
 	DEVID_FIELD(eisa_device_id, sig);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 29d6699d5a06..bc25898f6df0 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -761,7 +761,7 @@ static void do_input(char *alias,
 			sprintf(alias + strlen(alias), "%X,*", i);
 }
 
-/* input:b0v0p0e0-eXkXrXaXmXlXsXfXwX where X is comma-separated %02X. */
+/* input:b0v0p0e0-eXkXrXaXmXlXsXfXwXprX where X is comma-separated %02X. */
 static int do_input_entry(const char *filename, void *symval,
 			  char *alias)
 {
@@ -779,6 +779,7 @@ static int do_input_entry(const char *filename, void *symval,
 	DEF_FIELD_ADDR(symval, input_device_id, sndbit);
 	DEF_FIELD_ADDR(symval, input_device_id, ffbit);
 	DEF_FIELD_ADDR(symval, input_device_id, swbit);
+	DEF_FIELD_ADDR(symval, input_device_id, propbit);
 
 	sprintf(alias, "input:");
 
@@ -816,6 +817,9 @@ static int do_input_entry(const char *filename, void *symval,
 	sprintf(alias + strlen(alias), "w*");
 	if (flags & INPUT_DEVICE_ID_MATCH_SWBIT)
 		do_input(alias, *swbit, 0, INPUT_DEVICE_ID_SW_MAX);
+	sprintf(alias + strlen(alias), "pr*");
+	if (flags & INPUT_DEVICE_ID_MATCH_PROPBIT)
+		do_input(alias, *propbit, 0, INPUT_DEVICE_ID_PROP_MAX);
 	return 1;
 }
 ADD_TO_DEVTABLE("input", input_device_id, do_input_entry);
-- 
2.14.2.920.gcf0c67979c-goog
