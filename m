Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795970;
	b=h0Wgq55IdOmTweQ+HYCum8AGtdr4+Nh4PAjeU/hbJndEza7YCsHRdjgEHJBDhmNIksPn
	 vYwtQ6eVfmSaegJVCAAnP9jaIi0iAv6Ab5F+6sA6kWcoPaK+VnBK4vrTOLel1qjXXlTVh
	 lyWwGFvfQgJuNKYZIp0Y4V472shfUg+QBhKlI4yNICk6RXkUva2lSiI5uPgzl7nVXvowt
	 oiBV7lOfPt2mNA7PcstnMYzltdmGp/oeV5fO4NKU0dUGtPHlJcNlEMBARt9xWnqS8Jk1A
	 QU3vAyJ+KEux05sFApIXUoIpOF/GO+A1TemWj+8hqQUYqVrU+sRTf0ebBM9tuio7YqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795970;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=iMwI1VtTle8M9U1HzORWMowXiI+tJHvMIGehr7XKFPA=;
	b=DG9zzTfkMaPd92dd+rA9YMovqzjgqIMAaRa1k9HrNewP5S1Py6gQ+/XwHVtE2m2oEIh+
	 YCOKbgrgDLwxQGMfMybmr7+6Q4l8qrFfnDBLx3eGEbjThS5XHrExpVHHVVZ+VfA7arZUC
	 2al4bgYBHCamHhC5f+b0A3Dl4JvX50UkYsbRAaQ3eg7bricpojQQHbxixjYiVH38w0ovE
	 T1jbwIJIuZu6SP4eoGcm3Z3qttVcq5ZsL+32xiM0Nb8p5v/0siRCUZvkMI8NS8ySMd7Vt
	 g0IquqXSjhSInGblOu+k8GmgfAWiymiv307J8yP4GdxL9W9sCWkA0RTfmNpZaQpflbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=j+DMDLtr;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E2606A329;
	Mon, 16 Nov 2026 02:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 115E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=j+DMDLtr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794795900;
	bh=iMwI1VtTle8M9U1HzORWMowXiI+tJHvMIGehr7XKFPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j+DMDLtrzPISajByd2CEXW1vk5mRx4Z29d1DJ1sMT/bx5YCgKvYqYxj31JMmo1oii
	 kZcx87MCb+UFWodRVglWiFPX1543yMd3qJgtBiYCh+yR5de5kCd2mYmCdwk3HyTYr9
	 tZxQSIxyq4H0CUetJwpa6H/cPsJtCE+QKiAkBTtQ=
X-QQ-mid: zesmtpsz5t1794795885t8c81686d
X-QQ-Originating-IP: cFmbniOkH1g3yGyZqiLib/FZuxHl6JNGbIW4KR2ghyY=
Received: from PEC004119 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Nov 2026 10:24:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16673752541823333651
EX-QQ-RecipientCnt: 4
From: Haowen Tu <tuhaowen@uniontech.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haowen Tu <tuhaowen@uniontech.com>
Subject: [PATCH] Input: max77693-haptic - disable bias on failed open
Date: Mon, 16 Nov 2026 10:24:42 +0800
Message-ID: <98F5ACA9EADBEC89+20261116022442.3298673-1-tuhaowen@uniontech.com>
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
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MqYBrkL3Jva45cpPfqEbhpDyh5WMta+8lGtPKSu1X/fF2LlqC6DDpIpM
	vMkGrMXuTiP2XeAtOITd6eerIkKY8a+mKr8j7i8hy6ImKGbpB39PIHgz688VN3TRLDHgfg+
	BFRk+cjoa1ImLhzjDL4YKMutCyq+kSPgWiXjAOTjRf2ZzB36M+fV36tLDT4Z6QLQIbZTWLk
	0qVXH99cfHrid4aVi6NmpqrdOUVBJTT1yXGO6Qq2o9UFZ3Vxr7z6y7mYFzjTWt9SEw1frZt
	3WQOMew0zzkD9wK0PnkE+JGG2grfo4zMqR35l5FiMswBTBeMpE/CZjotwFtCCaTjA9vGnE2
	Tyz5v0pwZcvDpqn/1DF63ubpJmq2Ff4Wiqfw0Zd4tqkLIeOS94SDXhdyA+kO2mh8iMg59hA
	uvwrf3MLOCryEXPc0LNnGbRwVPrXbP9HSx1qjmbEUfc2yEwdmRHSSx7+DueVt+gB4OnYMiH
	jk6caQH2OBVWDVq4CRhwnsODelnGK4++7wZU0RvkKVe39kGFyNtZ8zBLx7d07dR+tfPSetv
	XUtdTn98PaFNv9odWP+vwxAqQV2oNKGzN4bep9pw5r6Ui+2+y7X6oZazPI/vzo9j61hsP6Q
	TkS2ZOi/Rbz5XmNhkcgnZWN+Is8IWkNQCbjEWvpCNbjM6XUvOKrdtjcdmKLzH/+1VVKJhcU
	xWVsE2T8nxJlzU7S5SgfJ00+K2nKh+kHo/yXtGJsMAhKFha3SV4UwgNemKijhn5ZKgssaDA
	VhPSyWlB9u+AeY/a+WQsOSKYfcRTSHl6LnWSCMPmCAzhO5+C1OW+IJwbhGmjHb0c+T3RTXT
	vMxcZFDzMIUmAj69ACvjxAeWcLRHkUtLGL+QcPlUkWiGzpTipYzFFMFxJBX9kXal1BdpvNU
	PR43EiT64pFeed6kNgtBprz0N9RGgnmmftM44kdG01LbrRRFHON3XgcnjEKH5Y81NKoZHG/
	w9WigALj+mZoNXKGPiuVpNaTCb6vW7fOTwYbFkUvbwwZ7sKQO/Ef/sjXjVB+wGQnaWAMZUX
	KTR7z/OYrniZiQdM0vdx2y4Y6V5+4=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

max77693_haptic_open() enables the MAX77843 bias before enabling the motor
regulator. If regulator_enable() fails, the function returns without
turning the bias off. The input core does not call the close callback
after a failed open, so its bias cleanup does not run either.

Disable the bias before returning the regulator error. The bias helper
already handles reporting register access errors and is a no-op for the
other supported chip variants.

Fixes: 56bbc99e6914 ("Input: max77693: Add support for Maxim 77843")
Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 drivers/input/misc/max77693-haptic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 96d6d4620eb4..2bf4581b6adc 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -278,6 +278,7 @@ static int max77693_haptic_open(struct input_dev *dev)
 	if (error) {
 		dev_err(haptic->dev,
 			"failed to enable regulator: %d\n", error);
+		max77843_haptic_bias(haptic, false);
 		return error;
 	}
 
-- 
2.50.1

