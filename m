From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: RE: [PATCH] HID: uhid: Fixes a bug with userspace bluetooth stacks,
 which causes hangs during certain operations
Date: Tue, 31 May 2016 21:10:36 +0000
Message-ID: <1DD62093774CEE42AFC16E785A1088045F496A74@USCULXMSG04.am.sony.com>
References: <1463602269-19844-1-git-send-email-roderick.colenbrander@sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463602269-19844-1-git-send-email-roderick.colenbrander@sony.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dh.herrmann@googlemail.com" <dh.herrmann@googlemail.com>, "jikos@kernel.org" <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "roderick@gaikai.com" <roderick@gaikai.com>
List-Id: linux-input@vger.kernel.org

Hi,

The patch in this thread is part of input work I'm doing with my team and will hopefully be the first of many, but we are new to the linux-input project. We shared this patch first in April and again about 2 weeks ago in May, but we haven't received any feedback so far. Originally the discussion leading to this patch was partially on linux-input, but then privately with David and he suggested the direction the patch took. I think the resulting patch is clean and self explanatory. We have tested the patch on various devices without issues. For us this patch fixes an important problem and we would like to get it included in the upstream kernel.

Thanks,
Roderick Colenbrander
Gaikai Inc, a Sony Interactive Entertainment Company
________________________________________
From: Roderick Colenbrander [roderick.colenbrander@sony.com]
Sent: Wednesday, May 18, 2016 1:11 PM
To: dh.herrmann@googlemail.com; jikos@kernel.org
Cc: benjamin.tissoires@redhat.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Colenbrander, Roelof; stable@vger.kernel.org
Subject: [PATCH] HID: uhid: Fixes a bug with userspace bluetooth stacks, which causes hangs during certain operations

Many devices use userspace bluetooth stacks like BlueZ or Bluedroid in combination
with uhid. If any of these stacks is used with a HID device for which the driver
performs a HID request as part .probe (or technically another HID operation),
this results in a deadlock situation. The deadlock results in a 5 second timeout
for I/O operations in HID drivers, so isn't fatal, but none of the I/O operations
have a chance of succeeding.

The root cause for the problem is that uhid only allows for one request to be
processed at a time per uhid instance and locks out other operations. This means
that if a user space is creating a new HID device through 'UHID_CREATE', which
ultimately triggers '.probe' through the HID layer. Then any HID request e.g. a
read for calibration data would trigger a HID operation on uhid again, but it
won't go out to userspace, because it is still stuck in UHID_CREATE.
In addition bluetooth stacks are typically single threaded, so they wouldn't be
able to handle any requests while waiting on uhid.

Lucikly the UHID spec is somewhat flexible and allows for fixing the issue,
without breaking user space. The idea which the patch implements as discussed
with David Herrmann is to decouple adding of a hid device (which triggers .probe)
from UHID_CREATE. The work will kick off roughly once UHID_CREATE completed (or
else will wait a tiny bit of time in .probe for a lock). A HID driver has to call
HID to call 'hid_hw_start()' as part of .probe once it is ready for I/O, which
triggers UHID_START to user space. Any HID operations should function now within
.probe and won't deadlock because userspace is stuck on UHID_CREATE.

We verified this patch on Bluedroid with Android 6.0 and on desktop Linux with
BlueZ stacks. Prior to the patch they had the deadlock issue.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/uhid.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 16b6f11..99ec3ff 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -51,10 +51,26 @@ struct uhid_device {
        u32 report_id;
        u32 report_type;
        struct uhid_event report_buf;
+       struct work_struct worker;
 };

 static struct miscdevice uhid_misc;

+static void uhid_device_add_worker(struct work_struct *work)
+{
+       struct uhid_device *uhid = container_of(work, struct uhid_device, worker);
+       int ret;
+
+       ret = hid_add_device(uhid->hid);
+       if (ret) {
+               hid_err(uhid->hid, "Cannot register HID device: error %d\n", ret);
+
+               hid_destroy_device(uhid->hid);
+               uhid->hid = NULL;
+               uhid->running = false;
+       }
+}
+
 static void uhid_queue(struct uhid_device *uhid, struct uhid_event *ev)
 {
        __u8 newhead;
@@ -498,18 +514,14 @@ static int uhid_dev_create2(struct uhid_device *uhid,
        uhid->hid = hid;
        uhid->running = true;

-       ret = hid_add_device(hid);
-       if (ret) {
-               hid_err(hid, "Cannot register HID device\n");
-               goto err_hid;
-       }
+       /* Adding of a HID device is done through a worker, to allow HID drivers
+        * which use feature requests during .probe to work, without they would
+        * be blocked on devlock, which is held by uhid_char_write.
+        */
+       schedule_work(&uhid->worker);

        return 0;

-err_hid:
-       hid_destroy_device(hid);
-       uhid->hid = NULL;
-       uhid->running = false;
 err_free:
        kfree(uhid->rd_data);
        uhid->rd_data = NULL;
@@ -550,6 +562,8 @@ static int uhid_dev_destroy(struct uhid_device *uhid)
        uhid->running = false;
        wake_up_interruptible(&uhid->report_wait);

+       cancel_work_sync(&uhid->worker);
+
        hid_destroy_device(uhid->hid);
        kfree(uhid->rd_data);

@@ -612,6 +626,7 @@ static int uhid_char_open(struct inode *inode, struct file *file)
        init_waitqueue_head(&uhid->waitq);
        init_waitqueue_head(&uhid->report_wait);
        uhid->running = false;
+       INIT_WORK(&uhid->worker, uhid_device_add_worker);

        file->private_data = uhid;
        nonseekable_open(inode, file);
