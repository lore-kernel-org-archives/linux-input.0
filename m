Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681597;
	b=lNwTy4sdPqir3J83D6wA21AULYNJ8yEJw5lPjGt3TEOzbfS3DCKacgXlusjA92WwP3dG
	 FOjT+lnwNHwNOFB6FxIiOOn8bZ0ZZbC0xeFENXo/UxEVQVty/zUvqClendX+3BzMEvnhE
	 q8Z4HUVGC1zqW6W/zrYCwIt25DSYJ7WTmg5uH5mvghe6IwVT75tuy5F/a/IyFgFiVfTGH
	 SbkBU9CcflGCEdmJiuqOyYjGluibWEzHt1ir0qnRdMpGjUy0zF5HzOZZAQP6vAx5YL51v
	 Y/qL50cWM1Wi3f9L9ljc7tPCu7+5wK2GOgh0cCl1RQkgllYFDL2P3RcnBRhDC/XdDlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681597;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=r4PooCwjtYlROQsPyNlmPUM8e3HkUe3IxkScLhfE4n4=;
	b=u+eRaTYLb/UFJ+slzGvB6rtUWqSxwKcFXMyfnR4UeIcvqzYpIXK8ftB7BfTlKRjNOOii
	 3truf6nXyEGPQjB8h5gDpi18sW17ymL8XqNACRaKgajqffUeLbHrfM2fdORtJrEJiY26A
	 ODlfopRNG8vTicuLikBn9WzYAxxBbiJCyQh9ZOb9mSuRKyTFP6rZ4+GtR8Ns9F6ROKLIn
	 JoIqPFw3q8NnKbtNGDclYJWrLlZpu7OCUKBdRZlkc/7ynxB+eKjwYjnhzKrD9KlGIARyJ
	 Y+FUt2MjuYkcG/N6jfKBuR0ZYe+lIGMNdU3Lt4s3DH8LEbX6FEAbb7d2vNQQvqAvLgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=aml5N3da;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E1606A329;
	Sat, 14 Nov 2026 18:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809E1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=aml5N3da
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=r4PooCwjtYlROQsPyNlmPUM8e3HkUe3IxkScLhfE4n4=; b=aml5N3daNuJ4vlB08RCXy4hGbo
	CO/17qWHK0F0TUUjqoJYUJKYkGupzZcHXvKw4wGjauNMWdTLNRcdFBWHP8NloJTH3dFyvHkdF4awa
	41h7ojxSkEPoGshDF2mv65iv6WrMO1ZJGLAZVVGZ/zCktCJUHOjq/zZ6/GNoHzajkZ5Z5rXZREYGX
	ZYIIITxxgub3szgAisX8ZXMGHvfnQwZeZ033G3gCsEc7awBGC68e2zUJFaXoj6xqrXUf307Z0Alr7
	DNT05r5Ow4itt8Q9bljanksIk8AZkPXJSV0vjZWC3BMcXTOA1NuD+qDZRbwFIegjJUauFQgcowJQI
	H6uuS2FA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSIfI-00FkAZ-1A;
	Sat, 14 Nov 2026 18:39:53 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Sun, 15 Nov 2026 02:36:23 +0800
Message-ID: <20261114183624.2379573-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114183624.2379573-1-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
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
index 8f8db21..81a4614 100644
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
