Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9797407CCE;
	Wed,  3 Jun 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472954; cv=none; b=dYaGJoXg2e1u7EiHu5EzGdCzsQhvyFAl9kVQOirq8oeDP8+/Ogks4tbae3DW3d06/5xWGMoCQXNb9xSVOT50bNfYAae8+WbAM5X2mo3o8NL0WGMcrwnF0iOolHbOoesqSY4XmCQn7LVDkyTrtczzZS/cpb8xFVXY8kRTyZDN+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472954; c=relaxed/simple;
	bh=KWXe2vF9V1APmXbFFz6I5j514qebnn1glaNjLXrPmbg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=T94TCTugvNvCKmv8BKbDxaJapmA/B5B6gEQ9T8ovanI0flNdbw07u/0Xku+A8vSZTvLPzPMLCRLtZReGE9izZWHxdWwaMAdvGepnjVjTO26FuyU9bw2vbvQZuLKyODFlG0CBZB0dcBaDRkfKStkpoQwe/FF0VTrxAXnRn7gbIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cUc9Bpu9; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cUc9Bpu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780472936; bh=zIlDMHtHHWhTVYe6Wejgqpv9T6ZF4SdANMdR8LSVKhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUc9Bpu90K9J4L1DmnEJEWtIVvhA8Jt6O4/ij2AZmjsXz2DPtjhkjFpondrpgpv3P
	 Z7lQ8id2zidrToA5gb9AWYgJwW0SE6DLJvVcM5NtXkdAnu0gKev7gE3/b339N1Mohx
	 fpJkz4ehE2gmd17BxR9y3LkzCtiRuvmC53gOLScE=
Received: from ASUS.localdomain ([113.65.236.26])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BDF9EE4C; Wed, 03 Jun 2026 15:47:31 +0800
X-QQ-mid: xmsmtpt1780472866tl2kf0f9l
Message-ID: <tencent_ACA5ECDD5E0E1F239149E0F961FE45A65205@qq.com>
X-QQ-XMAILINFO: OATpkVjS499ursIQNhNWM3ClG+HYUv1G0Tqm+vBghBAapLsFMv6Rj9IGKos2Ls
	 jYQDXgUpoX9cVXGXyPoOTBswC2ZBrOg/4U42j65xWoHQK2Fss/WO/tyyB8SJOXR4m8EL3j60OQoa
	 qd62cH4/89VNrgTjQfu+9Wj7Hf7TVRGhNq6tmtgZU3nCiCSYgzBlXbRulb4toFKVCaH+0vTGb6nr
	 b8d6cd2bYNAMllem/XdzTtVhhvW0nsUKMjiDoGaw+cTimYi5FMNqzbqBMvACGf+95pmtN1NXZTIA
	 RONbfIy8/v407UQw5TwVb/vlaWB9Fb1Wp+7AWPJL9iVCdF4zNOL9dwxE7bXfHzohxY1GGiEd13rq
	 Fehe9eDXgO43wlwl7EWeH21iXpT+qt5KBhix9O0AQbK3f9ZOQ5E3pGHD36T6TAOJzHWOBTkB3L56
	 MhCe9OKLKkHiccduwBaRVHKK0BhdRHk9BsxRE1nR/hfSWtuJHCs9S18viq01eeayjGmIgrHc+8ph
	 L+oZHWWtuS84a9dDkN8nj/hwRWec/RDXRBbBWZDmZxgqiN7I4NM+KM2sSFSSKhF557LRW0PYEO5d
	 x+kbI0VTlQTjWgXYEWwm3uE9UdITtvv6VzF8ZnQq/UHSSmg9m2HDGZS5FymvUQj8s9skMOXA+u0s
	 nO/vrVvDR29qdVckkZfzI9CX0DdVhP2n00R0iixZuZyAmBEOwx3g5CwFOGIt6jqRA0MZ1fjQ+NNT
	 G9To/xQps83qqrQO8EIcYOSozhOKo4D1zeKtgKu+SNXmiOzdD1vGeYo5isKagTKwwMkGxxc93JUP
	 YCn2i5JaMPaMfdPLLXxWv49rnYfUsyP8Kaz2SagnKHHFXagL+x2Ve/0Zfcm1MxMDiI7G1OnIfr3J
	 xx7PB9SHGIpTIAEZh7Xhj7xzOuDHoptHeEjDw3xJ3ExWFdaGVIEihuPNfJl1OAi0Q4wqPtLxF+dP
	 ZQf74deq5FJR2Ql+QFThyHyRy11Pp+qBgDd08d7AKHkzHxouEMdrgOp66XLMxv6aKRFJkbHf7Qgu
	 eoScKeCTBQmB4hDEQ/5dwOrTcNX1fHmYJ1ffb/yo8smtsNngJRYSzTHamXf46XXIuzn6KzsgMVMd
	 /Vupg9
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Steven Feng <steven@joint-cloud.com>
To: wens@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH v4 1/2] Input: axp20x-pek - add is_visible callback for sysfs attributes
Date: Wed,  3 Jun 2026 15:47:26 +0800
X-OQ-MSGID: <20260603074727.613319-2-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603074727.613319-1-steven@joint-cloud.com>
References: <CAGb2v64PLZn+VD9LdxOQxHC0FUJ=5fMrpwEyJEJHkZnUZkHRRw@mail.gmail.com>
 <20260603074727.613319-1-steven@joint-cloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an is_visible callback to control the visibility of sysfs attributes
based on hardware capabilities. This is needed to support PMICs that lack
the PEK_KEY register for configuring startup and shutdown timings.

Devices without startup_time configuration will have these attributes
hidden from sysfs, providing a cleaner interface than returning errors
when the attributes are accessed.

This prepares the driver for adding support for the AXP313A variant.

Signed-off-by: Steven Feng <steven@joint-cloud.com>
---
 drivers/input/misc/axp20x-pek.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d893de..c1a4e5ea1e00 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -193,7 +193,28 @@ static struct attribute *axp20x_attrs[] = {
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
-- 
2.43.0

