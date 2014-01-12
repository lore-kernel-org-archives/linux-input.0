From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Drivers: input: serio:hyperv-keyoard: Handle 0xE1 prefix
Date: Sat, 11 Jan 2014 19:41:50 -0800
Message-ID: <1389498110-4790-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, vojtech@suse.cz, olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com
List-Id: linux-input@vger.kernel.org

Handle the 0xE1 prefix.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/input/serio/hyperv-keyboard.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 3a83c3c..6132619 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -160,7 +160,9 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 			if (info & IS_E0)
 				serio_interrupt(kbd_dev->hv_serio,
 						XTKBD_EMUL0, 0);
-
+			if (info & IS_E1)
+				serio_interrupt(kbd_dev->hv_serio,
+						XTKBD_EMUL1, 0);
 			scan_code = __le16_to_cpu(ks_msg->make_code);
 			if (info & IS_BREAK)
 				scan_code |= XTKBD_RELEASE;
-- 
1.7.4.1
