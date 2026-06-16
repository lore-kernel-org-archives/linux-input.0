Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA521684BE;
	Tue, 16 Jun 2026 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579878; cv=none; b=HUUp3HWns54uPqsIyMPk/MOJfY3bW3iQKhZlkMrP9HoCIHr4boscPtEgSMeHPlXZjEWs2vw10JFtAFcSbgOtGtxdICabqQdNSOFHKbAKBY00YRguD1cYr9+ob9OOM2RgZS/VBCLcdA+/Cn/Ej3xB+QxKaYAm9roTyZcpJ4CFZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579878; c=relaxed/simple;
	bh=splptF6Ha7R6jWSoEO5WB17VOVKRQRVfHvvRsiOT6Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8INXXyXMZa+aYzMdmurKXX3rOvhfevkHKI6MYi+/QsrH5L0F7zK4LS4O+GZJ5debCM28Ty99AImXdDAMBG6+iUdZ4xyzIdCT/v0i6ugcnP+cj1NixJiqcH/98TUVvOgwy5yqaaB10FLo7w0Kqet3GciSPwF60m8oR1g6MCMU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oot8F/DJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oot8F/DJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781579876; x=1813115876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=splptF6Ha7R6jWSoEO5WB17VOVKRQRVfHvvRsiOT6Zc=;
  b=Oot8F/DJISZujQZC5Vt4zLfAleZWBGoWfIobbvyAKWXbUCxVQVMxVN3E
   WaFDTuDP1K3J7bFxmKpG1xMgtwmg6dCjc/0hC5U7KDeI1guMfwa2w83G6
   LHUmB2FfbZH6CzhMYmZ16dHn/IUmtVGDxOZvVlZvl+pm5H+6ejPBnZRKD
   eDPy09Cs/NvJMUOhmrtlw/f3Y12Po4icWhdc8W+O9JWLwjl1XAXr79ERO
   PKtYW8tGkFGz2riNb8FRMDrEyT8vY5vQkOF6DWZyNGz2tWB5BVv85dhiK
   Usicsua5PPU6UCVHl0ra+n6fgDrTuAOHgdI4hm0CTsPbgsOhO10T7PySY
   A==;
X-CSE-ConnectionGUID: kyWtpsQWQUmIYEMMAXtB5g==
X-CSE-MsgGUID: FS9vPF9gR5iPGti6Ax5b8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92652041"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="92652041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 20:17:55 -0700
X-CSE-ConnectionGUID: 6hShfk7JQ7u4m2GDQXMrBg==
X-CSE-MsgGUID: Rfb/1YsHT4KPTJJawpWyVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="251939630"
Received: from qat-server-366.sh.intel.com ([10.67.116.162])
  by orviesa004.jf.intel.com with ESMTP; 15 Jun 2026 20:17:54 -0700
From: Jie Wang <jie.wang@intel.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Input: yealink - stop URB resubmission on completion error
Date: Tue, 16 Jun 2026 11:04:40 +0000
Message-Id: <20260616110440.1073059-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
References: <68bba4fb.050a0220.192772.01a4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

urb_irq_callback() and urb_ctl_callback() resubmit each other's URBs
regardless of completion status. When the device returns a persistent
error (-EPROTO), this creates an unthrottled resubmission loop that
starves the CPU and triggers RCU stalls.

Stop resubmitting on any non-zero URB status, following the standard
completion pattern used by other USB input drivers.

Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
 drivers/input/misc/yealink.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 8786ed8b3565..bbfa1a9c23d1 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -414,9 +414,20 @@ static void urb_irq_callback(struct urb *urb)
 	struct yealink_dev *yld = urb->context;
 	int ret, status = urb->status;

-	if (status)
+	switch (status) {
+	case 0:
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
+			__func__, status);
+		return;
+	default:
 		dev_err(&yld->intf->dev, "%s - urb status %d\n",
 			__func__, status);
+		return;
+	}

 	switch (yld->irq_data->cmd) {
 	case CMD_KEYPRESS:
@@ -452,9 +463,20 @@ static void urb_ctl_callback(struct urb *urb)
 	struct yealink_dev *yld = urb->context;
 	int ret = 0, status = urb->status;

-	if (status)
+	switch (status) {
+	case 0:
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
+			__func__, status);
+		return;
+	default:
 		dev_err(&yld->intf->dev, "%s - urb status %d\n",
 			__func__, status);
+		return;
+	}

 	switch (yld->ctl_data->cmd) {
 	case CMD_KEYPRESS:
--
2.34.1
