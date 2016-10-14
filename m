From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] [media] Input: synaptics-rmi4 - unlock on error
Date: Fri, 14 Oct 2016 20:14:27 +0300
Message-ID: <20161014171427.GA21917@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We should unlock before returning on this error path.

Fixes: 3a762dbd5347 ('[media] Input: synaptics-rmi4 - add support for F54 diagnostics')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index cf805b9..2e934ae 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -200,7 +200,7 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
 
 	error = rmi_write(rmi_dev, fn->fd.command_base_addr, F54_GET_REPORT);
 	if (error < 0)
-		return error;
+		goto unlock;
 
 	init_completion(&f54->cmd_done);
 
@@ -209,9 +209,10 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
 
 	queue_delayed_work(f54->workqueue, &f54->work, 0);
 
+unlock:
 	mutex_unlock(&f54->data_mutex);
 
-	return 0;
+	return error;
 }
 
 static size_t rmi_f54_get_report_size(struct f54_data *f54)
