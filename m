From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] input: keyboard: mtk-pmic-keys: Add of_node_put() before
 return
Date: Tue,  9 Jul 2019 23:30:19 +0530
Message-ID: <20190709180019.14339-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: matthias.bgg@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: linux-input@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous
node, but in the case of a return from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
return in three places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 746ff06eaf8d..62391d6c7da6 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -277,8 +277,10 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
 
 		keys->keys[index].irq = platform_get_irq(pdev, index);
-		if (keys->keys[index].irq < 0)
+		if (keys->keys[index].irq < 0) {
+			of_node_put(child);
 			return keys->keys[index].irq;
+		}
 
 		error = of_property_read_u32(child,
 			"linux,keycodes", &keys->keys[index].keycode);
@@ -286,6 +288,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 			dev_err(keys->dev,
 				"failed to read key:%d linux,keycode property: %d\n",
 				index, error);
+			of_node_put(child);
 			return error;
 		}
 
@@ -293,8 +296,10 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 			keys->keys[index].wakeup = true;
 
 		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
-		if (error)
+		if (error) {
+			of_node_put(child);
 			return error;
+		}
 
 		index++;
 	}
-- 
2.19.1
