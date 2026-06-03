Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155362620DE
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482233; cv=none; b=cXreiQ93F8evgUfJcuM3Xw/a7I4Di45KXBVXAmWojJQc6AvoQzgcRHqP7fhSBoeGE6x8SjDf9y19P3cxg0eiC7fwafcUWvej0ZBJNKqQ0mHMYP69nkhicD0DZnbsVzerA5qqHfhnO4mZeQrpDuRLeWmav646vUk0yehxz2tM6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482233; c=relaxed/simple;
	bh=1feMnzkRXhUUkOrkyLlDFE6L9v1tUPowyHkaQGN95C8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0N7iEUcCK6Nj3ETSjF4q5JSplgaOUBT5EQE79UbEwsdLAS8y9Uo8VEBsGd1pQbA6q2+uh2NWJYWM2TvqHBRNNhWbg9F5drR2CV9hHnkReUzRg/HHKG94zvrzYvgispzeNLkkN2K3lcRSCJrVKaOaOE7OwIfbwcGLU4gwkM1Tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U/lRHKr5; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U/lRHKr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780482221; bh=JH7A9gkbDF0Oelz09cdFiE2M7FYU0TUv/ChOgI3M80g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/lRHKr5szJzDD0EQElCMyhkTyUkOU6a2MY3lGeHHEFlUEXPAXLePymzihp6yFBkz
	 +xLGOUACc6bTkj64nP+mTWcWe3ip1ByPJRzgwQZ5F/xENmh39ocK8Mp6HE9Lwrcf4r
	 XjDmVNecc2f1zDXwTdaOr1Xtde6WjUuzvOTWQzjE=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5C23E0A6; Wed, 03 Jun 2026 18:23:02 +0800
X-QQ-mid: xmsmtpt1780482201tqo0n3x7w
Message-ID: <tencent_17E53DD3B55FFE080776D30AF404587FFF0A@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwQW0VNdGcbgcWQOlx/efna6GLiV03vEXV+Wcx75qcilA4XUbqrC
	 X5bWpDSAk/fbmG3cfdyKu9KoTD6nCtV9GmamI1Qub/zg5IJOECw+Gscq8jy0uBYiN2EeUyGbxRi6
	 zfGV9Lw5pm+ryx3Di059AOV7Cg/D8gdCzqT5FYxDzaloWuRrGHM16ZJgpSpPVE5HzT+eZ8jbGUOk
	 3GNsWvB77bNAKgRCpfXwX3yz6D3CEyCyjsIaJWWWIIxC3gBJmQfOEAAhJvFKi0OuPpPm5r1/T5AB
	 Mlj4NHVQ6XUMSzEG3vgFuX5EZoDIh1r5oMSubaTasunpFX0d2OjWoVpzDRpv5MgUj3SKg8a90wmG
	 u/Oc+Ct/g6bTpI3AuZ/lzWOIWPK/3h6SiupTIXUz5cpOjPVl0XYvPiwkUiRcpJJzCGtYx8OV/6Fd
	 3MHbCBt6Ajkyq+oASMOVkLMOBCtuuRcV+fpj1i+UgZG1f7pqEbZ0YzhzPjC/YHEG4tPT+qG53+RX
	 7mqZetl8hVd4BaAX1wR5ZUCqtBdoSazCmg5Idi3Et3BaQvbg58zS5rRwbYN6KBl+1G0HlX5aH7Sm
	 hWZlRJXjBFxI12g7Rfchtj7Qn50gNNzShhblSaePOI9LGCUzKoQ6kQyAvIFMvy/vlk9HzhxZq0Ll
	 IcGz1VFiREq0jBAGPJAs6yxc+debqyZvNoCPeS+8YV4JAuGkwTJmzUyUQs28ewEoFG1PkVSlUJzd
	 QZ7Mo4wP/yhNnFXVRgSiwZUUQVsTylxgNgXCCN2j1pF0vOW8dhzX7r2zl347OmDaP/rHt5rHM6Qf
	 2Q1SdFiyLKB7yULpInLDk2fc9v6QN2Eqr8trrXgGJ3eXQo6dtjsO7nVWzmoLvxnFGbZvahzIISt+
	 YOmnNV5F3i7KIPCNxIkP8Aq6fb+Iz2VB23Yk8VYIkvudJoZfwPG9IQZprbrz/5qOF8cueuNdse1p
	 EdJYVvYmejGbPPqpXwRBIBAJK58dFLUPpabedQzvEG1sTwsnZoSJCPsHsxezZ1sR0W01c2cNenMO
	 WtEbZk1ENNhaXenbWXj2AMg3TRUjPQbfVeoZ7vwsjAarG17PKbevJgvMiJi+3DasM4Ddc27qqp6O
	 HHszv2JqZCvxIdBoQzLz5v8Fruyr0o2T89WVHJvYGWx0gaeqQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] HID: i2c-hid-acpi: Move blacklist check to probe() before devm_kzalloc()
Date: Wed,  3 Jun 2026 10:22:37 +0000
X-OQ-MSGID: <20260603102239.26491-2-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603102239.26491-1-Yeking@Red54.com>
References: <20260601184747.843DB1F00893@smtp.kernel.org>
 <20260603102239.26491-1-Yeking@Red54.com>
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
v2: Merge declaration into assignment.

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index abd700a101f4..f65fb6396b69 100644
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
@@ -93,15 +90,19 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_hid_acpi *ihid_acpi;
 	u16 hid_descriptor_address;
 	int ret;
 
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
2.43.0

