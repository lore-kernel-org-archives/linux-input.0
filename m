From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: intel-ish-hid: remove redundant variable num_frags
Date: Mon,  2 Jul 2018 10:40:28 +0100
Message-ID: <20180702094028.15428-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable num_frags is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'num_frags' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/intel-ish-hid/ishtp/hbm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index ae4a69f7f2f4..8b5dd580ceec 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -298,7 +298,6 @@ int ishtp_hbm_cl_flow_control_req(struct ishtp_device *dev,
 	struct ishtp_msg_hdr *ishtp_hdr = &hdr;
 	const size_t len = sizeof(struct hbm_flow_control);
 	int	rv;
-	unsigned int	num_frags;
 	unsigned long	flags;
 
 	spin_lock_irqsave(&cl->fc_spinlock, flags);
@@ -314,7 +313,6 @@ int ishtp_hbm_cl_flow_control_req(struct ishtp_device *dev,
 		return	0;
 	}
 
-	num_frags = cl->recv_msg_num_frags;
 	cl->recv_msg_num_frags = 0;
 
 	rv = ishtp_write_message(dev, ishtp_hdr, data);
-- 
2.17.1
