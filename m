Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534956;
	b=Tei2ACfpP8oQBsvZQIhcNVG7FzeFi8SN3kosg+9ftKqhswUJ5Cd5MFijtiHnkoUL+b4n
	 g5zxoThaJCu9rbt+cFh3QmJM7L8jhkDFpfvK//3l7aAH5mrnexg/w2Ao8xMwuxGClgw4w
	 rLHydcOelZQzWDBvRXWB56Ybkg5aODquSurNgSKuFv97LXsm0ZuOGq3b6h0KUH7jciHHY
	 V4bsUheCGUxRkZ394EhHbnK1P9eriW0Gm+GEXPKynywM7LHKGjnrlUcz10fYrtBUTzEqj
	 GEmEwDcrK9ZSBK7RzeHCpF1GkUDaCdm+s6sHQ/VlvA7N9A+S078raqWICTzdEzWd+ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534956;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=OPVnRqpTHebad2QkXGy3h5+QsenN8z5dT5kf8ubaV8k=;
	b=ZdfVrcdYYngkdrXX6iSjdu6hdyeyNAJl50WBB535KUdAwSTFGCrCKH4UYGaWQ1VbqOaj
	 8SH3588NFq1Jh0rBLuWklYGn/2jxxvJV0JRmOzpsjqt65lOLrdGxv21g2QMY51QAJpmMQ
	 /Rdj5CBVujUCNlEPPSsnbmxF6Pp6lG7V7zI+NI6IBWFZDQHnFwI4lkYQQgU/FjnLfCnHO
	 bM6FOvtR0hHEO7qkjS3wNV5SrgvbnR9qOCQDKspekxAA2gsq9IBolsTJGhfUEy7PPThhz
	 VBdC9FkmA5M6VTEORpmPP+fVFGyEp5ciyGK1sIO4b6tcq1FbFn6zbl/5vHbsaNs0hHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=I0avXFhw;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1B606A321;
	Fri, 13 Nov 2026 01:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D1B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=I0avXFhw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794534925;
	bh=OPVnRqpTHebad2QkXGy3h5+QsenN8z5dT5kf8ubaV8k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=I0avXFhwPlprgQRbmyMhrSQRARKj7Qk51780huf/b7+BQMpWSrYcWv1IE5Lnwdrab
	 RYWsnULM9zodC8wljLr43FmmDEMM4WUwxhOvEM1wdukgwI+NChZ4DCLA747Dz681Ud
	 WFGceSHWvOzgRCe6kH8uhaJ7KtdXjtEUJaqvH5ls=
