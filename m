Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1B37269C;
	Wed, 20 May 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294549; cv=none; b=DM+AKTWZfZB6GypFK1L3G9wLtDued3uaAHhReCPf2dOtJpo7svC7bZj6kbL6Yj/G1lFthaqbMkHVaLdNx8hsheuvE2gnzrJfgpDs1tOwejGKTFgVPlDrQ4cQddqYetTuthPG+vd88BSQhLOJMcYD7ce30mx5BnHw88P4Y8Zjn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294549; c=relaxed/simple;
	bh=suG8dC6iFbGT01beBy+Or5AFgL4+rw6hkPp79UlPWZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHwEgjyTm+CaDx5aUMsD74sSA120UDmRP952S+RK16d+haGJjPCZko3dcdeUFBinXUDuPZuGRDrDCLxoT5mZGhGylEIoNzI3OBMxyB/HC/JlTLxgqkR9bm6PGHsVMHSFY3dg4OFaeAuDajqdkzb/j1/HHkcbEUHxYo7nz3JIDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=EblFFYuB; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="EblFFYuB"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K5xJkP3281845;
	Wed, 20 May 2026 11:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=FDepI
	XZ2BcoCLxo+ojIJjscBodpAZyDdZeRvgHshr8w=; b=EblFFYuBd/FUA4YgdlDlj
	VCIrLA4AMBZtDhUregIuPz/kBLzjyR178/o8rlKkJaWkhoFHkfYXu6w8Rzysdhgx
	aYyLAlxUmeVOk6bcY6TaiK2e/I2k1EJ/3dPpmTzDopc29u9VJDhZyh46pUsa9mPC
	rnyd6Wtn/qegjdy30dLz6hYvqUDbF9aIxfuDnwIAUO11IaXuVqf3h22YWymqkEYZ
	mcLY0sXpA4Qk6/DKRoGwPDU2R6AkppJpu4F1mzBy7nzth5XqX2WU4gqygVVEX+rt
	jrJs0fripUWIT6UB4qBt07Fh4wJGS/ML3vqPmZ+Ecm6vhqNrFrQVlqrEivd0SshW
	A==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4e8tdctk9p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 11:14:39 -0500 (CDT)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 704163956B;
	Wed, 20 May 2026 11:14:38 -0500 (CDT)
From: Danny Kaehn <danny.kaehn@plexus.com>
Date: Wed, 20 May 2026 11:13:07 -0500
Subject: [PATCH v14 2/2] HID: cp2112: Configure I2C bus speed from firmware
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-cp2112-dt-v14-2-b1b4b6734b6f@plexus.com>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
In-Reply-To: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Danny Kaehn <danny.kaehn@plexus.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>,
        Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779293611; l=1142;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=suG8dC6iFbGT01beBy+Or5AFgL4+rw6hkPp79UlPWZY=;
 b=8Mz/TY76BJOYJis6PzwclggXCF1Nc74G+qHuAII8Fb0XVm6LsE10iltu9CuyE40hkKxSADqNW
 3cW+j1D3tB3Brs7cugKHubTHS/EmUuhymvXzROr4vARy4pFSilJ5E2a
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: N-3wVdKoT0WvDFSx_CR9qURGX7aHYcA3
X-Proofpoint-GUID: RU9o51AxCeYnUBvF5OuRmYZx-9_J8oNP
X-Authority-Analysis: v=2.4 cv=f5F4wuyM c=1 sm=1 tr=0 ts=6a0dddef cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=bWp6hkYQOWa87JmFC6wa:22 a=QyXUC8HyAAAA:8
 a=Y_joWELsAAAA:8 a=5Q0cJInN0W8t8_l8kPkA:9 a=QEXdDO2ut3YA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NyBTYWx0ZWRfX5Jtpg/Mzdaht
 SgUJyh4SsD1KwSywY7bfIjRKq95TrOf4Rz5kUNgkyZRXGf/HhmMsnTJ+IM6tW7/9YMdGO24CEM/
 948CxBDGkQpz1tsm6i3oOLF/55LCRm75P3POsG21xaZ90efs+E95ap4ZerwJUfbVD1Ave2DF2ai
 j1qaaA1unGrIQ2oZNXxEh5zvhtP9uGLovJk8VBAbQVX+Ga8f95Pm4MUnniCkvRR5Q45q+rZFx8W
 5ORkZsaXq+BMK4jnTMxv0T0NvnKGmCZMH752AOyDoGtQ/OKjlVeG9Ya4xZULwS39dFFavh0CSRB
 qqq8bz/8K30GraPRr7Cppw1b1JR1NVoRKiEN/XXJFvFM1MEB1v/AjC7E+i3WRk/MGC6zMzEfCQr
 z1tkYNxDUPeFce5bXamF17FqyWsUo0R4m0jNgLi9GK9SrKF6s4hymlwO3bbTqht9CZiOEJYc9g9
 SqcVrDm/9OTGnj2hdhQ==
X-Proofpoint-Spam-Reason: orgsafe

Now that the I2C adapter on the CP2112 can have an associated firmware
node, set the bus speed based on firmware configuration

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
---
 drivers/hid/hid-cp2112.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index e960fc988058..04379db93571 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1223,6 +1223,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct fwnode_handle *cp2112_fwnode;
 	struct fwnode_handle *child;
 	struct gpio_irq_chip *girq;
+	struct i2c_timings timings;
 	u32 addr;
 	int ret;
 
@@ -1308,6 +1309,9 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_power_normal;
 	}
 
+	i2c_parse_fw_timings(&dev->adap.dev, &timings, true);
+
+	config.clock_speed = cpu_to_be32(timings.bus_freq_hz);
 	config.retry_time = cpu_to_be16(1);
 
 	ret = cp2112_hid_output(hdev, (u8 *)&config, sizeof(config),

-- 
2.25.1

