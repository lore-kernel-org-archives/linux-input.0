Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534064;
	b=d+BTMT1xNLR7DJ11AAp8Kri5sNH3NPUl9Tu5Bgv4tNJSJ3R743NHR3yq6BahdfEcLjyK
	 xqkJk5UORyqi7MQT3ajK5MMIdqaKEUDZfiFVkAGnqngLAq1HMlRidbm5d219uPnG8ETM4
	 yGufVpCGa2/5MHaqXReAyGbRpZ/isnAOHp1Nv0Ujc02Pwx2Xe1/+eFi92ZKz6j49tchQq
	 PFBJI3C6+WBy+5FtGjLci7h1uXaGIgdT//xKKohcU2/vlYYQjq1hMBwOFTqNpdJ/gXHNH
	 ww4+/OtW0ZWj5xyylGYcEjvzbpys7RmPu/6FH97sSjakYoHj03c9qromyxk6EqAljXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534064;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=/sxv1W5mYI9kgEdiDglDayCA4ww/8N3J4Do4OKuotNg=;
	b=UUoEGCUOAkdqnGvMzzn4zqIk1c42+7nLSyUo6BojebYS1kYS7TKN1o1ioYfhxhp9gWts
	 uRqcpfiqxuWCpS6/mJ84KIrOocdrQqnSrHtSmSqjCHa0Y8iRS/pFAsEs4FLIIcQfZVH5r
	 Z/vE36eaQuUxkWj3pOoHSdblW8tO1h7SzdO+BNwSzt89YdneAIFQ7lCIw2HYisluYSZY1
	 7bEwr6djHF3Q3FaRZhkMtv5Fv5z8q1xn8mAmyerNRuC6Oxwk43zFMeyX2nvn+P4k1hYIt
	 TnXwo0DOh23fp4yLlXpyZa+MKvOT9Rs6f12aBQYHNbzt4Pgan53bryP6zLMTMwHGSLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="X/swONvx";
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3917606A327;
	Fri, 13 Nov 2026 01:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3917606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=X/swONvx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794534044;
	bh=/sxv1W5mYI9kgEdiDglDayCA4ww/8N3J4Do4OKuotNg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=X/swONvxBtUIm/r5HhI1m2upMWxH93O+HmrDD+iSKGw/RHz5en3DyDeI33S00S7Hp
	 l2WFZ88rEdDzMWKHmx2a/ONzp/X20pr2DtyDF2P6jiGfZ0YqoS46pdp9HPHEITF86Q
	 jUS2XO8hDF287Ya1D9fgNwk71Vgcq+P7iZ6zWxKA=
X-QQ-mid: esmtpsz16t1794534040t9c73d950
X-QQ-Originating-IP: gVonNnDY+kkctlVKChjkM8VaTZWWhDIg9Q6Ja4WaeBg=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 09:40:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 125834309167969925
EX-QQ-RecipientCnt: 7
From: tuhaowen <tuhaowen@uniontech.com>
To: gupt21@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] HID: mcp2221: Keep IIO initialization retries per device
Date: Fri, 13 Nov 2026 09:40:36 +0800
Message-ID: <4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MAN6sKHDZ5xSD9tk7QxbYcR75IRqTHohPZ66XJ/LIHWx3WFSywMepV1F
	vcaAmdp8Iw5XmE27GZ37DxEYpBCzlp6WXw78pNVWFh/Q94IbDmYYMRKe98qHAae3xOLlqAE
	kYiLjd0vuRJQA8HwJOpssdpQCEyr4z7KTc0Kpf+WsRLf1GMGBJ+orAL0Vc1ArUIm5qD9sxi
	PISlZvcLWzktizp2U5NssH9+MlYcSDvqLANYctsOp/1GL5LGukfeeB5Ud/DgDOMLsUdAvg3
	YF7XM46jMQZgz6+sV6gUGQAbmqN/5mCxztaTreeNTODzYvKK8xIOsVHUq219ICUBNke5rt+
	C7WpGPJ8z19ognlPOiqTC7favJ8b4OeRpiCtdszT5OcspzsF7wZsNe9UfVSMb5ij98p6Ut/
	Zmc/dlT7U5s7gnmo2OISwoMO26AgsUE1JYaBCD+SFoLNCP0t9h4OuaRMth9wCBj5gV/v3Ni
	QxNoqR2YDsZsc+NrdgrSX3pA0jwVXemSKRWQkqywnn4Gyusd/VLNLKMu2wDTDaoFi7agDzw
	697Xm4Pqp4b68CcI+0AgdwTpUDlFVK5TJ3t42b2pPUaTXACBngM34EOVJ170RZsO2Mlewjv
	2nuyt6TAhVbSVMQP9McmND9A756YBh1fzNuEc+/x3b/GbMAo1MBhmgOEFL7ZX80H7Pjovep
	BJdMaBKbpHeN+2hc86vGFZdxAtmMM3xRoL09YOv6GVhcobehazy6Ckd9HNYbq8YGwldisSd
	YTjvEHHXHREpo3sBjmOAkxZTnuU3r8Vak/twGiaQKb6Y+JoOuEOKteoaBUSw9w1O/qEFGE5
	hWkioitSdzoZlN85qODiCnHWMxVTdjXLJKD3dDj6yeaGVcUldwdnVWhQtl1bPmfJpOGa/XJ
	nx5j3aFqH/9l8p8bstViH0QCDZWQql12yP6NTbMS/FXaxUgSfjzhzdM88A8HQgZB38ODKR/
	H6a+IG3IN9Y9NVb5JIFkHZyczF38v7FwGe8n5rgBA9rPq+bfSFXozvloRHFlLmEeeBgp07S
	/R13nJd83+E/k0BelK8NEpbXSLsajRFn3KhGuv/QIJ1mqFmGkO/57WGvLb0VA=
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
Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
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

