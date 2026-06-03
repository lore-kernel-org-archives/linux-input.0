Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB63E1221;
	Wed,  3 Jun 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455614; cv=none; b=qe3T7fE4Xu/bQt5lSF7c1CrMJQ/kQiIB6Dgfap6/qliNpLXnaCulbDomTxcOQonzJbVT/Uyqj/PCL2uSBT/qXbDTV5oXnaT1MynHM+MYRLiroFCO6vbuNN27T3bB2T8iVPfIrjEB0YUU1JbYzvh8cvKWVnrTguKYzwZoJ3bmR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455614; c=relaxed/simple;
	bh=LZyrFAREfbenyI/8kFl5MVoeQosSnyTKqGsrf2qyW+8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Kre+EzAH0hM3l+8krIVIBu5euyKgy2yC0aErxk6+OxNA5iv/AIjsK66NiZYBOXxIIo8h77xvEROMR6xX3Z5Hst2nqkz1m4vrCCXBsf1CpJgncurcCnI+eB7hoaEJB7XJDGf2KAIbGfgSX8w8AfKC5HyMwDXLoz5wzY14gz5MNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D+mb+Vpz; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D+mb+Vpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780455603; bh=C+k9r+/YSyYTJ2Gix7IabVkrBtGoHrW0plXNoFo49uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+mb+VpzoYawGAKOUuzS0t1ciLjgIWx0X/zMYQ+MQ9ySHMBn+hMnvnSOlJaU602qw
	 rEf39rGYsQQ3gUnZ63lAReBrEG/ngvrxLd/tyPbsdjRAWm4FEfZ6BfSAGTxnDqIDGy
	 ra2lhZ7iTVMgx2LD6IzEtDdFBZgfep37XWXDS+mo=
Received: from ASUS.localdomain ([113.65.236.26])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id EF6B6A8C; Wed, 03 Jun 2026 10:59:54 +0800
X-QQ-mid: xmsmtpt1780455594tcm5zn3wy
Message-ID: <tencent_81FCC0443B81A3078C17F44AB4B22DFB2E07@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G8QV7U73mJZPy4D2D7OjRJXX9qkMZUl0S9BGSi+KKfDzPhNsvyU
	 0tSemNlLMmHK8CoooIMlFc8jFQwvvSIxJP4GE+nz+DJt8khScodF+rrcRw6wIre7aWmUF1E/RRBT
	 Z62yMJPq2heNO9tK9KsLP2uMhkhHsAFNsISZPlOot4igBuDwBvmMPlrIUzQwuh3rFU+iIAjJ3nEt
	 uJgbYApEwfGczDl29W+RQwMzJUsYPZzWmz7gwfI6qEJXq5Pi+OTPA9QFiSEVZJEYfv9ebdzyHtXb
	 9mqJiEhlT+P3PpgWWqosO/mfFCwO//2jweOVECPbx5LanrJ3xpCeSSSVdamGdbmY/xMiPJwK56Ly
	 BWyy2EQGXVTIwwirBquQ1uqB68rZTjYJs0DASuR2CnG8z5Vwt5qkrzo6rVxr/aKPLix37ZRIbWCW
	 cdj04BzqsO6g+7Z7AQgrXYMyNmffdh3/LhI/bnerUXaHWQxDU7DzJFHjOgVlpqEWrjN17TUBDT7r
	 RWEhpuqphMv8iGy04QSkmmwH7PijY1/hRhx80LgjRMULMw5KBIE0zSYtnLvm2eZSMSWIeESowORR
	 tsCW4Q5zo6z8SbaWYNCSCoclMgk/bLD3ZtmBZjb3rF5F1rK6qv4haVGfXXYyOoooEJ2nTmSb+4Au
	 XVOtsgQ5ZXMPziBAMEod8MRKDPlOYb+v4G1VE/sHmV39eiYUocOxCUx/KQpWrt0/Qa/CTdBjXjGY
	 G7dkR2WxizsBctlgA5xGGQADEJbFSHkPXn7tIphykT7BOBq6vQAxiEsJb1rVf+BJP5YK2XvIHhk/
	 LZltdm6MicoAz5zXK4eWBhrp5na1ZUHXhUmdcC8IUSs6N4/qJ4Kfq+7LtnAl30Iae4fEfV3L4sZn
	 g6L2k22ZhGbRWaXPnv5Ur7Oxlt1AVoVfo1O9gMc1n+uB8MsHTI+a56YF0NsEKxCIzq2xzO+drC//
	 dLW2/tbo1H+2LjWomcD8s3DR8JSBgbOFQt0pzWPMxVNgClRv+qVZpdyHhiWqJUEoT1NI60R/hz5W
	 NulA51N1yVMzBElbVNXipDPdY2KSmf1BwLbkcEbcv+dhLzPMiwjdpH61+L3gtj3NnXi4XLzxb0u3
	 WZp2MdwVjalZ6WeBI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Steven Feng <steven@joint-cloud.com>
To: dmitry.torokhov@gmail.com
Cc: wens@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH] Input: axp20x-pek - add support for AXP313A variant
Date: Wed,  3 Jun 2026 10:59:50 +0800
X-OQ-MSGID: <20260603025950.573938-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZoMD9s0Xs_VBzIKC@google.com>
References: <ZoMD9s0Xs_VBzIKC@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power button support for the AXP313A PMIC. The AXP313A does not
have the PEK_KEY register (0x36) used to configure startup and shutdown
timings, unlike AXP20X and AXP221. Create a dedicated axp313a_info
configuration with NULL time tables to prevent regmap out-of-bounds
access.

For AXP313A, the sysfs attributes (startup/shutdown) are hidden using
the is_visible callback, as they are not supported by the hardware.

Signed-off-by: Steven Feng <steven@joint-cloud.com>
---
Changes in v3:
- Use is_visible to hide attributes instead of returning -EOPNOTSUPP
- Corrected author name from "steven" to "Steven Feng"

Changes in v2:
- Fixed regmap out-of-bounds access issue reported by Sashiko AI
- Created dedicated axp313a_info with NULL time tables
- Added NULL pointer checks to prevent crashes
- AXP313A lacks PEK_KEY (0x36) per datasheet verification
- Power button still functional using hardware default timings

v2: https://lore.kernel.org/all/tencent_48A497E0CA81323CFB6C7CB84428019A8707@qq.com/
v1: https://lore.kernel.org/all/tencent_5F1FF80489E702360F352F889570656BF608@qq.com/
---
 drivers/input/misc/axp20x-pek.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index d4e2fc9a937f..964b39817af9 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -85,6 +85,13 @@ static const struct axp20x_info axp221_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static const struct axp20x_info axp313a_info = {
+	.startup_time = NULL,
+	.startup_mask = 0,
+	.shutdown_time = NULL,
+	.shutdown_mask = 0,
+};
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -193,7 +200,28 @@ static struct attribute *axp20x_attrs[] = {
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(axp20x);
+
+static umode_t axp20x_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	if (!axp20x_pek->info->startup_time)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group axp20x_group = {
+	.attrs = axp20x_attrs,
+	.is_visible = axp20x_attr_is_visible,
+};
+
+static const struct attribute_group *axp20x_groups[] = {
+	&axp20x_group,
+	NULL,
+};
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -395,7 +423,7 @@ static const struct platform_device_id axp_pek_id_match[] = {
 	},
 	{
 		.name = "axp313a-pek",
-		.driver_data = (kernel_ulong_t)&axp20x_info,
+		.driver_data = (kernel_ulong_t)&axp313a_info,
 	},
 	{ /* sentinel */ }
 };
-- 
2.43.0

