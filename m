From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [patch 3/3] Input: cyttsp4 - leak on error path in probe()
Date: Wed, 3 Jul 2013 16:12:48 +0300
Message-ID: <51D42350.10504@cypress.com>
References: <20130702214455.GC1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20130702214455.GC1598@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 07/03/2013 12:44 AM, Dan Carpenter wrote:
> We leak "cd" if the cd->xfer_buf allocation fails.  It was weird to
> "goto error_gpio_irq" so I changed the label name.  (Label names should
> reflect the label location not the goto location otherwise you get an
> "all roads lead to Rome problem").
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
xfer_buf still may not be freed, I propose following one instead:

From: Ferruh Yigit <fery@cypress.com>
Date: Wed, 3 Jul 2013 15:59:54 +0300
Subject: [PATCH] Input: cyttsp4 - free xfer_buf in error path

Label for xfer_buf error is wrong and causing mem leak for cd.
Updated label for xfer_buf alloc failure and add kfree for xfer_buf

Signed-off-by: Ferruh Yigit <fery@cypress.com>
---
  drivers/input/touchscreen/cyttsp4_core.c |    4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c
b/drivers/input/touchscreen/cyttsp4_core.c
index 69c9cff..219e32d 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -2034,7 +2034,7 @@ struct cyttsp4 *cyttsp4_probe(const struct
cyttsp4_bus_ops *ops,
      if (!cd->xfer_buf) {
          dev_err(dev, "%s: Error, kzalloc\n", __func__);
          rc = -ENOMEM;
-        goto error_alloc_data;
+        goto error_alloc_xfer;
      }

      /* Initialize device info */
@@ -2127,6 +2127,8 @@ error_request_irq:
          cd->cpdata->init(cd->cpdata, 0, dev);
      dev_set_drvdata(dev, NULL);
  error_gpio_irq:
+    kfree(cd->xfer_buf);
+error_alloc_xfer:
      kfree(cd);
  error_alloc_data:
  error_no_pdata:
--
1.7.9.5
This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
