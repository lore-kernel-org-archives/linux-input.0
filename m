From: Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 2/2] input: atakbd.c - fix Atari CapsLock behaviour
Date: Fri,  7 Sep 2018 11:40:43 +1200
Message-ID: <1536277243-3821-3-git-send-email-schmitzmic@gmail.com>
References: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
In-Reply-To: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
Resent-Message-ID: <_V1roYKdOOG.A.13H.tsbkbB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1536277243-3821-3-git-send-email-schmitzmic@gmail.com
To: linux-input@vger.kernel.org
Cc: debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
List-Id: linux-input@vger.kernel.org

The CapsLock key on Atari keyboards is not a toggle, it does send the
normal make and break scancodes.

Drop the CapsLock toggle handling code, which did cause the CapsLock
key to merely act as a Shift key.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---
 drivers/input/keyboard/atakbd.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index e989574..6caee80 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -185,14 +185,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
 
 		scancode = atakbd_keycode[scancode];
 
-		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
-			input_report_key(atakbd_dev, scancode, 1);
-			input_report_key(atakbd_dev, scancode, 0);
-			input_sync(atakbd_dev);
-		} else {
-			input_report_key(atakbd_dev, scancode, down);
-			input_sync(atakbd_dev);
-		}
+		input_report_key(atakbd_dev, scancode, down);
+		input_sync(atakbd_dev);
 	} else				/* scancodes >= 0xf3 are mouse data, most likely */
 		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
 
