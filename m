Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499063;
	b=yCvLYjJzadBKGpJWcEEsmiE6Se1e6dGFPbQ9e626f1TzUhQQRe/QRa0qBv9cG68jHpyh
	 vEH7CryqGf1FfuzK6+8npl5i9jefS73yrXs0H55pdA/1QnyGPDotVm8DrzhLprNa7qd4a
	 9Z/nhPfPE7oWoAswM3GFGfIP/dDnQknmCEfX5teKJotLL8ww7PE9r+WFIBfsyMHUPjdCO
	 69qUSJvZgV6MAhin27mCKZumsV1YEEAzdukFYvRtn28oSSmI8YpeSb/GzDyGurGVpOvyH
	 kjBL3ZYpTcTAQt9gpYTYXNdDG5bBPWxDkOA8ChTReZnGCaiy/ngTXXGEpk9rC78CshA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499063;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=IWGZLJw2nEHrhWlpNeplAcvwtMTjObjJ+sOkKeJmTMk=;
	b=B6sZfxJASvlCHxZLNe85jF2vwoohqEiZgif2on9zcpQ5szpTqu623RAqaHah+hy5Qrp/
	 kzcoXxbNk1XC9VaRKOOhRciRIRzQuIj61UwIBIP3o5rbGnqfZCJNwD5luzGQqm46A+Hbm
	 SSzl1O3JJ0SXsCAWJDVx7HMdLtF5G8tcZDfPO/ILMFjMavmd4WK2ERMUpuo+nx9D+SkJ+
	 coygMmOCiQ7AByankTHskva0PJVcebw4dhiYm8YJEexAa1qkI07VpdqAC9rSgSybumxDX
	 W1lI+8ToSDZUpiKbAMDVwqivbliko6dZyn/Pq4DWcA4Dl7S/BEIwSXPwHOZjgcapYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=pFIIeVaK;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B4606A31E;
	Tue, 24 Nov 2026 05:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=pFIIeVaK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795499047;
	bh=IWGZLJw2nEHrhWlpNeplAcvwtMTjObjJ+sOkKeJmTMk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pFIIeVaKc8JUFxJkyM4IkrFAoqQqxkyV6Jh+s71zvmz+2kBLEHX7o7d7z912UKmVJ
	 kx0ybTaUGCFBSVybWskUevxoVF4CHHt9iZ3hHmSAeHTpDHsPgLiRfVMqMBzm6/Hdov
	 pllBucsziTheYg58EVcQOlD2d9roJsKjK6t0Q59Q=
X-QQ-mid: zesmtpgz4t1795499040t63d20f60
X-QQ-Originating-IP: QChkp0EFt+LbveBJTyYJYqYToPlQRO1O8RmzGAA61wc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Nov 2026 13:43:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17405222007755505708
From: Siqi Chen <chensiqi@uniontech.com>
To: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: adafruit-seesaw - check i2c_transfer() return value
Date: Tue, 24 Nov 2026 13:43:44 +0800
Message-Id: <20261124054344.1067234-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OBdIB5dfVSDZ4BWcBi788MB/c/e5UFjmFSeX+n1fcJldE/3CPpZNQe5+
	flB3cGROt/gvkmlWcnhQasTpu0KsYl9Bj6YNQ3hw73tzeE8UbUuo/zHe8UqFLk0dnk9sVPm
	7EJM1YQkeLqn7s1ldpca+h86R7+ra4CiaJj6TkkJ8+6uV79x7Z9sacm+EmazxZLRwZUfwse
	Vu3UmxNc+YcATURiTXkLSa3ljz/nvqtZ9U8EhtkGnlWlxt0CiaWonrVCxfhXtBaehTDsFZ7
	VoYOlqSuB90PRw7jG/gMr+jgOCeS9ADEwBGh0Pv7JyOMCGumpNh/lxZhZORIuz+jzITks0V
	HzSC71D+gnFK+63b84PJvLLuPod6vP4V0+T6l0k/GZWenNbFi2I0gC4UZqKx1irBftvwGSu
	ajTjLNSHLYLBWzl+SMohrQkLF3yBV+ou1PEo5zjrLmGUg+wbhet3S1HTtKarzjxmLYtGahd
	yATbJnpqmmBhi1XhmPgrzH7C6uMpcdiywcf/ZJQ5Q4/nlSz5CEVIzNDuaLHQtW9z8SyOEnG
	+RWytxaqCDBJgm2y4JCH3PWGJl1PQVG0XnIFQWJ4clrGKh4Sx4T0VXoy64NbQggFRZdk1oX
	Bk/FhNPZG5cnoGqkAd113E39he/LKoulmdDIg8hHRez/+5NKwJpgtU7jMYAjFa3MrAUVc0j
	SZi8D/QePyurkyK4d4tFyP8dt6BjWLVfpBD/37IpO6IKmy6fyhLVyOJP0Oi9drSFfoGZrDx
	lKMVSDgk+1QLekB1tNRZUV0odQLNVKLTT4cPZQeS+pC1eMVb6KHFNsKIqLyRYCeVIg6YMbb
	57RK7b8rTmdtysB3e78kT2bqiay8k7wtSt50LbTIPWVXMHO8Z74Mif0HY5MaZVsKBG7c5Tj
	bMGjgLpZOt4K2+vW/T3eLh8TlpVqJbcKEyfy7CTS7pLZUc8+VzAGMRqanLhJ/5Trrh3ZKze
	nk2+JO164iga7mZ1YwYwr8cQqifnSetPhbMq9OjP1w8+v7U1D2UzyHwU+Z0+y96RoskDx1f
	lfU8AJKULRUWILeDPu1vaScHNY0X7+u8mKP0Af1V5XNpOfKQEGvi3Lb5y6LskFoN4qW4Vqy
	zua8oMjv7RW2sM7dvKIvTU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

i2c_transfer() returns the number of messages transferred or a negative
error code. The seesaw register read helper only checks for negative
errors and therefore treats short transfers as successful.

If only the register-address message is transferred, callers consume
data that was not read from the device. This can result in bogus button
or axis events.

Require both messages to be transferred, preserve negative error codes,
and return -EIO for a short transfer.

Fixes: 52c4e5985a73 ("Input: driver for Adafruit Seesaw Gamepad")
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
OpenCode was used to identify the issue and draft the code and changelog.

Compile-tested with CONFIG_I2C=y and CONFIG_JOYSTICK_SEESAW=m using:

  make O=/tmp/opencode/linux-build-seesaw W=1 \
       drivers/input/joystick/adafruit-seesaw.o

No hardware or I2C fault-injection testing was performed.

 drivers/input/joystick/adafruit-seesaw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
index 897e14bb61f7..8374381dcc87 100644
--- a/drivers/input/joystick/adafruit-seesaw.c
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -107,6 +107,8 @@ static int seesaw_register_read(struct i2c_client *client, u16 reg, void *buf,
 			   ARRAY_SIZE(message_buf));
 	if (ret < 0)
 		return ret;
+	if (ret != ARRAY_SIZE(message_buf))
+		return -EIO;
 
 	return 0;
 }
-- 
2.20.1
