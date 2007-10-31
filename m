From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] HID: Don't access input_dev->private directly
Date: Tue, 30 Oct 2007 20:50:03 -0400
Message-ID: <200710302050.03864.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

I'd like for the patch below to go to Linus rather sooner than
later because I want to commit patch removing input_dev->private...

..Or I could push it through my tree if you give me your Acked-by.

-- 
Dmitry


Subject: HID: Don't access input_dev->private directly
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

input_{get|set}_drvdata() helpers should be used instead.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/hid/hid-input.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/hid/hid-input.c
===================================================================
--- linux.orig/drivers/hid/hid-input.c
+++ linux/drivers/hid/hid-input.c
@@ -297,7 +297,7 @@ static struct hid_usage *hidinput_find_k
 static int hidinput_getkeycode(struct input_dev *dev, int scancode,
 				int *keycode)
 {
-	struct hid_device *hid = dev->private;
+	struct hid_device *hid = input_get_drvdata(dev);
 	struct hid_usage *usage;
 
 	usage = hidinput_find_key(hid, scancode, 0);
@@ -311,7 +311,7 @@ static int hidinput_getkeycode(struct in
 static int hidinput_setkeycode(struct input_dev *dev, int scancode,
 				int keycode)
 {
-	struct hid_device *hid = dev->private;
+	struct hid_device *hid = input_get_drvdata(dev);
 	struct hid_usage *usage;
 	int old_keycode;
 
