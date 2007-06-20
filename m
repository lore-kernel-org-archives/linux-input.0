From: Qi Yong <qiyong@mail.fc-cn.com>
Subject: [patch] add printk_ratelimit to atkbd_interrupt
Date: Wed, 20 Jun 2007 09:17:53 +0800
Message-ID: <20070620011753.GA16692@virgo.fc-cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dtor@mail.ru
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Add printk_ratelimit() to atkbd_interrupt(). I get "Spurious ACK" messages flushing on my
screen. This patch helps to read the screen.

Signed-off-by: Qi Yong <qiyong@mail.fc-cn.com>
--
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index be1fe46..13e6bd4 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -408,9 +408,10 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 			goto out;
 		case ATKBD_RET_ACK:
 		case ATKBD_RET_NAK:
-			printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
-			       "Some program might be trying access hardware directly.\n",
-			       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
+			if (printk_ratelimit())
+				printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
+				       "Some program might be trying access hardware directly.\n",
+				       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
 			goto out;
 		case ATKBD_RET_HANGEUL:
 		case ATKBD_RET_HANJA:
