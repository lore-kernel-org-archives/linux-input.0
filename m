Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147755;
	b=j1QAE5aeayY8SlGVApP6HlU1MjjxJRbrLI2bCQsgRer/WxeQasEx/t1S8GYzm6OZYlgE
	 4WMAAs1b2Rvh8YhAcYYAFDt/PjNRcpe8Bdpct6YRwdFTdtOyJsW8EsO4pLYpLNGsVCXpl
	 rwbGcNWFNp7QVL1Tx616BI317ZOW7IrFMubVdZEJ6Mj8MjAyKze5oYrW2eCLIbhVp31dK
	 cMAFggJPLcZzf/mSjbSYAC7Ws0dSUJHdTmz/D4wcmzhGWWNPg3bqEBI8ezj4dGDeKdx3O
	 MXjAkh16ZdFzlQOh/pSCZtBuBRFcl/ZignnYTrpoCboEQ/kEd5cIAKl3viDg76rk/NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147755;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=cag5nXIwM3E+6Pw08u6YEdxlW7mBvpMjszv78kEPRWs=;
	b=Ets7kG8+9NWMnEsIFWjXyZscLfLqmRB8RBvK693lyvDmcSmZqXZS0aIF/B43o+Fh6lsg
	 YIskaThenWa+s8qOJ3NGTzqRYWzV/7v5fXTFa79KcKlYmmV/+8//2RLLT9kaADKXwOp5W
	 rCfC/Q5zFlQlunAezfzGDJA91CyN8+Urj1479aF7YR7hB702vyULt8SZ8wYjWZNSsWAP1
	 fTzdg/mT7ace3RfqD4h1FCEuiRGoZHx8z8DRiFYF8RyvfAN9yM+G72ybEq8IbO8oofz6/
	 GuXjhYhvvv4wKuaapgqqZyVN7SL7osxn9GTVsJi2lvt3lZR+MIvx3V+VqXb1sz1uxWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oMkuALfG;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9B606A31A;
	Wed, 28 Oct 2026 00:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oMkuALfG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=cag5nXIwM3E+6Pw08u6YEdxlW7mBvpMjszv78kEPRWs=; b=oMkuALfGXj2DGZ83Vxhmntw3fN
	YdA1BTq6dkMElpqRvc2fS0D5m3hb5JIumXNTDnxWJ4sYyL7+/jxCNTI5prsW85sB5YHgWTIyJ9GLH
	K1Ihb2ZZDHuEuZg+qHTb5omyPbhTx0Vb4CmJ+ZAORrCMyOKO88P/RngfRyYYBWfy91Rv1TrBqFElB
	rQaUzAAHoCgKjsYWj7+24g8vI2haVaDSy6xUFayEoYEFXtxiA7BUqhiNEZA5klA3bgoD8L6oacPYV
	08xQfYIOoh3tAFBUFECjzZ2kjSjQgxkssS51hEuC6L4UFDiwDYLAa4lNyswp1efJhz2oXxuivvrVQ
	tngftWoQ==;
