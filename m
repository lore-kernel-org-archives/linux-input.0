From: Teika Kazura <teika@gmx.com>
Subject: [PATCH v2 1/1] Input: synaptics - Enable RMI4 for Clevo P870DM
 laptops.
Date: Mon, 30 Jul 2018 20:35:27 +0900 (JST)
Message-ID: <20180730.203527.1651668819503376656.teika@gmx.com>
References: <20180730.201359.525452745785453302.teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730.201359.525452745785453302.teika@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rosenp@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jan.steffens@gmail.com, waltercool@slash.cl
List-Id: linux-input@vger.kernel.org

This patch enables SMBus/RMI4 for PCs with SYN1219, e.g. Clevo P870DM etc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Co-Developed-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
---
drivers/input/mouse/synaptics.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a9591d2..0669770 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,7 +179,7 @@ static const char * const smbus_pnp_ids[] = {
"LEN0096", /* X280 */
"LEN0097", /* X280 -> ALPS trackpoint */
"LEN200f", /* T450s */
+	"SYN1219", /* Schenker H506 (rebrand of Clevo P651RG), Clevo P870DM */
NULL
};

--
2.16.1
