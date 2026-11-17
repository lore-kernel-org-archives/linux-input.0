Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900998;
	b=Pk2l+htVJVs46MoTvJyCAPNs2xRYUkUbr/92ruva2uAcLBIGqesL8nBhRJ/ry5fStRbs
	 5vDfj+K/MHR5525ekjjkOrK+Z/L6tDrFaFtco/AGKKhamRujKAU6D8NF+gH8M7326wcz8
	 jPRx3oYjirRbeO14U63oTbv8uCVWAWF5ufoDw9qQwnQMy/AA3mJU3doJffNVmti1PnYz7
	 ozXorhP6twSbT1AYfkTDXT4i1609SYnL74Vp3uFPCg1XEDjn7aTnCEh6tJjOoE69fb8hA
	 3t5dGcVgeMCln5+jwuMolmrNPoGiNg/TIvECwLY38seWc9s9gEzkQao70lQFcLGfucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900998;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=N3F1G4sSxiW6AuA6U9qttbH+67JtM1romB+T1Z5QTxc=;
	b=oyXFdoDfCHcEdlb0slMfaszS6BiPU/oj33B0xbKgjkmpIJp18A9MUNUVxQWMSbSOoW48
	 NygiUpc1Kkzj3ZPmOudhAzUVb8qhPACN2Xo28qpo3A13WzOWm7NIChFHTdshSnFuFqu4N
	 yHUGdQ4MskuWmV2wub0JIdv7LOwqd/48Alw5jwYUVTj4f8B8SL8ePL7RGBxXb7pB/TnVw
	 Bez3RAdJPhQ2h835xcF/YRDislbfAuGka7iILWvQtyrl4+uytdP4UIegMSH3Mf1RUBzjl
	 /0ug2RXHCgP381mDEhQywhlBBlNdEmCSWIEwOSJwrOnQiyq/fXSoVFPU8bZGeoCSwAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="cZ/zOtYz";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F3606A31C;
	Tue, 17 Nov 2026 07:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B37F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cZ/zOtYz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=N3F1G4sSxiW6AuA6U9qttbH+67JtM1romB+T1Z5QTxc=; b=cZ/zOtYzW4jQTLYs3bpMYWS1J/
	+DURjfT9o9OeCc7vKszb6AkgT8IUnJ+L6aAZepLy/xJDlizGX76BDsQKkZHy2Vkz2mK8a+wmz71TQ
	m5wQqrPY1gFT2Z39rl2z5V1EdZwGsbHqc5h5I3GcPt3TPqFfzpbn4Wqs+IkZYCsOtukwUdIX2+Wql
	vS2qOY5oYVQmzCimQkU6ohMPcFY1b2S5DaK8OYej4FR+WOYEwKKRqg16Jz9FY78Ai/u+r2nQ3n3q9
	GhhZqdi0Kasofj1LsPrvufMJWmxKUIIbRbOSrtpFy9YyVphaoUF+HNDwUxvOOkV1Eu4sIFf05xOjB
	eEsQDnHg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTDk0-000NPL-2j;
	Tue, 17 Nov 2026 07:36:33 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Tue, 17 Nov 2026 15:35:53 +0800
Message-ID: <20261117073554.11557-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117073554.11557-1-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
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

Coming back means a new HID device: the hidraw node and the input device
are destroyed on the way down, so anything holding them open sees them
disappear and reappear under a new minor.

Nothing here arms a wakeup source, so no path has to keep the device alive
across sleep: DEFINE_SIMPLE_DEV_PM_OPS() installs the same pair as freeze
and restore, and a controller that lost power in hibernation comes back
through the full bring-up.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 46934ac79..1426e52e8 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -134,6 +134,40 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
@@ -148,6 +182,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_sleep_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
