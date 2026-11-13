Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535029;
	b=eTuH2OL6dAurpyxDrZ4RMuJEgOAi3Rx9CMBiLBWdm1Om96qKFO8OVUMZ7YCBFZIS5Stv
	 VzuZiFB1NYFTUnA7HytzyvRmBwPGg0M29Vvlja4V/Ae+GQ7bsiW/YMy6EyFcUt0eqOHdt
	 U/oBnf76gNqGS8QlLqQrgYG+CNxh9pAkfPB89UYtHEimQPH91CKe/vvE/ig6q1H+uk42d
	 r5WaBb3T5G2PcwocpkkRGUYcVUg/rJyyqxipOW63CkyIPkxB3yVf0mH0jLM2UTR+WiorB
	 fGMbEzLgnHJRzsnG0zh86r1HPwhHiFP6Y00Bk5jWKUIxKFoNamZ+l+kPiHa3IsB129Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535029;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=P2rSFdeBefkG0QLlDX1VLlflCmYqSn5vGlcZaogrGcw=;
	b=tTKykVusoR3x9UJtI9m6Ew9NQ0MmHr4ZwD5Fi/Ha2GrDig7h4kotk0nvKrluidwk55Mo
	 J9jX+B6w7CTNz/ttHilAQI91qPK4c6Ln7oQaBWpbdSdyh8G5CflpCWkoLKuijjRzjpyPJ
	 8L3klAnkPo5xC2V9e2hmtSEYERLDWCQlinhwxe0/s3oiYJOkEB7FGQNftVsb+roTHNg7x
	 IBsOgpPau5PCorDFqeDsB4ElrL2zU5Akr580WKFzyuiBxjAdhsuqNsAUctLCJBx2afg+l
	 se/gCy2xKkeNbkz8+HYxhSVu6PJXYT9RkG6w/l7xgqpy6cZLA1JbikpriVSQiy82gPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=alDlOphe;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E23606A31C;
	Fri, 13 Nov 2026 01:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=alDlOphe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794535011;
	bh=P2rSFdeBefkG0QLlDX1VLlflCmYqSn5vGlcZaogrGcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=alDlOpheE8hUv+EOYxTlXbyUi5TplmLcrMOt/V3wwoBXHf2QodQvU0Ksy3XuoJn4M
	 Obkve/lQOvdymRKnFcFn9zp+b/OWDWNXHncn58nqbMBE8Aqo5Yy5utBvcWZrMJ8/Y6
	 fRA1ig66qRV8Cqi0848ViQbPKRE/F3SBsOLVFLIs=
X-QQ-mid: esmtpgz13t1794535007td4ef3061
X-QQ-Originating-IP: HBOPV/FUpPzU1qlk1cOuZV0M5JVK/q27eIwWJpFrfCI=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 09:56:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15081137483030176273
EX-QQ-RecipientCnt: 7
From: Haowen Tu <tuhaowen@uniontech.com>
To: gupt21@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH] HID: mcp2221: Lock GPIO request preparation
Date: Fri, 13 Nov 2026 09:56:43 +0800
Message-ID: <A2AB87D20090642D+20261113015643.1435503-1-tuhaowen@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nj/O81qLKo2g4OfDGjpwuOAiSveEA2pSM7QzgSPvL6Y4JRp3gaxBBuya
	bff1sLsEi0Op6YKZJVVqLSppBHPjgCTWk/5F5oBEHjtnhfs95Mw0FsUCabYsfyDoBCz7Sre
	0uZMGy2GIzPKOYvdJ0LJviENvn8Ke2WlRKMAhbuHEZ7iVDULHyJTI9Q+eBQR3OE6ONRY4kT
	AdMD2lEJIDjLf4jnej6/9ITSfq5jhQ+kFLpLtjyajR0QDig+ESz5v5qyNVH2GHp8qhKON5y
	KhUbx91gAVa5R2fkmgFeE/ChE4CxNj9K1y799YZxsL/TeSMWxkjZLRSIiO/SEVaLIiL91bq
	xLPo/z2g6Eyln/p0mjRd/jusM6BnORwUqSa5TdcUAvXd7CGPPlckFTCZsG0QxaxIzd6L7qc
	Xv5rPFvH9ONgn1t4k3JtNELgbtf6oZBNne5bESSV3YxbNH6lY0RtUuxRU/a3jO0QQQf2GI0
	NPWDF5Ic88DcdB7XnLgW5kS4YinS9CbOJHcTSfGMPEBV8VqMtYfqGZB5CFsN+6Io7xakRkC
	Y82sq6p91x6xNZ6UfHXbei9O80xiUsjDI/hH15n6q8kI36GG0rWsy9UsX/Owoph4KAYcIFv
	Jku/SGmE293mgf8BS8N5R5BoxuHoRdT7bdBhbgKqu9lTD+JKINsSP3Ssre66raMkd2Rv5Um
	avkSokUDgUEUDKZ2fqZNtBN+oag2FvudoAqthPBz5rfPcCwg5tbbUxLZ51yrCeVfhNgq2bg
	wtrXGyF619HxBrRfHbN2XduEsGvSN8Jrl/gMdIIsw0i0m9DGiiqa6pfKX5ZUKsLd3f10Fhq
	mP3Q3ABZYQQU/FK80Jr8nQbfYubi7IjKukxScw6rJ5ms3jTupddGdM+h/HTOECcFZXERDog
	C8E6e9DWxWkLO8LNUZMBLzKfiyQQMrgKzh3cgoG8NqVgAIdhgaZxXfdL6nGPZtGzJO7bBn5
	PCzwWcap8Y+/pwUpZtDo6YrvJSAoypyutt9X5JcNWDjmdnOLKPK8aCvjBLhz2Yo/H397RGo
	YQnyV/83ZeyyAMFR4WhzwxBTiInDvh3C5G6fD8F+4O5Qvgeqv4JDSylruOBy0ZbiyOHa5uK
	R+mkeGTzPOW
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

