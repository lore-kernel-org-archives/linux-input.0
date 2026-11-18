Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985081;
	b=RjvAswoGjpvlatg3xA9BXyHGdnrOOs8ImdjYrEzaXsHSaXCN0nKu9pOnl5vC0sCzYwOk
	 cu8SKIkBYtZMJ3vRBqigSShertI1ITCVjhUc5WJvnXXyCFW+oCKZXtpeEk2YYgM6WMBri
	 sucD1vazyms35z9btFbcUT+iIqdMfhjzq8ZZIQ9hXjPs51ogUC2fZcc++2G9wV3RPLO2n
	 /0YiX1cXfLKBfWjtUulvQtLDhVZa46wKlHI0DJJSqDlDqvxhrpFhn3fhtY6cz1GXU42+m
	 o+Vwp+9aCVKdeRduOEoznLKEuXJ0Ux0ceTsp9WWUrDZzt3LxHU/chAJKH827IwCXypQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985081;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=9STJWNeeDdNH7HRkMeUU+XkkvhWgVeLh1HaIo0zdzX4=;
	b=3nUPbNN9IfDcijZlXGcSAp8hXpObQJmm74/4sNDg7XZtYK2lcsHjx6VMqoxSgdZtnlMA
	 QsjOB+ShRpwSIVj82U/a6QFgcl22Xiq1O7QcE0f5z1hOR5FgZ54AjjemnawmkytdTdmyD
	 ztRWWI5xffxbJ6i8l4Dve39Iid3noX8r3vheHOYDhUo3Ekqj8hGyjyNumtjLwHSvr5Ez8
	 sA+j+qkJT5aQLAokg+6Ig7JOlZRzDPYN/xMjcS2uyXL9d2StE8j1FIyTTTZvRzjsp3KOw
	 QsVQgCxeOj63XhxvoA+nKCJueUAc717FRBDDLlvC6l0lhe0MLSk2zWT0jC/UXOpV2lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tif79oUY;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C03606A325;
	Wed, 18 Nov 2026 06:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C03606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tif79oUY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9STJWNeeDdNH7HRkMeUU+XkkvhWgVeLh1HaIo0zdzX4=; b=tif79oUYG5Vq2l9GpsBikPzJOU
	0QitAHk/pgSwPobN3gigDVyFG1v2Wd1uN8X5zY1sdRpeIJzt3w5Y+pbx+6QklLg71rMmmCzgPlAGw
	9KfyAQ/evLCCotKwT2CckM4ii7R/cVc18rx9q2/7DWwvunr1lMLkpoB7MrKbEdQA/OnxucNtFr3mL
	Aae+L55c0xCLku1U6KqEYM/tibnLv3a1GxEwlr6NQPFmKfHAXwrIIv1kpBg58r4I9MEbeaoLVYPFB
	rA6NwAwODsYSxnxQqs0GuGe1G2iknCcnYsD3ad8j5HCM5jp2Vd7mj3EYpWApdGigyV5R05Z/bjJsB
	5Y6mPPkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTZcC-0017tS-23;
	Wed, 18 Nov 2026 06:57:57 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] HID: intel-thc-hid: intel-ipts: handle system sleep
Date: Wed, 18 Nov 2026 14:57:24 +0800
Message-ID: <20261118065725.673090-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118065725.673090-1-emfox@debian.org>
References: <20261118065725.673090-1-emfox@debian.org>
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