X-QQ-mid: zesmtpgz4t1794534921t09f7b086
X-QQ-Originating-IP: BNbGlNhiX7t/CY6avIAYr07FoQmMU75+ALunTodvuL8=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 09:55:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16852835858368441093
EX-QQ-RecipientCnt: 8
From: Haowen Tu <tuhaowen@uniontech.com>
To: gupt21@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH v2] HID: mcp2221: Keep IIO initialization retries per device
Date: Fri, 13 Nov 2026 09:55:17 +0800
Message-ID: <E306BF64E970F03A+20261113015517.1434489-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com>
References: <4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N+lcjVkupHXi+3DdIL5WC8FFj2T5DJD5fczTGw/ZrgdWDzk3rhXU8WdE
	6tF/UWN3dhIf03O8iBnlfKEpFdb4NFg8LKCpLPcB/JlrB3XIDNgqD7o+MEhEKrqhUQVvlQt
	Kx4NGwiu36MLTLKrcDwLfdcHc3OPGfqNR2EJtl4K+MZhKz6SwsfCyQvPJwUY9byV8omgT/S
	a6A3dFduC0pkg6fQaGDOreNVHLwJnuT2doA8jG/9JMQU5F/lbrd8xZQWAU4xjzuG24yoJj9
	fkLLzrNbALaTYTi/skmDblAGaLHP5MjyhDByIUBMluWwNAJamf4UdER3MiDurlGFsQOfbQg
	ZfNCHJ3beXuL6cRq7IlfGjsT+D/oqVwN8ZmOgO/WLqfHgwPvgnKJnkeMXF9tJPJtpZ0c/kL
	LYbfPJD4hrASUs78EPnLIyKYf2wqWMU3utVbT4DL1X2TYh1u1tPD4E4qQILCT7Lg9fYL48b
	PWb4lfO4QYTcBHqdxbYtCto3hXb4upZ/uWRrRfv1CemCUdsAwMwwgs2YIihP7rwyG/Uplsb
	AjIHFBOvjAl83I0TaNouYdFHPyHJVyX29hq12ou2qLO5z6IQAHCaartStxrs7V6Ksa3GMi1
	ZY965DgYW38lNpji8Wl03aqaghrJF+WCgkksElVQtRLL7SQ2tpcArdoURYxBxB0yV7iKFuL
	h30gKJUzA1EpSWmrzRCvPk///mSMUTLHVyUxZ3MwTQD7tMrvzH4O39K+UapAeiIY7J0GrMI
	/J4U2iDV+j4BCfOckWDRj6ErwFqBR4u7yGqbSp4nDMhJQXEVvbZxzPzzUF4bvydd55/tRXy
	Mwgl1gFJF47a+xjfC726D713kkHOOBg4WJhWVlbTkBwCOXhd9YjSLUSUK+K27NgfGw1K2fz
	47oxY0yuvGXOenlIaFI0M/ALDSTmrPI5I/gzbNWJEpPX7j35aYvCt1ZGZmbepc2uRmuhxqv
	OLSDuNpmNuaMfKlPDbLV4bKeX9CRPTQBqLia2WmMe3fJQp5uBjXIhLSu/kJ/ttmhYYTYEz4
	kKo30xnpuFvchb5HPQn607KFOi6GCDqI/PbTj4nACVBnA3xDd2gp4Vq6Y7De3nUP8QmGnx9
	2tvs7VPJdftaKQ23MtOcSACsVmzRwGJLvCl6uMJwmYG
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

mcp_init_work() uses a static retry counter, so all MCP2221 devices share
the same retry budget. Initializing one device can exhaust the retries
available to another device, including a new instance after unplugging
and reconnecting the bridge.

When the counter reaches zero, the post-decrement also changes it to -1.
A subsequent instance that receives -EAGAIN will then keep rescheduling
its initialization work instead of stopping at the intended limit.
Different devices can also update the shared counter concurrently.

Store the retry budget in struct mcp2221 and initialize it before queuing
the IIO initialization work. Check for exhaustion before decrementing so
the counter stays at zero once the retry limit is reached.

Fixes: 960f9df7c620 ("HID: mcp2221: add ADC/DAC support via iio subsystem")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
Changes in v2:
- Correct the author's name and Signed-off-by to Haowen Tu.
- No code changes.

v1: https://lore.kernel.org/all/4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com/

 drivers/hid/hid-mcp2221.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 3f05d6e288f9..f8f4788ba935 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -136,6 +136,7 @@ struct mcp2221 {
 	u8 gpio_dir;
 	u8 mode[4];
 #if IS_REACHABLE(CONFIG_IIO)
+	unsigned int iio_init_retries;
 	struct iio_chan_spec iio_channels[3];
 	u16 adc_values[3];
 	u8 adc_scale;
@@ -1190,7 +1191,6 @@ static void mcp_init_work(struct work_struct *work)
 	struct iio_dev *indio_dev;
 	struct mcp2221 *mcp = container_of(work, struct mcp2221, init_work.work);
 	struct mcp2221_iio *data;
-	static int retries = 5;
 	int ret, num_channels;
 
 	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
@@ -1238,8 +1238,9 @@ static void mcp_init_work(struct work_struct *work)
 	mutex_unlock(&mcp->lock);
 	hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
 
-	if (!retries--)
+	if (!mcp->iio_init_retries)
 		return;
+	mcp->iio_init_retries--;
 
 	/* Device is not ready to read SRAM or FLASH data, try again */
 	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
@@ -1346,6 +1347,7 @@ static int mcp2221_probe(struct hid_device *hdev,
 #endif
 
 #if IS_REACHABLE(CONFIG_IIO)
+	mcp->iio_init_retries = 5;
 	INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
 	if (!gpio_mode_enforce)
 		schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
-- 
2.50.1

