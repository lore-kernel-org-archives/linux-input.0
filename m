Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0E35CBB4;
	Tue, 27 Jan 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525525; cv=none; b=M76D34AOnlYEqrSCxfzF3aPopfhAc4MWpoP7RyT7MjSM/hxkb4V319Vtl8hGsnooDatTKm09GFk8JqNSCeE8qM6kGHM0eU3VKpRBOWAPFOAh+y7N54ofTsB4Z7ODBWURPPGHq0oN+LVMyd8/Ih4hBN1zgI8/gZ27FsYV2fHFzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525525; c=relaxed/simple;
	bh=sTuKmKs+MqyixoLYvUkl/qsU9H4HeSU66GDIdTbkekA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tutASzhPeq182CVbBWxNOoWRbgruGc8l7N77fujNnvHcM6oryf7RpAdWXA81DctUZFxQDL7B+GZCY1tScoezotuuYESEEQu1KMxR2T4zMLdYNZJrq4S0shgGnIuJNo1fWsRzmaAJeWfOyRJFIogNNhSu3gKwp6AdxeAT7Dp1cBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=NuI4A0aw; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="NuI4A0aw"
Received: from pps.filterd (m0341555.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R44AVk2151983;
	Tue, 27 Jan 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=AMs/I
	eyIbZy1nwXxcGTgvzvyBjW0gzBr8/WuXtGmG0o=; b=NuI4A0awuhB+HIx4HmfF/
	KwAMn8tfWafeUTjWx2EGw05oKT7D2Gs8gmQPjc9SL7kkW9h1nV/C5fCkPryMT7hl
	9FDn4CCnlWWEk/W08uKQe7I/LW8QAVlS3YKgVMVSpO8tuB6h7QuI87GadpeVDu+S
	jvcCn2b+SWmhIvgVWjO83fnqzpMB0jnyfO/ntS6cf+sr51HhgqT9XT1mRTFSjlCI
	EmV+iMWyjMZbWqE6SZ3GZug8FBqYLcCSr6WJncdpssvyGNZXv2MCXnIxLdmYSiZP
	7fMM+1o6Wl5scZ4xKI8NCdDXv5L+OOKBmkQncv/UnI0doD07b6kwRrLGBDqEmBL9
	A==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bwcb144b1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:51:42 +0000 (GMT)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id DCD14580C4;
	Tue, 27 Jan 2026 08:51:41 -0600 (CST)
From: Danny Kaehn <danny.kaehn@plexus.com>
Date: Tue, 27 Jan 2026 08:47:50 -0600
Subject: [PATCH v13 3/3] HID: cp2112: Configure I2C Bus Speed from Firmware
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-cp2112-dt-v13-3-6448ddd4bf22@plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
In-Reply-To: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Danny Kaehn <danny.kaehn@plexus.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769525272; l=1081;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=sTuKmKs+MqyixoLYvUkl/qsU9H4HeSU66GDIdTbkekA=;
 b=4MODlWIYOuNwLzbSsNQer/HmwNaiys0dMZu9GCrVS3Ro409Uu25RlmMtdM/VYgOGM/M2eRHMe
 OIngCA196C1BfkEH6QUdaj4dam1Dp26MZLXGZIy+6KKJ49qJJSnZvxs
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QvVTHFyd c=1 sm=1 tr=0 ts=6978d0fe cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y_joWELsAAAA:8 a=B4QkrQ5K2Q0oYPUHz0oA:9 a=QEXdDO2ut3YA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-GUID: NeWbfRo8c_k6o4E1Y-ByzzzFqSMYkONn
X-Proofpoint-ORIG-GUID: 5tlxGXixyJ4R1ECK3t9AjI4UWh8Wy9yP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX0uXa69E2uI/z
 rLgB6vxR+4mcSjWBQbTvgQk7sEH7sPN8uwBbArZHtkmuTyynYuoubMTX9d/866qH3dCyrHJpHDM
 a31LLswEnU4H+qB9UZOluH0lo5oHntVeiHqFzEolMsu/8+Xt1qJ+N5xpTRkMzDauYx86aLP5ZA2
 O17//OT4Xr0VLf/9qaBQsjfpMuQZPiKWYc9EHYk3QhmN4gvC4ye8FuLxK/ooQCl+5KwoHuIMzeT
 cvDzqzK9hNDqRh41EYXSAEKDqYFH1CbvICBwAJNO7z6obWsTWAWZ3hfYBiEWLK+1FTlbpy2rkBY
 GwUiEbonBG2QOnqeXnnnhPlSMr/N17/jLPNogAX5/8bwQ9/xLdSd50eTGuHRTkP7m9nZNjJ93Nf
 L2xlueX2LT/NoHlGYaNPunUVbFkIWEbUNlo5DDHmeTqb12rrFEwYQYbtsDzDJSGrT5sjqB3H24V
 +vctiY+xj2hdchw0y6A==
X-Proofpoint-Spam-Reason: orgsafe

Now that the I2C adapter on the CP2112 can have an associated firmware
node, set the bus speed based on firmware configuration

Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
---
 drivers/hid/hid-cp2112.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index ea19b5cb58f9..4c5957e0a5cc 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1220,6 +1220,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_smbus_config_report config;
 	struct fwnode_handle *child;
 	struct gpio_irq_chip *girq;
+	struct i2c_timings timings;
 	u32 addr;
 	int ret;
 
@@ -1304,6 +1305,9 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_power_normal;
 	}
 
+	i2c_parse_fw_timings(&dev->adap.dev, &timings, true);
+
+	config.clock_speed = cpu_to_be32(timings.bus_freq_hz);
 	config.retry_time = cpu_to_be16(1);
 
 	ret = cp2112_hid_output(hdev, (u8 *)&config, sizeof(config),

-- 
2.25.1

