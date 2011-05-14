From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/2] drivers/input/touchscreen/atmel_tsadcc.c: Correct call to input_free_device
Date: Sat, 14 May 2011 16:18:54 +0200
Message-ID: <1305382735-11474-1-git-send-email-julia@diku.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

This error handling code can be reached before ts_dev->input is
initialized, so it is safer to always use the original name, input_dev.

A simplified version of the semantic match that finds this problem is:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression struct input_dev * x;
expression ra,rr;
position p1,p2;
@@

x = input_allocate_device@p1(...)
...  when != x = rr
     when != input_free_device(x,...)
     when != if (...) { ... input_free_device(x,...) ...}
if(...) { ... when != x = ra
     when forall
     when != input_free_device(x,...)
 \(return <+...x...+>; \| return@p2...; \) }

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

cocci.print_main("input_allocate_device",p1)
cocci.print_secs("input_free_device",p2)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/input/touchscreen/atmel_tsadcc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index 3d9b516..432c69b 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -317,7 +317,7 @@ err_unmap_regs:
 err_release_mem:
 	release_mem_region(res->start, resource_size(res));
 err_free_dev:
-	input_free_device(ts_dev->input);
+	input_free_device(input_dev);
 err_free_mem:
 	kfree(ts_dev);
 	return err;
