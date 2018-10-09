From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: google: drop superfluous const before
 SIMPLE_DEV_PM_OPS()
Date: Tue, 9 Oct 2018 10:48:04 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810091046050.14430@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

SIMPLE_DEV_PM_OPS() already implies const for the type; drop the extra 
modifier.

Fixes: eb1aac4c8744f75460c34d71b0c73bebf3e8ee5c ("HID: google: add support tablet mode switch for Whiskers")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

In hid.git#for-4.20/google

 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index de3e7d055ca4..ee5e0bdcf078 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -161,7 +161,7 @@ static __maybe_unused int cbas_ec_resume(struct device *dev)
 	return 0;
 }
 
-static const SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
+static SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
 
 static void cbas_ec_set_input(struct input_dev *input)
 {

-- 
Jiri Kosina
SUSE Labs
