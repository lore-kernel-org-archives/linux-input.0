From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Tue, 18 Sep 2007 00:59:39 -0400
Message-ID: <200709180059.40257.dtor@insightbb.com>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp> <200704250134.33610.dtor@insightbb.com> <200704260640.l3Q6eP6R020764@mbox32.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704260640.l3Q6eP6R020764@mbox32.po.2iij.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Yoichi,

I tried adding loadable keymap support to the cobalt buttons driver so
that users can adjust keycodes if they are not satisfied with the default
selection. I would like to ask you to give this patch a spin when you
have a minute to spare as I do not own the hardware and terefore is unable
to test the patch myself.

The easies way to test I believe with the keyfuzz utility:

	http://0pointer.de/lennart/projects/keyfuzz/

Cobalt_btns uses 0-7 range of "scancodes".

Thank you in advance.

-- 
Dmitry

Input: cobalt_btns - add support for loadable keymaps

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/cobalt_btns.c |   73 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

Index: linux/drivers/input/misc/cobalt_btns.c
===================================================================
--- linux.orig/drivers/input/misc/cobalt_btns.c
+++ linux/drivers/input/misc/cobalt_btns.c
@@ -27,55 +27,48 @@
 #define BUTTONS_COUNT_THRESHOLD	3
 #define BUTTONS_STATUS_MASK	0xfe000000
 
+static const unsigned short cobalt_map[] = {
+	KEY_RESERVED,
+	KEY_RESTART,
+	KEY_LEFT,
+	KEY_UP,
+	KEY_DOWN,
+	KEY_RIGHT,
+	KEY_ENTER,
+	KEY_SELECT
+};
+
 struct buttons_dev {
 	struct input_polled_dev *poll_dev;
+	unsigned short keymap[ARRAY_SIZE(cobalt_map)];
+	int count[ARRAY_SIZE(cobalt_map)];
 	void __iomem *reg;
 };
 
-struct buttons_map {
-	uint32_t mask;
-	int keycode;
-	int count;
-};
-
-static struct buttons_map buttons_map[] = {
-	{ 0x02000000, KEY_RESTART, },
-	{ 0x04000000, KEY_LEFT, },
-	{ 0x08000000, KEY_UP, },
-	{ 0x10000000, KEY_DOWN, },
-	{ 0x20000000, KEY_RIGHT, },
-	{ 0x40000000, KEY_ENTER, },
-	{ 0x80000000, KEY_SELECT, },
-};
-
 static void handle_buttons(struct input_polled_dev *dev)
 {
-	struct buttons_map *button = buttons_map;
 	struct buttons_dev *bdev = dev->private;
 	struct input_dev *input = dev->input;
 	uint32_t status;
 	int i;
 
-	status = readl(bdev->reg);
-	status = ~status & BUTTONS_STATUS_MASK;
+	status = ~readl(bdev->reg) >> 24;
 
-	for (i = 0; i < ARRAY_SIZE(buttons_map); i++) {
-		if (status & button->mask) {
-			button->count++;
+	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
+		if (status & (1UL << i)) {
+			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 1);
+				input_sync(input);
+			}
 		} else {
-			if (button->count >= BUTTONS_COUNT_THRESHOLD) {
-				input_report_key(input, button->keycode, 0);
+			if (bdev->count[i] >= BUTTONS_COUNT_THRESHOLD) {
+				input_event(input, EV_MSC, MSC_SCAN, i);
+				input_report_key(input, bdev->keymap[i], 0);
 				input_sync(input);
 			}
-			button->count = 0;
-		}
-
-		if (button->count == BUTTONS_COUNT_THRESHOLD) {
-			input_report_key(input, button->keycode, 1);
-			input_sync(input);
+			bdev->count[i] = 0;
 		}
-
-		button++;
 	}
 }
 
@@ -94,6 +87,8 @@ static int __devinit cobalt_buttons_prob
 		goto err_free_mem;
 	}
 
+	memcpy(bdev->keymap, cobalt_map, sizeof(bdev->keymap));
+
 	poll_dev->private = bdev;
 	poll_dev->poll = handle_buttons;
 	poll_dev->poll_interval = BUTTONS_POLL_INTERVAL;
@@ -104,11 +99,15 @@ static int __devinit cobalt_buttons_prob
 	input->id.bustype = BUS_HOST;
 	input->cdev.dev = &pdev->dev;
 
-	input->evbit[0] = BIT(EV_KEY);
-	for (i = 0; i < ARRAY_SIZE(buttons_map); i++) {
-		set_bit(buttons_map[i].keycode, input->keybit);
-		buttons_map[i].count = 0;
-	}
+	input->keycode = pdev->keymap;
+	input->keycodemax = ARRAY_SIZE(pdev->keymap);
+	input->keycodesize = sizeof(unsigned short);
+
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input->evbit);
+	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
+		__set_bit(input->keycode[i], input->keybit);
+	__clear_bit(KEY_RESERVED, input->keybit);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
