From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/2] HID: intel-ish-hid: add printf attribute to print_log()
Date: Thu, 22 Dec 2016 11:09:09 +0100
Message-ID: <20161222100910.6179-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:34587 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbcLVKJ5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Dec 2016 05:09:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Structure ishtp_device contains a logging function, print_log(), which
formats some of its parameters using vsnprintf(). Add a __printf
attribute to this function field (and to ish_event_tracer()) in order to
detect at compile time issues related to the printf-like formatting.

While at it, make format parameter a const pointer as print_log() is not
supposed to modify it.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c     | 3 ++-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 20d647d2dd2c..34c95de6885e 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -47,7 +47,8 @@ MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
  *
  * Callback to direct log messages to Linux trace buffers
  */
-static void ish_event_tracer(struct ishtp_device *dev, char *format, ...)
+static __printf(2, 3)
+void ish_event_tracer(struct ishtp_device *dev, const char *format, ...)
 {
 	if (trace_ishtp_dump_enabled()) {
 		va_list args;
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index a94f9a8a96a0..6a6d927b78b0 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -238,7 +238,8 @@ struct ishtp_device {
 	uint64_t ishtp_host_dma_rx_buf_phys;
 
 	/* Dump to trace buffers if enabled*/
-	void (*print_log)(struct ishtp_device *dev, char *format, ...);
+	__printf(2, 3) void (*print_log)(struct ishtp_device *dev,
+					 const char *format, ...);
 
 	/* Debug stats */
 	unsigned int	ipc_rx_cnt;
-- 
2.11.0

