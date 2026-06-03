Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF937D134;
	Wed,  3 Jun 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450815; cv=none; b=L0E5pScpzRxYkuY7ziEQrmmlShcTliD9gl+4lBw415UyzmkU8mtggLmvVjqeGytz3DAhUBuqapzBlEkXwthJBfgd2XYsDl0p30j3hFsn0bnBm/le/jMiM7Jb5X5YJJhdD9wryCH73mkKY81SixFDeAfllKmsYDIzoe0WK5aKO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450815; c=relaxed/simple;
	bh=sXKy15eU3M0kre+lkesPRVyJ0evJ6D1sd3c42P+JQI0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nALKnzjnP2mdypBCyeb0p7DP4IMTK3PwF7f5NMWxhJHrrRILzvkv5d+MIIReGUmuO0tB1Wj3vxjYLQiBKetx4qg+hpxz75r8pTEFdFE/p8MnQWrlViAA6Glx/RxI0hvGa/IUXjl75IpLMngcrcx5Hja9ibf6epnM6iwCG3Fs03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eyxanITq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eyxanITq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780450807; bh=k/8NAuC4RlpSg7vrQ5V8MdqJaj0IP3ndU/GuQ3XW+7o=;
	h=From:To:Cc:Subject:Date;
	b=eyxanITqJq27LEJMe2fGT421PUkBGWjKie4JCTXdFDl377o8K7Q3svYRrMxlI6/U/
	 Xv28YpwE3F+65EoAKpIkTqrt6+qk8v3RJ71DkmRCFqJ5ug6EEXE9vrc/SEG8C1agfZ
	 wm4U9AxXmXR2dL7h4uBO/iSbbztVH5h0xxPMCalg=
Received: from ASUS.localdomain ([113.65.236.26])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 9BA9E4F8; Wed, 03 Jun 2026 09:38:58 +0800
X-QQ-mid: xmsmtpt1780450738tysv48m0g
Message-ID: <tencent_48A497E0CA81323CFB6C7CB84428019A8707@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju5pOB3fRqKTOD9eBJdafXTrNUI0qjSFln63dXziTGNx15JslQgQ
	 4tlLOerH4MCRNdu6MEGopSDRWJzfh8MKzpHqUJY5iljSGqPP1xlxu6d3xu98NiPokmPbQVShSxUu
	 8Ko1+9h1ikrL8h+OyWAZRcXzABKj3PSFX2tjas9laPj0NMN4tubhD1xWGnPN6QSY0X+Nm4G93UIy
	 EiGKQ/NT+6Fcc5nX+6LZ9Pd+NRjc+QSgIJrgv4q8o6jmAWZaT2h/ETDCq/7XBwqMXCtkrQyZ9ON8
	 mqBEX4C3UyvxRWR3w/B7YHkb+yOxRPvklGY4KHO49py6QzwSouO1FsXhcl2RKQLqx23gKRV2FNEd
	 74hskD8aHRIDlc5ar1n0JDoeZbQO9cuRRM+4AjkEJI3eHbKWSwQb4vT3+rI8LK9Fd99isG2Skgbf
	 D+3F5N+PGfIF1TBukwxsN7+ScO5JR+cxYvpwDuR0rZD3drNcdlxBHXYBrCJsSUz1PnH91qVgyqxv
	 mJkhZtdjorDLcKzebf6xhBamQGsP3cPJf9YDVW6Hllg+mMXEGaHPkP5ypbnKAp9SV0jcM9s6232r
	 RUlXNGn6AOEt8Fo+Ep9jcN1gaGojKS453pBd7oeKugAX9sD2t9jFfVcS026JTjaUzXOzF72VUr5N
	 Ce89g3EnkBi5Xa4tRl+EIjHvv2dYuTzJf3yogmF7YMdyG9iNM5ehfiIyQ9VOEehVFwnubl/aJx82
	 6CUveth3iNeGYfDK322K1wv6sQoArVmx5IfZlV2PghoCWnbdfm0ymt20AXxoonkH6e9WtZBkqWSw
	 gLv1G38uaNVORqQ8CAvMqIxMf9VnlUIMnBPYGjkeZh/KHt7M+FxJv6da2mkXBzIhB0A32v8/qjfK
	 mTkzIHQAB6YTEeZ+9eiMHe0VkKFYHWagj43XFjSj0+Nb2HplNpaGMRMimkoVvUyXoZN3Pq581OJ4
	 d+irgPvVJOkdXkcEXJ8JDO1R0D8fgfxo+o/4lYz8JJMc58JVifFDIPMvA4RISUdMJZEOL7hcp+4K
	 ESqKLCiYbUXmRBgWWl8Cy1gQCzqb+0JuOIqJbbkt7zN76Bh0DZexTRHFpL2UYKLNSlzeElF/JZaa
	 edEa3RjYyak4yMAcra88y8oUuriIhs5KSdY9lyyq+1eURhh2A=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: steven <steven@joint-cloud.com>
To: dmitry.torokhov@gmail.com
Cc: wens@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	steven <steven@joint-cloud.com>
Subject: [PATCH] Input: axp20x-pek - add support for AXP313A variant
Date: Wed,  3 Jun 2026 09:38:54 +0800
X-OQ-MSGID: <20260603013854.554154-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
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

The sysfs attributes (startup/shutdown) will return -EOPNOTSUPP when
accessed on AXP313A devices.

Signed-off-by: steven <steven@joint-cloud.com>
---
Changes in v2:
- Fixed regmap out-of-bounds access issue reported by Sashiko AI
- Created dedicated axp313a_info with NULL time tables
- Added NULL pointer checks to prevent crashes
- AXP313A lacks PEK_KEY (0x36) per datasheet verification
- Power button still functional using hardware default timings

v1: https://lore.kernel.org/all/tencent_5F1FF80489E702360F352F889570656BF608@qq.com/
---
 drivers/input/misc/axp20x-pek.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index d4e2fc9a937f..de43eef0c0ea 100644
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
@@ -93,6 +100,9 @@ static ssize_t axp20x_show_attr(struct device *dev,
 	unsigned int val;
 	int ret, i;
 
+	if (!time)
+		return -EOPNOTSUPP;
+
 	ret = regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
 	if (ret != 0)
 		return ret;
@@ -137,6 +147,9 @@ static ssize_t axp20x_store_attr(struct device *dev,
 	unsigned int val, idx = 0;
 	unsigned int best_err = UINT_MAX;
 
+	if (!time)
+		return -EOPNOTSUPP;
+
 	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
@@ -395,7 +408,7 @@ static const struct platform_device_id axp_pek_id_match[] = {
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

