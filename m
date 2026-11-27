Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794750;
	b=qk+6cePkM+Amnv5NSq7H6uDtLGRQE/e/OowMnWmlGEmZj8TQzLe0MdglQxoCShMDddaf
	 Wjw5RqIu3x0Ur+V08ubwM4Lw06RgkEJIZaEsR5Ge+xvbwFw/Qt10to49VpNi35see0fE6
	 7xf3xdkhT8Ubgj3OfrrmEsFeAr2w1VXWDCbJDGmz0Izt265f/60a3+aB2oDwqm0DAZ8KM
	 /5zXaJrVul/dNQ+Z52OA4iM/uzuojNra3mV2mb9YAibjoaHe252bVZXmsm72xzlmy3GmG
	 y7z0J515PQ9bwK1LUkixSjHVroNQTLgnn2i1r46kB1kesscPDYFELD5Zzlo5RMnuYgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794750;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=Dz9uUFrCUqyEu8qtEIiu9yKioc167gLI84DIuR6Udlk=;
	b=ynwKhD7DgYwx9XR5yLWE813FB7xngEGEfkG2BZCPofwuT9Wo6dyG1D9iAKTUcYneQXbe
	 8BcsakxTgjKfEeQoYkACj1jK1sZ/FnZDcc2HAJFBj7n6SUob99VrOYoSJXqyWuwIDC6z7
	 GLkp7AwgTo4L/0Oe7hIN2uw/LyPXKioOha8AkydGUytIe10gtc8lUDZdnuwXojZ83xoS7
	 oYTXGUix/QDDPi+wGpQvuAGT8xfPUyEBDb2djpwjVZFjOcCpVTk0JIgthlPiM63m3NhSe
	 tOJFJfILCatHK9NW2ufzZrI0eZBc7ClA6Iz77F7fDDl2wgm4NMD0cBkw2Zl8rKNCOFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ClTOyGCt;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D76606A31E;
	Fri, 27 Nov 2026 15:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D76606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ClTOyGCt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Dz9uUFrCUqyEu8qtEIiu9yKioc167gLI84DIuR6Udlk=; b=ClTOyGCtff5KKTi8BUlgX5j2rG
	cTLg6AniiNoSFAEu6TQ6XNkwj+luv7+L3Hg9tA4Mlrnpe3zYN95N0Vt8mGkmAbD73cbAIhMgybdBA
	3lV2MrXZlu/SSJLDGiw84dJLv7v6SQiqPoJe9D9uU2XKhD9Z/tFrv85j2ZMi+xIR32JPUDBoJRe5r
	JSgP6gMthajEXhkdc0BCUIIODOhMddmEYcudmkBzfGfqP+Mp82b+GYtkxTOCBKTs4f9Q5VviGT0zk
	IeHhXOHRqJZZaCmOQ7IpaRqwQAENsqjDvJlKweRb2sfDH/1K+fHaZTfsjxb06b3o0GbshaQ+1X5j2
	7GCs5HWQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWyFN-008RsN-0K;
	Fri, 27 Nov 2026 15:52:25 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/6] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Fri, 27 Nov 2026 23:51:39 +0800
Message-ID: <4ca4ba15a574a87932de8b31e0b4924f40829099.1795794049.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
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
across sleep: the same pair serves freeze, thaw, poweroff and restore, and
a controller that lost power in hibernation comes back through the full
bring-up. The line is enabled again before the resume callbacks run, while
the port is still down, so resume_noirq masks it as soon as the
configuration space is back.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index d147ebca1..ae775c43c 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -152,6 +152,61 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
+/*
+ * The line is enabled again before the regular resume callbacks run, and the
+ * port is still down then: mask it as early as the configuration space is
+ * back, or a level left asserted by firmware burns the shared line down to a
+ * disabled interrupt.
+ */
+static int thc_ipts_resume_noirq(struct device *dev)
+{
+	struct thc_ipts *idev = dev_get_drvdata(dev);
+
+	thc_interrupt_enable(idev->thc, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops thc_ipts_pm_ops = {
+	.suspend	= thc_ipts_suspend,
+	.resume		= thc_ipts_resume,
+	.freeze		= thc_ipts_suspend,
+	.thaw		= thc_ipts_resume,
+	.poweroff	= thc_ipts_suspend,
+	.restore	= thc_ipts_resume,
+	.resume_noirq	= thc_ipts_resume_noirq,
+	.restore_noirq	= thc_ipts_resume_noirq,
+};
+
 static void thc_ipts_shutdown(struct pci_dev *pci)
 {
 	struct thc_ipts *idev = pci_get_drvdata(pci);
@@ -166,6 +221,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_sleep_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
