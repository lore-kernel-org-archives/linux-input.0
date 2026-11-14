Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671221;
	b=nhaLc9XQ5tZtK4DwBR9wpQLm72h+Mi/HZWkCc8rLxbBEkxP88kJEbQqh7FGokbDumP6r
	 IdellkrCzY56JRBPxu06novjVuK2GFh7KD5zVd88cs58P1CSa8jEOp6kKhjHv9bxWrc2H
	 jFZd5Qe5CO1xtiQZLG072wlcW0MpBwbcAAPxGgLhxHEkNP19JloSPQUWscRDUWvw8GF6k
	 FSCkAkwha6sQWjHXox1fl4/mFAUYxuQ7zWaiDqpAxNCGS04AvUMokbfTuYjWjCEwIhjZu
	 ZUYAi7iXymX9XpXmdPQx+xy09WAdp52rY4vrx1G3rjHr/nAQg71EAFty4OUJFZZm3ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671221;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=s/VV++xCWY5eDV0ev2Fsm3YzBFHRBwpd4pvTuh+8mvk=;
	b=sN+ZAL+CZzbNDMNCLG+Odt/D4uWHuHOOOAm31OBrGo+4HOTEZWQTfKXhv+pDhPEAgr89
	 yjqX3Er+LD6M4sGVs33jBUjKDSD6EiCROcytJE5+7HwY3ClCZG07tICz4Qd8XlnYn5SYQ
	 3bxREXAIWkW+jn3CE97gS4WrLH+nEcmfHL67do3L3LDl44+V8pbEj+f4BifRA++HgiLzX
	 kxJwHNnni6Q9r6/2zM+BYwmJh5LX1iSLUIaNnasJr9+ct2u2nKub++DE6kth3TcTb3wBx
	 Y9X6gWOdcakuKRMNpHjMlOaqj0ydjjsPfQVwmVZkSghAqEw8jHRGdFg1WgSOElaBDWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=R7piubCJ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645D606A882;
	Sat, 14 Nov 2026 15:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E645D606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=R7piubCJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s/VV++xCWY5eDV0ev2Fsm3YzBFHRBwpd4pvTuh+8mvk=; b=R7piubCJjnN+d+p75x9DTXYKtt
	NpEK+6W2G0I1FojCxZ1jsONcP8y5NdHVndCuUqr2cRXuhuR87ILXOyg17hYfMNAE30UImlIIokIXc
	41xCUciWnOT/5Z89QAh1dJ76wtGlHxog2nxEF/P86p0IgzLYN0mYeiWYedXSGvmBNiJMMMRCEz6gk
	ES84LLT6fpc4DHZvzKL7bjLLFvqOUOtSflr/3hU+9MjkR+qbvIE1QTbqkoOitwuFME34YhMdDqatg
	bj1n9vYhRbcmEXgJExeFxjJKyvHxUMe8nq15jY64VuIKnrSI+C/rVH1160WcEZ23mCPlMF3b3AE5f
	H4x3+eYw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSFxw-00FdZj-16;
	Sat, 14 Nov 2026 15:46:56 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Sat, 14 Nov 2026 23:46:10 +0800
Message-ID: <20261114154611.1683519-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114154611.1683519-1-emfox@debian.org>
References: <20261114154611.1683519-1-emfox@debian.org>
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
index 5160ab5..06ba8ed 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -136,6 +136,41 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
@@ -150,6 +185,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
