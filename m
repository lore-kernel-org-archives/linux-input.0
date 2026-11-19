Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079560;
	b=LeRkqPeqwhg/F/XYpDDYIRVpGtty2xhQlvOWJ3QOK6/ngp3jhve9Vv1pLTHA8+VA2WGT
	 Kx2v4njk/XXUozrKAmp3S6UZ2McVUv+z1MEfHnWOmw0BoLOQhVIuqktFyinpSahGiGojR
	 0MWHT/HFHpU+FNft4Xb9tzSb75LY3um9I7zNcTLkjSDwirat+W+UwNEyUSvz9wGOUaXzN
	 en1ni62xaWWZDBSmVphtWT29R/0fE9hBB0jVERmKJHNVhNihHk44ltrmkRV+7IY5nvn3P
	 EUGPgtUT5gOyNhR87GHyjAIxbD5rBA0s48SBBPPM7gIqcpHZBXDg8ivjN+5966KqD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079560;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=NkVoCIJD6FGZ7nGhKmcw5WQtaEeQ+YhmTNgMgznN7v0=;
	b=YvRq5Z+kupbI4zcHJ1SipBhXSvvaqnRavPGwXJ/c4Q6RPG+be/9MML8W2STOYztBFbtb
	 bM4Mlf8Rg9RpavYR35gkvhRjba0TZXuwx5ZnxJB3kgAFfP6d2vcFL1G2bMbxX6bzXlizV
	 s6eN6E2pRt78hMIUM9g/AeWF4Qru1OtmkgkXAD+ICJQrKIcUi0kD2VrI0ZsqwXOf55OPH
	 IbTDcMABxoqOCr2eEN17yvSG1U953lRZtGAW20jfpE74ZovCxXeN/gg1IdrCCLRDCDuO3
	 roPVbqj4ed9RcTknjjKgHn5vkQJnPzU2XU9nk4zo6Rov5IleFuM85o7Fcoy6lDJINcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Nie9yL9I;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E36606A320;
	Thu, 19 Nov 2026 09:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E36606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Nie9yL9I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NkVoCIJD6FGZ7nGhKmcw5WQtaEeQ+YhmTNgMgznN7v0=; b=Nie9yL9IgYtRAOJHZRdEn9x5pc
	5p+mqiKfEGwqSficY9WB9d+XyGAw1lVCoq1piwwgN1UPwCIb29wE3PQNsvdkQPvm/udn82wXWD4LD
	EFppQvJ2v6fq5evo1eOXrKw6NlUDuTcJ1jEPPZHW8HfpjW+Z7Q1UV3kFhE2NhOthVMhCCzfq5RY/W
	NOKHn1xg5b9S/wmwUH1TsHoZaVqgi7lYM5JyLWFKTO1wDWtBWkuYpTGEmOYAJFvS79csA9Y8JGC1K
	0Ty6tO8O7mojfqaxJM9H0rj+N0edt6pDnXNlZsqRAQSCrW8tvBwEsM3IdJdAmi8tZJA7ZHE+h7FbD
	cBiJ/wVg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTyC3-001yyH-2l;
	Thu, 19 Nov 2026 09:12:36 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Thu, 19 Nov 2026 17:11:51 +0800
Message-ID: <20261119091152.470384-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119091152.470384-1-emfox@debian.org>
References: <20261119091152.470384-1-emfox@debian.org>
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
mode user space asked it for, and hidraw offers no way to tell user space
to ask again. A new HID device is what comes back, so the hidraw node and
the input device are destroyed on the way down and reappear under a new
minor; a daemon holding them open sees that and repeats the request.

Nothing here arms a wakeup source, so the port does not have to stay alive
across sleep: DEFINE_SIMPLE_DEV_PM_OPS() installs the same pair for freeze
and restore, and a controller that lost power in hibernation comes back
through the full bring-up.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 5aa0ad6fb..4bf64e535 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -143,6 +143,38 @@ static void thc_ipts_remove(struct pci_dev *pci)
 	pci_clear_master(pci);
 }
 
+static int thc_ipts_suspend(struct device *dev)
+{
+	struct thc_ipts *idev = dev_get_drvdata(dev);
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
+	/*
+	 * A restore can bring the global enable back with it, as firmware
+	 * leaves it at probe. The line is shared and level triggered, and the
+	 * handler has nothing to mask it with until the engines are up, so
+	 * mask it here as probe does.
+	 */
+	thc_interrupt_enable(idev->thc, false);
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
@@ -157,6 +189,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_sleep_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
