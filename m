From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V3 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
Date: Sun,  1 Apr 2012 10:08:04 +0800
Message-ID: <1333246084-14110-4-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com
List-Id: linux-input@vger.kernel.org

Direct keys usage may not start from KP_DKIN0, add a msk option
to configure the specifics for platforms that can skip some keys.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |    2 ++
 drivers/input/keyboard/pxa27x_keypad.c         |    9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
index 7ffb16b..5ce8d5e 100644
--- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
+++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
@@ -46,6 +46,8 @@ struct pxa27x_keypad_platform_data {
 	unsigned int	direct_key_map[MAX_DIRECT_KEY_NUM];
 	/* the key output may be low active */
 	int		direct_key_low_active;
+	/* give board a chance to choose the start direct key */
+	unsigned int	direct_key_mask;
 
 	/* rotary encoders 0 */
 	int		enable_rotary0;
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index a60f14e..7f7b724 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -391,7 +391,14 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	if (pdata->direct_key_num > direct_key_num)
 		direct_key_num = pdata->direct_key_num;
 
-	keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
+	/*
+	 * Direct keys usage may not start from KP_DKIN0, check the platfrom
+	 * mask data to config the specific.
+	 */
+	if (pdata->direct_key_mask)
+		keypad->direct_key_mask = pdata->direct_key_mask;
+	else
+		keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
 
 	/* enable direct key */
 	if (direct_key_num)
-- 
1.7.0.4
