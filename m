Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652E3E00A9;
	Mon,  1 Jun 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335561; cv=none; b=VvMPHHYId9BRy6TQ8kpkspxJRdXOTCYMvWmm6ieV0AsMvrUE/a0UXf9iEAx0iOz9eS9VDpA6gy8NpPIeLQ/USA41bMKCl3k1mHoGsOKm8JBjgVHGEjQun1pR+AxOiwEF99G2mw6PSHOhYkoIFiRgvg+x1VbcLsCyOkur7D1t64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335561; c=relaxed/simple;
	bh=PdAep0U6WBgr5biLmnnkCWR65AktWxIJgp9VR4j5tVo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYY+igaksRUYzs94l5MwTZ79lH+iZBGT6Az0uP8NKAB2/lNfDKvDMtbY98VvF1jEyKvPn96VUew+CnoJ/nXxoFoxW7n9cXRjc/32vLTFmEVfy5C1/7eWiWgjuBBEPIm6Yvz9i3dLM+m6edW5uHS8BhqxOCc2jVHTcVDodoylwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b4sAef/w; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b4sAef/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780335556; bh=wMq9zm0FGGpcJNSYzLF/SFfgicxTzOfmSPC3g36RbqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4sAef/w4LnNfCYwywh6EFqkgqivaR2yv2I/+BWxortL9lTK/wqzFfr/FIdl5l8ex
	 6dP3bBrc5Mu4UdGdD6Jo7OVVZp2/dndFjClJRNoI1X9jgZoOec09kOH4aNZnpgdZOB
	 fYOUHCWo+fmy/VdZJIti3C6Dkvj3s5ZHKb4Tm3Vk=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 979A8A6F; Tue, 02 Jun 2026 01:37:57 +0800
X-QQ-mid: xmsmtpt1780335532tumwshosn
Message-ID: <tencent_5782E7FA76EC9FBAC023DAF61E3A6BA5BF07@qq.com>
X-QQ-XMAILINFO: OJQdL3LRJ5VtZsXTnMYQJeMU9bHMiMtGWi0hHHWYjgCchd1JAw+i2w9tUxEBwb
	 +WLue+Yv61l4zBuXLayb5cNlpGLFj3S1X2MORWohzAOIqxb0O2nH6e+9Se/HTLTcM50dcvRqGDuK
	 nyb0ChXW8gNiQ+9qu6tXyVSS+VhT+xvFWEr8+FnY+jczm8R3ahCWcFkDnmuJbeBhsm3tgFg3KkWI
	 E9fdyQHXAcNu1fwUPkp6mFP1/Y1zSy9v+rxnw++J0Mr5NKzRdK/cSS6ogCQZPCFV2aeaCGv/OEIO
	 giFGpM7whf6ofDGApTVqtX2PnzzUjGGUIc8z0dNwKJ6MXBfnA0MMBKqsbgSqI7a50Yrmm8G6O29P
	 36WvEnbAMtSKHtF6huuh3rUIhfsBf+hPg12hiMSMObilOD6zge2q/bQc1FDOOzz0VicrgHUNxd7Q
	 G+fNri3kbnI3yYD+Wg/BaTpOAtTTyMjXnnelsHy3aHnWZPZFv9I+0pAagqEVoGp0SQORBbcSEK4v
	 vT8A1gvx1ElDtadxsDNjY9SvcU1FBr2KZqPjiMwgCijjBjezbZ7evOaD1avKJkgl76t/uyfF9J1B
	 m42eKLRLOUuwl4/ghtc9O65iqEBJQvf9cUE/SmOP8fTGoqUP3Wq6CNmjQUOIH/gJX7QUHc+YRDoz
	 Y/VuWbOgjm0TsvvU7tQwXIq059ATQbZSaYjfw1VNAqjhQzHnx7ki1N1WR/tEtojKurcFo+uNIHIv
	 TIdfMcck33GgHNOrqlLjOUN99uNnuQ6Kaa4unor9XiGTif4llou8n/H3nZjaD3riE1zR62tt4i0r
	 xBBvvTlfq29jAHQgOdzt1QrCKeJG0roVxLx7vDjXPPbe+rYSYhbc+HmhiWuY7sCXpBbpfMk6A1Hw
	 LTt0G8A20cX0Vt5+67n+CDevtKTKrH047CRzj8NgcbLgjxudMeNUuuvhWgXYQ6/Y1pqdTnP6eqp0
	 i2eiv6RONCBN4y+TGALdYbi4RRKuPQCc0e8hatC2h11p/B3P919Jh6uu+uhC3wSjRGgP1Y/2vuCk
	 l4vUTf91Lb1ohO33d4jZXIfeMFV2C+M7NLI45zrycug0oRtp16hfD+G8KeX6CBHZCEy3Xebtmtsy
	 DTTWiuswxZqAuCrNrxcpXl46nncJD+QXF9RUdFiAY4k8EaucWWeMHXH0VKtA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 1/3] HID: i2c-hid-acpi: Move blacklist check to probe() before devm_kzalloc()
Date: Mon,  1 Jun 2026 17:37:20 +0000
X-OQ-MSGID: <20260601173722.38151-2-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601173722.38151-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601173722.38151-1-Yeking@Red54.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the check so the function can return early without wasting an
allocation. This is a pure refactoring, no functional change.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index abd700a101f4..acfe0fb9e99a 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -60,9 +60,6 @@ static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
 	union acpi_object *obj;
 	u16 hid_descriptor_address;
 
-	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
-		return -ENODEV;
-
 	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
 				      ACPI_TYPE_INTEGER);
 	if (!obj) {
@@ -93,15 +90,20 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct acpi_device *adev;
 	struct i2c_hid_acpi *ihid_acpi;
 	u16 hid_descriptor_address;
 	int ret;
 
+	adev = ACPI_COMPANION(dev);
+	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
+		return -ENODEV;
+
 	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
 	if (!ihid_acpi)
 		return -ENOMEM;
 
-	ihid_acpi->adev = ACPI_COMPANION(dev);
+	ihid_acpi->adev = adev;
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
 
-- 
2.54.0

