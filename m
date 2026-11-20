Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181273;
	b=SMv7E5gTK95hR6Z1+drYsMoTYgT78e8BZUrmxMxR4r+HGjjE/KyoZFUIuM4kDj8Ccbsg
	 7C5u803VUZ9cnuTeRa2w95UhRP/oZ7dfluJQgww03xIKomi8BYpds8IMFEnCCLv9wgv5Q
	 8Vtpg//qlzHYpJJ2YoemARdmRA2qoFd4DTyEDe9VuP9ZfwYpEkb4aqeuuXkLYYyqmhLkI
	 tyyw4U4ackX1zZEHsLPo10ELV79vqVGkGNvz7DP9Xdsu2oRIA84EfPsLNJ+xxxLkYxl7P
	 hpXv5ayVvAMJh87v4xuhCnULU8JiZj/VAVDFAAm3kZPjhFLlkyiJXqMF/u2fnY+1cWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VSLj1GoWSSb4VpzXznLzz4Gd5QBwuASK+xu9mbOD2qM=;
	b=EYI8kxh9hyxYVKjk733f+JtyQMy/3UD6D3UapIGUsCs9LNjjNKULhnsAq6MHG+ekJ2sj
	 7HbIJn+lahClT9qKq//Sb33NsT8WVEUbJjChLZsnjKhAQIufZnZK3WT2WG/fY6uyb9MVz
	 UGtIGGW+P2Ex/eejAR69PVgi2e7/0VXtCCCdaj2j21Y1BdlT819FokjbG1zTK2Mp7tuZO
	 L2KKQGGMdNujvlcocmY4gK9omlRvmxw9VnTbnxMYsaRlInJRviTnbLKZ1Cn1VCvmvSmUc
	 FYDhqMbi265okadB6beqlJvShQVqs82B9JaJpPnZipNwjmhg5OxiKyHPrhAGhG9rnUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiEe1VjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C9606A320;
	Fri, 20 Nov 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiEe1VjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910201F000C0;
	Fri, 20 Nov 2026 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181273;
	bh=VSLj1GoWSSb4VpzXznLzz4Gd5QBwuASK+xu9mbOD2qM=;
	h=From:To:Cc:Subject:Date;
	b=aiEe1VjQtCt09ziV8z00wwfBZHsDxVl7PqSIUpwA/dtRh+qS/bOJxeg1ZAMYUI43E
	 T2/faMKEFet0xYAXI+7ogX3R/qMHdz945Bj3TpwXKe6sSHwL4RoaY4UvpQZkSsJFrL
	 +z1Vhz9hjjpYVSscWpMlnwSkjSQIbxH1NdcuvOXk9lOJ+FcIaO4gKnMovwlPCp6mZ4
	 0yiiZWAHCh6ZiJRlUouz+BwspgPbUEd/Hp9gyNVyhB15o43lYzNS4eyR7CGUfij6HM
	 LbgitXwEF9qdLr+qsQfTdP5GqrN3A5dORiI2rHogE0WPQB/4Uqz1S2ElQUTngHWxU3
	 OZKRe45q7ekRA==
From: Sasha Levin <sashal@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sensor: custom: Fix the sensor state allocation
Date: Fri, 20 Nov 2026 08:27:51 -0500
Message-ID: <20261120132751.2909204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d8dcea5754a2 ("HID: sensor: custom: Fix state lifetime during
removal") was applied with kzalloc(&pdev->dev, sizeof(*sensor_inst),
GFP_KERNEL), which does not build:

  drivers/hid/hid-sensor-custom.c:1023:46: error: macro 'kzalloc' passed 3 arguments, but takes just 2

The posted patch has kzalloc_obj(*sensor_inst). Use that.

Fixes: d8dcea5754a2 ("HID: sensor: custom: Fix state lifetime during removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

 drivers/hid/hid-sensor-custom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 66fca5c4855b5..8a71e86d247b1 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1019,8 +1019,7 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	int ret;
 	const struct hid_sensor_custom_match *match;
 
-	sensor_inst = kzalloc(&pdev->dev, sizeof(*sensor_inst),
-				   GFP_KERNEL);
+	sensor_inst = kzalloc_obj(*sensor_inst);
 	if (!sensor_inst)
 		return -ENOMEM;
 

base-commit: edf34adc3136d3e231f042b6622a51876bd80468
-- 
2.53.0

