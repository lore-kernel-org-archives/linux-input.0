From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V3 4/5] input: pxa27x-keypad: remove the unused members at
 platform data
Date: Mon, 17 Jun 2013 23:56:17 -0400
Message-ID: <1371527778-5236-5-git-send-email-chao.xie@marvell.com>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, arnd@arndb.de, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, drwyrm@gmail.com, stefan@openezx.org, laforge@openezx.org, robert.jarzmik@free.fr, marek.vasut@gmail.com, sleep_walker@suse.cz, slapin@ossfans.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xiechao.mail@gmail.com
Cc: Chao Xie <chao.xie@marvell.com>
List-Id: linux-input@vger.kernel.org

Now pxa27x-keypad make use matrix_keymap for matrix keyes, so
remove the unused members in platform data.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 include/linux/platform_data/keypad-pxa27x.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/keypad-pxa27x.h b/include/linux/platform_data/keypad-pxa27x.h
index 0db423b..2462556 100644
--- a/include/linux/platform_data/keypad-pxa27x.h
+++ b/include/linux/platform_data/keypad-pxa27x.h
@@ -39,8 +39,6 @@ struct pxa27x_keypad_platform_data {
 	const struct matrix_keymap_data *matrix_keymap_data;
 	unsigned int	matrix_key_rows;
 	unsigned int	matrix_key_cols;
-	unsigned int	*matrix_key_map;
-	int		matrix_key_map_size;
 
 	/* direct keys */
 	int		direct_key_num;
-- 
1.7.4.1
