Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553069;
	b=wSfWZU+wa0PmYKMZc8PXPhM9tREFckZNpKzTbx1Vz3k94Gvi/Hd0XlU0RNUogASywFlZ
	 6GZOrtyMXG509E4EJTKk8mg6eD9cu30uH1ZLfB/mcztLMQqUBN+fKxSE5EsnqXnQJ/T49
	 Sv0wjhKLG1lqNO2YP9Dlg8iCbay/YAxYxoG7MsNjQ2hbk3+P7YJ7y4kYobAjfxdvtkOEa
	 JT73Na7aNusBiGDBhHc7+KbywEHOdTRt40vxzoKm0Ka+wx5mPi74z9ylPkSZBfE27jWIN
	 h/xtIXMLSS/B8nJEyb7PM22OoKW8eQP7F1hLnXvzk5myENYQmzG14x5z7EqGzV6d3jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553069;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=LqcDjoJpZYd3Z1siuLQrffCZ2eBZqKukhyBi4gD1u2U=;
	b=OYZ381iWjhOGLYDTmWE13E1I0t93AH8nugGnpa+8btElAIDkb5qYKj+m9hlMdFdX18bf
	 7ZAonwgVWLZF1fQcWU6f11Sd2vNIQEFQf/WNpIJIXZ9r9L00nrj2G/nJI9YLubJqYPQt6
	 GkpVgTnozmCY+e93RP/ZS6D17yX+RIdSQoPKkXLuPBA46+gjAqiHsDuJfDpO+/Q3nWuNP
	 7A2l+0Ukfm7wi9c5pvBQh1Tx0Vaikhqzhh2OTmxbz5o5CV7spQ/Ei3qaGS3652r2AtKQf
	 T/xTyne1aOORQiDhQUis6izcLuaNeppNSaZsLHMq8PszVNRlvqz9fwJIYGs5a8OxMcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=m+LB025J;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA12606A321;
	Fri, 13 Nov 2026 06:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=m+LB025J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794553051;
	bh=LqcDjoJpZYd3Z1siuLQrffCZ2eBZqKukhyBi4gD1u2U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=m+LB025JGdaSKwFFraY/SiA90prUTmMKtLCevddUz0a2HkM8pMQaC2Dw1HDLmaz6w
	 R3NXs7w0qSf1OSGRu0VcspHQq3teA67u4aixQupsbTNe+4S+kKenegRJvKa7cSaUKc
	 hOH0zf1zIcZn3QUVC+BYVecEOdvNospLTV2PzPhQ=
X-QQ-mid: esmtpgz16t1794553046t2f118e79
X-QQ-Originating-IP: wQ9qTzv5+oRDiWvSqKEsM2b3ogjsAG/eOGlRStq9y4w=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 14:57:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15401069445647339368
EX-QQ-RecipientCnt: 7
From: Haowen Tu <tuhaowen@uniontech.com>
To: gupt21@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH] HID: mcp2221: Use the direction field for high GPIO outputs
Date: Fri, 13 Nov 2026 14:57:23 +0800
Message-ID: <0122335B0140275C+20261113065723.1514843-1-tuhaowen@uniontech.com>
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
X-QQ-XMAILINFO: N3mvcAHX73MW1lnHX7MaOi6Iu0Nijpdo+ERygBWYDcKOSWpL1IP6PIhl
	GhuGiTMlgf48MwjL/67WemBDQb0RcH51buoWCudDTPgIpIMUWAwFI+8VXyjbWL2deS/bs/5
	YKlDH6BJJTMHU2cM8ON1ZIvOP4fTAuFxqKlVH8eNQTuH1SVVjhO/hdqzjGUgUpUVXkSrIAU
	dMLI73ws9Vy9rbh4NhxX+28Swx2oielIOL0xHt4OsPwKxqa22Ay+qYiv44SNjMazSCXJ9Fx
	GIMg1CMKwM1yCDjCI9ka+q+C6UW9278xODERxgPFYSFqc57+qH/mgwQABgLOciZDZUG9Fzc
	vwDxqjGeSHlTJLtd3rRni77Bjv71r6P7pjPQZVEdbTozEr4AdQ8ykkUhVSlP4K4NuSDKwmQ
	Qma6NZh1zOcyxQ+2E65lbzdw7Qubsrapyjl2Mt8MSVfp/QwvQKVaItioSJv/MHDccanXq9R
	TVImKq5KqbeADWPiJ/plTm3QI7KMZ3VQEOjgCGAI22aP+Fys1G6BnzDeqCBs2iCdSSc1C6M
	tDbcFKgg6Q622X/GyIxNPNQ4XV8rFKkagFO6bgI9rkOeweXG5D7pDGrxfAFbj+D2rA28Q5e
	HWgCdxCaM/IMkeVht95URWXvFTrT0b5evjR6ldEaTstBEh3WZOSnk2Z5FSwLyy5BeSsZoCx
	LZ0Y43TGbYzLT+GKNnS45vRBBQbnegoNB7U4srg82LeDlQnTKdNrBeVyzG7/1KVLHHst7tw
	wFcZdn9IquA4pZbGWkPtb385vTOW+PFyXwNGUNO17AcrSWZZiHFBWnrd+reBmFJSmtsalc0
	c8FXQWJFk4ymgeJ10iBChqaBlc4uj4HCdZXpYBhwNB8skTYIQ7VAX+2NZgL0Ln2OouosgLZ
	NMHPs73pm1bAD5px4faEr2wRjyXE4958micgqvg7+MJgxI5hAAIhz29yWg1Dzliv37WOBvq
	UQPVDtxgzb0bBAk/AK8Q9HL1KJjkifEYDeq/FbmLaP8Hp1pDul7ysA1SsYoLS7p79MwUmmT
	k6vbcyhZPhc/JRl5e1faWnzSmhqM8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The GPIO_GET response handler stores the pin value in mcp->status and the
pin direction in mcp->gpio_dir. Consequently,
mcp_send_data_req_status() returns either zero or one on a successful
GPIO_GET request.

mcp_gpio_get_direction() treats any nonzero return as an error and returns
it directly. For a high output this returns one, which means
GPIO_LINE_DIRECTION_IN, instead of checking the output direction reported
by the device.

Only return early for negative errors so both pin levels use gpio_dir to
determine the direction.

Fixes: ca6961d8a851 ("HID: mcp2221: fix get and get_direction for gpio")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 3f05d6e288f9..3358b7d0c5e4 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -810,7 +810,7 @@ static int mcp_gpio_get_direction(struct gpio_chip *gc,
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
 	mutex_unlock(&mcp->lock);
 
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (mcp->gpio_dir == MCP2221_DIR_IN)
-- 
2.50.1