GPIO requests share txbuf and gp_idx with other GPIO operations and with
I2C/SMBus transfers. However, several GPIO paths modify these fields
before acquiring mcp->lock. A GPIO callback waiting for an ongoing
transfer can therefore overwrite its command buffer or change the index
used to interpret the response, despite the transfer holding the mutex.

Acquire the mutex before preparing GPIO get, set, direction and SRAM
requests, and hold it through the response wait. Also snapshot the GPIO
direction before releasing the mutex so another request cannot replace
the result before it is returned to the caller.

Fixes: 328de1c519c5 ("HID: mcp2221: add GPIO functionality support")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 drivers/hid/hid-mcp2221.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 3f05d6e288f9..408c38828cc9 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -643,10 +643,11 @@ static int mcp_gpio_read_sram(struct mcp2221 *mcp)
 {
 	int ret;
 
+	mutex_lock(&mcp->lock);
+
 	memset(mcp->txbuf, 0, 64);
 	mcp->txbuf[0] = MCP2221_GET_SRAM_SETTINGS;
 
-	mutex_lock(&mcp->lock);
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 64);
 	mutex_unlock(&mcp->lock);
 
@@ -682,6 +683,8 @@ static int mcp2221_check_gpio_pinfunc(struct mcp2221 *mcp)
 	if (!needgpiofix)
 		return 0;
 
+	mutex_lock(&mcp->lock);
+
 	/*
 	 * Set all bytes to 0, so Bit 7 is not set. The chip
 	 * only changes content of a register when bit 7 is set.
@@ -706,7 +709,6 @@ static int mcp2221_check_gpio_pinfunc(struct mcp2221 *mcp)
 		}
 	}
 
-	mutex_lock(&mcp->lock);
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 64);
 	mutex_unlock(&mcp->lock);
 
@@ -719,11 +721,12 @@ static int mcp_gpio_get(struct gpio_chip *gc,
 	int ret;
 	struct mcp2221 *mcp = gpiochip_get_data(gc);
 
+	mutex_lock(&mcp->lock);
+
 	mcp->txbuf[0] = MCP2221_GPIO_GET;
 
 	mcp->gp_idx = offsetof(struct mcp_get_gpio, gpio[offset]);
 
-	mutex_lock(&mcp->lock);
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
 	mutex_unlock(&mcp->lock);
 
@@ -735,6 +738,8 @@ static int mcp_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 	struct mcp2221 *mcp = gpiochip_get_data(gc);
 	int ret;
 
+	mutex_lock(&mcp->lock);
+
 	memset(mcp->txbuf, 0, 18);
 	mcp->txbuf[0] = MCP2221_GPIO_SET;
 
@@ -743,7 +748,6 @@ static int mcp_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 	mcp->txbuf[mcp->gp_idx - 1] = 1;
 	mcp->txbuf[mcp->gp_idx] = !!value;
 
-	mutex_lock(&mcp->lock);
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 18);
 	mutex_unlock(&mcp->lock);
 
@@ -801,19 +805,22 @@ static int mcp_gpio_get_direction(struct gpio_chip *gc,
 {
 	int ret;
 	struct mcp2221 *mcp = gpiochip_get_data(gc);
+	u8 direction;
+
+	mutex_lock(&mcp->lock);
 
 	mcp->txbuf[0] = MCP2221_GPIO_GET;
 
 	mcp->gp_idx = offsetof(struct mcp_get_gpio, gpio[offset]);
 
-	mutex_lock(&mcp->lock);
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
+	direction = mcp->gpio_dir;
 	mutex_unlock(&mcp->lock);
 
 	if (ret)
 		return ret;
 
-	if (mcp->gpio_dir == MCP2221_DIR_IN)
+	if (direction == MCP2221_DIR_IN)
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
-- 
2.50.1

