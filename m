Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699797;
	b=SgxlFdyVCV/vVeXP1+Wg5y6AZW8zsWJ3SMMZ4B+V17PqNzQYPz/U6GJbyNYdkC0BKS9A
	 HP8XCH660UcUoxIaDNgVOC2DwShXZuRriczx1umX6tMWlIg+Jmnea+j6YOb8qQS3wndaT
	 IDDvXORyjl4rS2uKxgWsAjstiNzejX0hySOuyF4GsGFGRzhMe+ogombuu7N+Jfr8nFMZl
	 ZcVSs5M3+lDAmk28qoIkq3JzFctPldPW5NCHdp9LNFgAvIO6Dj024l9GNC1cW77o4lp9p
	 VkjtI+byYae/99rubZ4HGnZJ/xzl6Vb7zDOSdcpuq24lsIHo8yck+P222F2bjF1aG9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699797;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=xVNpb06UOPm4O6rCxYchGRZ9puWSXcSZFih9EFYGu4c=;
	b=WGHe9cygGZd3kpTNum7Heuj18NRbtgJFLZ2eOVgCzGDsuM9lIh+KLXUHjzRfxMg0YzUp
	 nt0T5pyPg06c/GtcLFVaEeRYBLTX3L75cL0WZbmQ03vCHGYR1B4szV6chYR4KwLodxijn
	 cPyMfbPOtKOZqDEEzr3G/RRTzuURuYDAIMCJXFFnW5zao1dwekHeUkDA0SIZB9wyQh8KP
	 +qGBmv5LY385aabpFq6lnIbB3F/oBgGwtRZNDqu/idKUH3IKL9kY9TUBqmIenCTYTLaRY
	 e+7TaYCP8RpMEGQ85BMbk644Zn/NVZPgSGwfaRRsBy181h2AkcsiCOfheVpfEVLJmUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=lxboxjGy;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDD606A323;
	Sat, 14 Nov 2026 23:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48CDD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=lxboxjGy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xVNpb06UOPm4O6rCxYchGRZ9puWSXcSZFih9EFYGu4c=; b=lxboxjGywmK5hVGgRlt2ERWdI4
	BfU/WyEV4r/mYRSiXjM8RceCZj9RfQDEbeUu7bOhtWqyZMqWgsr3O64YuT+NPwJhOPGRk4MSt4oZd
	sOt4GkiSZgLJQRVhnBYjbjB74+qmiDrQsC0ZAnEnOlS45oQfZe0+BR0eCpAsKsGsrFJorvSdEWGwN
	0QhdAFjxTSyjKLZv1UrMBwMKMAvZ5KO7aPa4NuzVmYy7uG7ineKIE/xZ8ttl4JRFCztqY+xHsEYpR
	imA+qf10RkUYmei6+rfragjz0id+Sh2QT9D1U75Q7+z7uyelJTupwgxHd8kX0blVoPlayszo+VmQZ
	36t71MoQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSNOq-00FuGG-2H;
	Sat, 14 Nov 2026 23:43:13 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Sun, 15 Nov 2026 07:42:41 +0800
Message-ID: <20261114234242.177387-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114234242.177387-1-emfox@debian.org>
References: <20261114234242.177387-1-emfox@debian.org>
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
X-Debian-User: emfox

System sleep takes the port down and builds it up again rather than
keeping the HID device across it: the controller forgets the streaming
mode user space asked it for, and hidraw offers no way to tell user
space to ask again. The device goes away and comes back, so the daemon
watching it restarts and repeats the request.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index cd3004208..6eb0dddcd 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -138,6 +138,40 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	pci_clear_master(pci);
 }
 
+/*
+ * The controller forgets the streaming mode, so the port is torn down and
+ * rebuilt: the HID device comes back and the daemon restarts with it.
+ */
+static int thc_ipts_suspend(struct device *dev)
+{
+	struct thc_ipts *idev = dev_get_drvdata(dev);
+
+	if (!idev)
+		return -ENODEV;
+
+	thc_ipts_port_stop(idev);
+
+	return 0;
+}
+
+static int thc_ipts_resume(struct device *dev)
+{
+	struct thc_ipts *idev = dev_get_drvdata(dev);
+	int ret;
+
+	if (!idev)
+		return -ENODEV;
+
+	ret = thc_ipts_port_start(idev);
+	if (ret)
+		thc_ipts_port_stop(idev);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(thc_ipts_pm_ops, thc_ipts_suspend,
+				thc_ipts_resume);
+
 static void thc_ipts_shutdown(struct pci_dev *pci)
 {
 	struct thc_ipts *idev = pci_get_drvdata(pci);
@@ -152,6 +186,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
