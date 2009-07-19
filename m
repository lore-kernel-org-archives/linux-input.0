From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/10] drivers/hid: Move dereferences below a NULL test
Date: Sun, 19 Jul 2009 17:26:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907191725530.16542@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754671AbZGSP0T@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

If the NULL test is necessary, then the dereferences should be moved below
the NULL test.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
type T;
expression E,E1;
identifier i,fld;
statement S;
@@

- T i = E->fld;
+ T i;
  ... when != E=E1
      when != i
  if (E == NULL||...) S
+ i = E->fld;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/hid/hid-core.c              |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5ebbb8a..ca69cc3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1072,8 +1072,8 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  */
 int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int interrupt)
 {
-	struct hid_report_enum *report_enum = hid->report_enum + type;
-	struct hid_driver *hdrv = hid->driver;
+	struct hid_report_enum *report_enum;
+	struct hid_driver *hdrv;
 	struct hid_report *report;
 	char *buf;
 	unsigned int i;
@@ -1081,6 +1081,8 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 
 	if (!hid || !hid->driver)
 		return -ENODEV;
+	report_enum = hid->report_enum + type;
+	hdrv = hid->driver;
 
 	if (!size) {
 		dbg_hid("empty report\n");
