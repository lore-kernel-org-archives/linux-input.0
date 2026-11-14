Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794692473;
	b=nS2Jxmeltt8gvczQtQHDkr1GcMyKRr0QNeiVaWSYHqqu0cdPgYyj2sH0qYYIdA7Eby3x
	 3afur/Ww1p6zQHsEsl7rfUeZdHCfpY5WUz2x7Nq6sm+oHIx/upykS5YJHDkVXvq0uOmBA
	 K/EIDE+ZbkLvAozDyTkOFOML98P1u6IsYrxfipbG/G2Vo1B8dksZHpfNqlk33eSujaN14
	 ByvHSJThhZCPXl+dmtLWyIrwsHTdUGoq8QrJuQq3EM0EMOEB9QbH4AuIxvM/cEhogKuzU
	 v7RlkfpedSKuDrAPAbEFSvdmu2uKbrhA9n8wmj8BUSL9CO+LOQax2WRmO+J5ytju/Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692473;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=FGKvHxAMg/XQipNIMm6FiHIgKQQKiV77xmIrKBZJ1qQ=;
	b=tfFHvypGi9DkgJsXNLrGSEG4zmQ1QydmnIX7zW3zqYcl8aJCiYH6SnPx6ki75tfS3rl6
	 206E7Kys42y1HUoEWUg5MSbgyJHXblJsvPaV9c35Kj8v5AB+KPurUsaaeNDZXOjxKu7gm
	 yizqfMMAz9lGfIsAr/3RmADQmT156Nl8fsIQ2tjNpVEe7wJlY1/wpFVEs09WH0n063s77
	 FJp8+IBV8cvOnPoc9uKrzfLDCwdhJ+zdT4n/bmoV9v4SzF8s/XNCGzTWSysdos8S2WqrE
	 TQc5Q2Db71HNxl0BDDBi6LYQStujt9uzNSJvnBDuJHtSlt5SkD0YmEv/E0xKeXqUg2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hV87084V;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628A606A32D;
	Sat, 14 Nov 2026 21:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B628A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hV87084V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FGKvHxAMg/XQipNIMm6FiHIgKQQKiV77xmIrKBZJ1qQ=; b=hV87084VCw3Xx9Ix4kQ52cHemF
	fSGCK6nsavvVDLAoZPwJRDclyyd96bXOtLhW5nw/vLz3K9Ym43cgwmGKgCwhkmTLXXxkj7TYpYDiu
	q1bl6of2qwD8CzeiCvrGbZO0Qw6wS5dzfJDaNr8cIRx47UEgyb1XPTp60H7JNlzzjUDDpEQyXVU1B
	khEizYRNpxKcAskdGu+6tHqx7/JEimdZ19DfVgTPnoS77eFzABmq7Jwb5a+zTqifcckmBCZA3CDAF
	sAokPpbcJweQdsa/Z/Xbq1dIpYhUriFxTxjCz3aJUzbFY7mLsTMBHzpXM8/mHX/QLPQT/1vZ7DsGv
	+VXPXNpg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSLUi-00FqAS-05;
	Sat, 14 Nov 2026 21:41:08 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Sun, 15 Nov 2026 05:40:25 +0800
Message-ID: <20261114214026.2809740-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114214026.2809740-1-emfox@debian.org>
References: <20261114214026.2809740-1-emfox@debian.org>
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
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 8f8db21d..81a46149 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -142,6 +142,41 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	pci_clear_master(pci);
 }
 
+/*
+ * The controller forgets the streaming mode and hidraw cannot ask user space
+ * to repeat itself, so the port is taken down and rebuilt: the HID device
+ * comes back and the daemon restarts with it.
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
@@ -156,6 +191,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