Received: from 186-249-144-144.shared.desktop.com.br ([186.249.144.144] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xLrdu-00CLTP-5q; Wed, 28 Oct 2026 01:35:50 +0100
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 27 Oct 2026 21:36:56 -0300
Subject: [PATCH] HID: playstation: ratelimit input CRC check failed
 messages
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-hid-playstation-ratelimit-input-crc-error-v1-1-68812542f898@igalia.com>
X-B4-Tracking: v=1; b=H4sIAKdD4WoC/x2NQQqDMBAAvyJ7dsHsQVu/UnoIyaYuaAybtbSIf
 2/ocWCYOaGyCleYuxOU31Jlzw1c30FYfH4xSmwMNNDoBppwkYhl9d9q3pqL6o1X2cRQcjkMgwZ
 k1V2RxnSbXHLhHglarygn+fxfj+d1/QAqktRBewAAAA==
X-Change-ID: 20261027-hid-playstation-ratelimit-input-crc-error-26f871f1c9d2
To: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: kernel-dev@igalia.com, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

The kernel log of a Steam Deck was mostly filled with CRC check errors
from what is apparently a bogus controller, with 8174 messages in <200
seconds, averaging ~43 messages/second:

    $ cat dmesg-pstore.202610250608-0 \
      | grep -c "input CRC's check failed"
    8174

    $ cat dmesg-pstore.202610250608-0 \
      | grep -m1 "input CRC's check failed"
    <3>[    8.715455] playstation 0005:054C:05C4.0006:
                      DualShock4 input CRC's check failed

    $ tac dmesg-pstore.202610250608-0 \
      | grep -m1 "input CRC's check failed"
    <3>[  196.187459] playstation 0005:054C:05C4.0006:
                      DualShock4 input CRC's check failed

    $ echo $((8174 / (196-8)))
    43

Let's ratelimit the input CRC check failed messages for the exceptional,
high-frequency error case, which doesn't impact the occasional, low-freq
error case (as ratelimiting does not trigger) or the non-error case.

CRC check failed messages for driver-initiated requests are kept as is.

Testing with a UHID driver to synthetically reproduce input CRC check
errors (generated by an LLM) shows that it reduces the duplicate lines
and still provides useful information (number of errors/same message).

For example, triggering such error every 25ms (40 times/second), prints
10 messages and silently counts another 187 in 5 seconds, ie, 197 / 5 =
39.4 times/second (aligned with the synthetic reproducer's rate):

    [    9.554184] playstation ...: Registered DualShock4 controller ...
    [   10.053936] playstation ...: DualShock4 input CRC's check failed
    [   10.078162] playstation ...: DualShock4 input CRC's check failed
    [   10.103447] playstation ...: DualShock4 input CRC's check failed
    [   10.128739] playstation ...: DualShock4 input CRC's check failed
    [   10.154016] playstation ...: DualShock4 input CRC's check failed
    [   10.179198] playstation ...: DualShock4 input CRC's check failed
    [   10.204474] playstation ...: DualShock4 input CRC's check failed
    [   10.229762] playstation ...: DualShock4 input CRC's check failed
    [   10.254904] playstation ...: DualShock4 input CRC's check failed
    [   10.280441] playstation ...: DualShock4 input CRC's check failed
    [   15.070695] dualshock4_parse_report: 187 callbacks suppressed
    ...

This reduces the space consumed in the kernel log during 5 seconds from
~200 lines to only 11 lines (5.5%).

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 drivers/hid/hid-playstation.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378cf777d33aab3cdb87302c6e48f406d2f..b053037a3f0b95b6986c7e53e787e005676ed565 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -824,6 +824,7 @@ static int ps_get_report(struct hid_device *hdev, u8 report_id, u8 *buf,
 		u32 report_crc = get_unaligned_le32(&buf[crc_offset]);
 
 		if (!ps_check_crc32(PS_FEATURE_CRC32_SEED, buf, crc_offset, report_crc)) {
+			/* hid_err_ratelimited() not used on driver-initiated requests */
 			hid_err(hdev, "CRC check failed for reportID=%d\n", report_id);
 			return -EILSEQ;
 		}
@@ -1459,7 +1460,7 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 		u32 report_crc = get_unaligned_le32(&data[size - 4]);
 
 		if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, report_crc)) {
-			hid_err(hdev, "DualSense input CRC's check failed\n");
+			hid_err_ratelimited(hdev, "DualSense input CRC's check failed\n");
 			return -EILSEQ;
 		}
 
@@ -2425,7 +2426,7 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 
 		/* Last 4 bytes of input report contains CRC. */
 		if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, report_crc)) {
-			hid_err(hdev, "DualShock4 input CRC's check failed\n");
+			hid_err_ratelimited(hdev, "DualShock4 input CRC's check failed\n");
 			return -EILSEQ;
 		}
 

---
base-commit: 83f32c773255720a661aa45d83e36278135f23f5
change-id: 20261027-hid-playstation-ratelimit-input-crc-error-26f871f1c9d2

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>

