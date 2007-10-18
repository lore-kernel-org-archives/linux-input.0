From: Bryan Wu <bryan.wu@analog.com>
Subject: [PATCH 1/1] INPUT/BF54x-KEYPAD driver:  Remove useless line -errno returned by irq_request
Date: Thu, 18 Oct 2007 13:57:35 +0800
Message-ID: <1192687055-11935-1-git-send-email-bryan.wu@analog.com>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Cc: Andrey Panin <pazke@donpac.ru>, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <bryan.wu@analog.com>
List-Id: linux-input@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Cc: Andrey Panin <pazke@donpac.ru>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <bryan.wu@analog.com>
---
 drivers/input/keyboard/bf54x-keys.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index a67b29b..e5f4da9 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -256,7 +256,6 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 		printk(KERN_ERR DRV_NAME
 			": unable to claim irq %d; error %d\n",
 			bf54x_kpad->irq, error);
-		error = -EBUSY;
 		goto out2;
 	}
 
-- 
1.5.3.4
