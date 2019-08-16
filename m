From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 41/63] Input: touchscreen: Atmel: Enable IRQ_DISABLE_UNLAZY flag for interrupt
Date: Fri, 16 Aug 2019 17:35:36 +0900
Message-ID: <20190816083558.19189-2-jiada_wang@mentor.com>
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

From: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>

The de-/serializer driver has defined only irq_mask "ds90ub927_irq_mask" and
irq_unmask "ds90ub927_irq_unmask" callback functions. And de-/serializer
driver doesn't implement the irq_disable and irq_enable callback functions.
Hence inorder to invoke irq_mask callback function when disable_irq_nosync is
called the IRQ_DISABLE_UNLAZY interrupt flag should be set. If not the
disable_irq_nosync will just increment the depth field in the irq
descriptor only once as shown below.

disable_irq_nosync
 __disable_irq_nosync
  __disable_irq (desc->depth++)
   irq_disable
    if irq_disable present -----------> if IRQ_DISABLE_UNLAZYflag set
             |                  no                  |
         yes |                                  yes |
             |                                      |
     desc->irq_data.chip->irq_disable   desc->irq_data.chip->irq_unmask
                                         (ds90ub927_irq_mask)
                                          disable_irq
                                           __disable_irq_nosync
                                            __disable_irq
(desc->depth++)
But the enable_irq will try to decrement the depth field twice which generates
the backtrace stating "Unbalanced enable for irq 293". This is because there is
no IRQ_DISABLE_UNLAZY flag check while calling irq_unmask callback function
of the "ds90ub927_irq_unmask" de-/serializer via enable_irq.

enable_irq
 __enable_irq (desc->depth--)
  irq_enable
   if irq_enable present -------------> desc->irq_data.chip->irq_unmask
              |                no        (ds90ub927_irq_unmask)
          yes |                            enable_irq
              |                             __enable_irq (desc->depth--)
    (desc->irq_data.chip->irq_enable)

Signed-off-by: Bhuvanesh Surachari <bhuvanesh_surachari@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index bc94adec6631..c6ba061098c0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -4349,6 +4349,8 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
 		 client->adapter->nr, client->addr);
 
+	irq_set_status_flags(client->irq, IRQ_DISABLE_UNLAZY);
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 
@@ -4434,6 +4436,8 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		sysfs_remove_link(&client->dev.kobj, "reset");
 		gpiod_unexport(data->reset_gpio);
 	}
+	if (data->irq)
+		irq_clear_status_flags(data->irq, IRQ_DISABLE_UNLAZY);
 	return error;
 }
 
@@ -4449,6 +4453,8 @@ static int mxt_remove(struct i2c_client *client)
 	}
 	mxt_debug_msg_remove(data);
 	mxt_sysfs_remove(data);
+	if (data->irq)
+		irq_clear_status_flags(data->irq, IRQ_DISABLE_UNLAZY);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
 
-- 
2.19.2
