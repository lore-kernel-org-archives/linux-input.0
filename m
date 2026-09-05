Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455CC36728B;
	Sat,  5 Sep 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615614; cv=none; b=CtQDhWX/LCmSaKBDU/8hpfbqbi0T0yrVjGSgr6PVENdvfyqLAbhAIr2xD/5SjlNA2/gn4zR8UR5v4R/mGngcok4KHErpkdhyA8gJuQ5+KSFewVo37+4CoSTmTMu3wSE1ruX+00wO/8x8W/K4CAnrSC6oYDKu9h5lvYwJWH8n7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615614; c=relaxed/simple;
	bh=dzMSce289sBcQsNbAlgTfgL4qC5KUrPJLhxKJPmszkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/L+bD1+tndPUUWhaFED964F7YUmzfsh5t+AmRU41xBIsvzeVv0pU+qIfX7mO8pYmq4TBVIB1TBHeAnKyzqYtNGKIwgveQTVt92+DU0XTBDlAUZtRyNzB+3JH5sKN8+dp2YDdLH8czKGYERhp8cTOozi1yGc4X6cn1joybRL3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h3NmT0sA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h3NmT0sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1H
	EsQrIxFsbUoKKYWg/rbKLI4aWux6gRbHTq3kA2FuQ=; b=h3NmT0sAgilxBE92Gl
	UofK4uaU2RazBT72rvLDkuwyt8UciSWowCIO2iy0EvDdZlj1uQfxK1Hcch3mzXmr
	AEm3OKLkrTMHpCLD6I9xLWXXq23Rk1DaFTkdNxMbftjXcOmy98+nnu2C8LYwap7p
	euqWiHfDNEjZZwkwA+hyd1Vxc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBHh0S2G5xqQH5nAw--.11091S2;
	Sat, 05 Sep 2026 21:40:07 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "hpp.iscas" <hppiscas@163.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>
Subject: [PATCH] Input: eeti_ts - publish the OF module alias
Date: Sat,  5 Sep 2026 21:40:04 +0800
Message-ID: <20260905134004.66336-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wBHh0S2G5xqQH5nAw--.11091S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw17JFWxJFyxWr17Gr4fuFg_yoWfArb_ua
	y8Zr97ZrWjyrZ8KwnYyw13Zr92kFyUX3s7Awn5tr4fXr1fWr4kZa97Cw1DZrW8GFW2yF15
	JwsxWryrCw429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3fH5UUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxhe1fmqcG7clFwAA3y

The EETI driver matches eeti,exc3000-i2c Device Tree clients, but only=0D
publishes the legacy eeti_ts I2C ID. The I2C core emits an OF modalias=0D
for a Device Tree client.=0D
=0D
Publish the existing OF match table within its CONFIG_OF guard.=0D
=0D
Fixes: e32d7f1b246c ("Input: eeti - add device tree matching table")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/input/touchscreen/eeti_ts.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscree=
n/eeti_ts.c=0D
index b12602b..b870a93 100644=0D
--- a/drivers/input/touchscreen/eeti_ts.c=0D
+++ b/drivers/input/touchscreen/eeti_ts.c=0D
@@ -276,6 +276,7 @@ static const struct of_device_id of_eeti_ts_match[] =3D=
 {=0D
 	{ .compatible =3D "eeti,exc3000-i2c", },=0D
 	{ }=0D
 };=0D
+MODULE_DEVICE_TABLE(of, of_eeti_ts_match);=0D
 #endif=0D
 =0D
 static struct i2c_driver eeti_ts_driver =3D {=0D

