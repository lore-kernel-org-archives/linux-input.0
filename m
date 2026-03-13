Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A1370D77;
	Fri, 13 Mar 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387651; cv=none; b=kY+8aQVtmxhuUljskVIgHyasJlI6Ni3Tua+f3jmYg7xJKrd1QOU9hBBLBvmlZqTt6BAwwa34qCKFWxu2nw1F6Wl5IAbwBkHyaICFoaZcf+zlwYk1atvgPH0Htz5vF8ZvVNYeEZSZm24eYW0dMldwOTAWHeT7Gn5bPBDa5CEXE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387651; c=relaxed/simple;
	bh=3QqmwPcVZc8k3uaBkDLUg8TP+fsY6XrK3YKva52D7Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0KGXcF9xdRIvz1ySjeGeNTaiXfIm2XFZh6M+SSe2oByCRfmGJoywpDlIcTXy81sH0cm/+wpnvBeTVY6V2WoYWwHQhE7JO2flJyb88WmqLKt/In3tPaAXjjBLzCpoxxNW23JD1zRd/YeDhPbRSWAaTL2rm+EGPNkoDE6IZaOSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMgkgYZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMgkgYZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BAAC19421;
	Fri, 13 Mar 2026 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387650;
	bh=3QqmwPcVZc8k3uaBkDLUg8TP+fsY6XrK3YKva52D7Bg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gMgkgYZd4/MURMcZLKZGLE0DU6Algn4+iNBh9zGuTvCqX5XFItLz4ZW1gcxd0nkNU
	 /KyqtxI8vP9B1wDJo5NxhrV34rBkRUrQ5ZbEEh1S8flVXeVtcvFKqDOh8ndSeUPdy5
	 KBL5/1IY4ZSTkcaW+A9pleymw/VyxLbgighiym1fMMeIG0IW5eNmDAe8WqbCl6WRSv
	 MYLqzG9CQVHAflr3X246rl8mVceVhLxYiF3s7TVs2dWc16scEIsM4OYasJoU1hKKwk
	 fLS1nDJtLDy54Pj7Yy7i7Wog7p0TIZBrCKBCZp2i6014bbrsLzhif0Sz2C4UVBXCKj
	 BFyA/iaAQ5ESg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 13 Mar 2026 08:40:26 +0100
Subject: [PATCH 3/4] HID: fix LEDs when report is unnumbered
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wip-bpf-fixes-v1-3-74b860315060@kernel.org>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
In-Reply-To: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773387643; l=1378;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=3QqmwPcVZc8k3uaBkDLUg8TP+fsY6XrK3YKva52D7Bg=;
 b=B/AC2wrmv/5lOkOT0WFr5V+ywh6F72cGsnnEUYorpFw5S3a+GlsSjuQnDE1rxQFYJV/R8kbvy
 HF3LJ2iCxHSCwN2CuwLZk2oEpXLunHTbFNU61saQ1rsduw27LRc7RV7
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Both usbhid and i2c-hid are expecting the first byte of the incoming
data to be the report ID. It should be set to 0 when the report ID is
not used. Currently, we are not enforcing this, which means that if we
enforce HID-BPF for LEDs, we will not be able to send them.

Note that the allocated buffer takes into account that extra byte, so
this is safe to shift the data buffer by one.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-input.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d5308adb2894..eb84f63c51b8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1830,9 +1830,9 @@ static void hidinput_led_worker(struct work_struct *work)
 					      led_work);
 	struct hid_field *field;
 	struct hid_report *report;
+	__u8 *buf, *data;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1863,7 +1863,14 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (!buf)
 		return;
 
-	hid_output_report(report, buf);
+	data = buf;
+	if (!report->id) {
+		data = &buf[1];
+		len++;
+	}
+
+	hid_output_report(report, data);
+
 	/* synchronous output report */
 	ret = hid_hw_output_report(hid, buf, len);
 	if (ret == -ENOSYS)

-- 
2.52.0

