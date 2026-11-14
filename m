Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676107;
	b=2/Gb/Imo6tUgTCVrQ04cRpSfWDikF33G6PA+DFe15WtIZVOa/N0dL0sE0zf8jGw+hxww
	 3qyv4SCmbr//7aEonDAqn48iDNVxD3tATjuvcTllxsStHrSx0vv5YhI+3I4tz7gcV2YER
	 lulDpSvFIJN0vq4GKnDWP5cKWoajQX932JpGZ1AdcDWK59tLiMGQ/bIVGaoEBxOB7CYq2
	 1HXgo6UUfqNzwdv5T0aqgn6HYYcVKmaYFw29PQvWuYsqrl+jChVLvaRG40rAL/VdNpuwm
	 i0sJlCF0yVLIES10KgSWEmdFTGlJDA3ynKSH/vE6fjxsGlmgmIUhRrTOvnDKSZcfrgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676107;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=gmYCZYEdBpa5vd7c2LfBiShLpMO3DopZbtElZG5oaKc=;
	b=Lg8s8F1o1fsnngOJqi6GzgJw3SwOv5AfuaFRsLlHDuF3JIQyRHMnt75QIAUFt7QJ1Mk1
	 o/vExt+Bxl0ZVCej8AOL1YXpVMKZUE6NsovafgwI9wCajO4wmJodvU2ghuc/VNuz/8c+e
	 hzmEiMtY+Yju6lOAZ0DGR1xtGrhlBuhf6g0HHHgzSZ08QW5KDvf9Mb7306L4pcl5Z+RRL
	 Sc+giZY25r2glgrpGbhEEffgmLlCQLYIrMQN1jejVejWMo+Y/mhZjEneVyqa4k/i7fFGx
	 dgqVTjiNZ/wIOFUBX9IDO+asVfgh60ADWVGHyyYt3SCJQuir9Iz+z1lm1gYusrleGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SlrvHnv0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B3606A334;
	Sat, 14 Nov 2026 17:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C64B3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SlrvHnv0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gmYCZYEdBpa5vd7c2LfBiShLpMO3DopZbtElZG5oaKc=; b=SlrvHnv0qnC9til77umPsJFg3E
	xCQsLZkkipNw0FEOa8lPFCHLIXXQA5uFfwRuGvQLDHHLxFQMcIlA4EkaKhVcphR33GWnrCIQCzVQg
	3xMHeVojAZJimA6uL10SCQEQ4lF3QxAk8Mrdj3H5KW/CUmbyg6AcDAn6qJbsgXoBWd6dfJDNpHWwG
	bkxKuhStZNZwxtXYVYMqJkeZbFS4URnmdpUzP4nip4UXVVtlSdY9R3XFepQo+SxMsrqVWwkcHnfOs
	KtAzeLHakl7XQN824c5Ehaq5PK6zvXt529ZpyDUCWIawT+cV1q6Bjqzshtk5ipVSD/aKFqdErKLoz
	snR8aziQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSHEj-00FgXK-3B;
	Sat, 14 Nov 2026 17:08:22 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Sun, 15 Nov 2026 01:07:39 +0800
Message-ID: <20261114170740.2068179-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114170740.2068179-1-emfox@debian.org>
References: <20261114170740.2068179-1-emfox@debian.org>
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
index e0d31a6..0df3ddd 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -137,6 +137,41 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
@@ -151,6 +186,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
