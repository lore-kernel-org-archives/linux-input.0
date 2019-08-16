From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 43/63] Input: atmel_mxt_ts: update stale use_retrigen_workaround flag
Date: Fri, 16 Aug 2019 17:35:38 +0900
Message-ID: <20190816083558.19189-4-jiada_wang@mentor.com>
References: <20190816083558.19189-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083558.19189-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>

If after configuration update, retrigen status is enabled, the
mxt_check_retrigen() function, called after configuration update,
does not clear the use_retrigen_workaround flag, if it was previously
set.

Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e315ad3a8d2a..b3d40390abb6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1857,6 +1857,8 @@ static int mxt_check_retrigen(struct mxt_data *data)
 	int error;
 	int val;
 
+	data->use_retrigen_workaround = false;
+
 	if (irq_get_trigger_type(data->irq) & IRQF_TRIGGER_LOW)
 		return 0;
 
-- 
2.19.2
