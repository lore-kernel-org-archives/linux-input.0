From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 19/63] Input: atmel_mxt_ts - check data->input_dev is not null in mxt_input_sync()
Date: Fri, 16 Aug 2019 17:32:13 +0900
Message-ID: <20190816083257.18546-5-jiada_wang@mentor.com>
References: <20190816083257.18546-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083257.18546-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Janus Cheng <drxaero@gmail.com>

* Symptom: if update_fw and update_cfg, kernel panic occurs.
* Reproducibility: 10%
* Root Cause:
  - If update_fw, the T6 will send a CFG_ERR message periodically.
  - After that, update_cfg process begin, the mxt_update_cfg_store() will
    invoke mxt_free_input_device() and nullify data->input_dev.
  - The CFG_ERR message will trigger mxt_interrupt(), and mxt_input_sync()
    will be invoked by mxt_process_messages_t44(). And mxt_input_sync()
    references a NULL data->input_dev and kernel panic occurs.

TrackerRMS TKT-004235

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit c909ada856861f305653b127db3ea0fa60264331)
[gdavis: Resolve forward port conflicts due to applying upstream
	 commit 96a938aa214e ("Input: atmel_mxt_ts - remove platform
	 data support").]
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index a4f8364ecca9..99e5c84d207a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -837,9 +837,11 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
 
 static void mxt_input_sync(struct mxt_data *data)
 {
-	input_mt_report_pointer_emulation(data->input_dev,
-					  data->t19_num_keys);
-	input_sync(data->input_dev);
+	if (data->input_dev) {
+		input_mt_report_pointer_emulation(data->input_dev,
+						  data->t19_num_keys);
+		input_sync(data->input_dev);
+	}
 }
 
 static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
-- 
2.19.2
