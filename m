Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794980443;
	b=rL02Z/7msAocjeHZbiMzms6NDu7UkgsBSwURaxkyb30usop6s65CAfYm0TZNj3CjsQBP
	 07h54SYEGhEK1wN9VZURbmoOz4umI4rPErKYagEAXqGFmVnbxBMu4bjOJBOjDzyi6Am4O
	 zoU+WIAGRYpIh7mhIl9RzDQbi6R3dbf+agaqFyH+bmDDb7lsCXFbuYgerzfXNcn+yLiSD
	 mpqVndIOk0K2q2aWxRxeOPHCELfiVGH/aUm6ia6C0ty0VFJYahSc72GwE7w4K7NtiOpT2
	 DN7wH0nvK5MhiQvBJDmKwlbrJ6V5S4Xu1c+qTIID2T5iIxsbNAaODYEUDea/5UCWw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794980443;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=9STJWNeeDdNH7HRkMeUU+XkkvhWgVeLh1HaIo0zdzX4=;
	b=3d1yTJbPFKQD6O7J/VEXzxelNYNH8A6A+n6TnqgYrX0JE2p377pOlE0Cx5GOWUlnryZ+
	 IxCn5lQGGOiWE1B2Qb8Cot8+rWEv/YImP3+MtMxSajqDkxNEf1fly+s6KxYcbqYoRIeLE
	 hFAMSuNUqs7E3y9cJhWQXyhbxQy8GM9mJVvY6MfrFD/0Jm5P1um2hqNnAHYoNrkXUbkoi
	 NdbF5Qs8WpoWEnP2L4QN1rFQEKxw3pl16lozfVH+wTrCrs3D1fBmI1xdLE+JFfxXkcjIR
	 W0TI+Dg8xct2vdgHgV4ruK/vLDub2WMLXRtIFFvt6m8zQeptwBqKwm0e3cvcJrOGxKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hAb9HMzO;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06660606A325;
	Wed, 18 Nov 2026 05:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06660606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=hAb9HMzO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9STJWNeeDdNH7HRkMeUU+XkkvhWgVeLh1HaIo0zdzX4=; b=hAb9HMzOmehtDtotBvfoqeTklG
	XNKoy++tLtlDv9um5duM3UU/2CLs+q/dl3maM3POb2hbx1Mjit1IBdnyJ/2UUJAORmMixVvQhSm1c
	78nEXV+k3nt18nUZjTNolkOMejuV5YlyfPwBCePprXoJX0S8RO+SpycBfLS3Ub1cjU3wxZpUSXifP
	8FML30mPxsppWgzuBPo4k6XjjKIos3p499RVN1es8uneDNLEE5WSBcTy0TEc89NNQvhIOfZWYk5O0
	hCPP+6+w3hyxtMX716zzeaIFxwRcWIJxgUgC5uIDamcccMCZURznTy2Ve+SjTp9BoWm1pn5YJkuxB
	uBLfbIqQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYPO-0015Jn-0H;
	Wed, 18 Nov 2026 05:40:38 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Wed, 18 Nov 2026 13:40:03 +0800
Message-ID: <20261118054004.363766-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118054004.363766-1-emfox@debian.org>
References: <20261118054004.363766-1-emfox@debian.org>
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
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
index 5aa0ad6fb..b2d9be4ee 100644
--- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
+++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
@@ -143,6 +143,30 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
@@ -157,6 +181,7 @@ static struct pci_driver thc_ipts_driver = {
 	.probe		= thc_ipts_probe,
 	.remove		= thc_ipts_remove,
 	.shutdown	= thc_ipts_shutdown,
+	.driver.pm	= pm_sleep_ptr(&thc_ipts_pm_ops),
 	/* Bring-up waits for the controller, up to a few seconds. */
 	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
