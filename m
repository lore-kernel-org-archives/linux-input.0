Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836812;
	b=GzvgPb82GIY+VnF3wFwUuDScmjAR/l6xXsfjt35Mcn7gK4C9ZUSGDe5sgDePYtzWRE2G
	 MJp4iqYKZCl+Wc49SlmbPbU1wbG7p5ryEZZqBqWPdx6OfooMNAm0+Egbgk3iiouh/YDcX
	 8yaFOi7cLzaE2Bxn7zYJibMCu4e1YbivgcsTvGe5L/2836ogblyecMKaAY+Aus2mpdZN6
	 HSqA9kst+295nkGdpg8tVxsjMaS/DduHzREbGmun0S8BVhrCmBSgvk4ka267IWj4W9P6a
	 E0+ApBTRZSNt/qPsBlUj4n+CoKuKyBeg2C7pe100twvBsgjs1t10HLpSFykfnrcCW4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=42LazHaklgZGJp9r+8SF35RVYI+ajpaCsB0EAr48X/k=;
	b=c5LMLXdch2uJREY40rqYQiIrO+ACpCT16Uy+7Fkto31CcnR2uu99AMCzVpHo3Thh2SSF
	 sPn1hOQejVeEoL8Ix0xLvgCvWXU4/aAzNHSDnJm9NUBj0U8X4fzzodx+j0LloTHNSLsOk
	 PBoS/Yrf7rgkBJZQeZiQVsgvLnp4p1JyWdZHyFSoP6UVYgQN3iMLJEb+wWONKK8Aj3S4M
	 pYwM03/NGoKFW3z7wcI0LyXVCla6joq3JI7HxuH1/mBNNDzmTLSli14sjBqMMHvSaXeeT
	 jAa85XF/X8z3FdF0fBriagoSutMPHm2lKFE24iUs5rxP6fh1ylAINPXRAG+HnFsOoLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kenhou.net;
	spf=none smtp.mailfrom=kenhou.net;
	dkim=pass header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KisUGxHM;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E963606A329
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 13:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E963606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kenhou.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kenhou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KisUGxHM
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-378915168c7so422827eec.3
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kenhou-net.20260707.gappssmtp.com; s=20260707; t=1794836810; x=1795441610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42LazHaklgZGJp9r+8SF35RVYI+ajpaCsB0EAr48X/k=;
        b=KisUGxHMK4N3wlyXEORKweunyutGMshOpAydfkYTDZzWwOxe5xjZrHpP0weLCJA6b3
         +awI9P+9Rjm7/Y71OtId0PtpqQr9sinUGD3zRLfHIPSFP6Z62wQFzKoRbKrQeu+cpAen
         DiIg4LtuIaTAghTr0xR8Ucjzc5Hu7n0Jg3d+CTB5ha0mimbbZ1Nuq8mikzgEXijiMZca
         EfweJZDEsn9Eu1iti//WaascW9bw9byad/S4vsfot0u45TETfBWki58sT+9a0nQwrjJG
         M1hG++ERoN9Z2OCYvXttvlpJQPVRHKQmP4G1+/uBXIQZVGjTXe0nUoNciUMSagmtHGwC
         EOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836810; x=1795441610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=42LazHaklgZGJp9r+8SF35RVYI+ajpaCsB0EAr48X/k=;
        b=rpZrMvWgqPHSTxctuyq+WyvljdqcOe6uzjAbcEX+jNOeJVCLuuFx5t7m2ecltAgiCj
         uLowLQGH0gZTd/xrBa+57ehoCodHIVFSXBQ3XBDAtzX8nxJdO43frR99guo60myaIRRt
         kZfTX9ft0LkiIpvTCmNtyQUAz9PTEjwIqlJ5N0fFujhPgRjUwI0Y1VjCcZuroPwEvDHU
         ZQCJNS7uLl3MIp2Sd/73yvzUJqQS94ynuiefKWyIPerdp0tPE7KnGaB5Of9KWVobSQ1m
         aEnnrMzrG877shbn3YdZDZjn8pYHpaAxw80g5VwtA2HEVPDZVRXIn4jkQ/ewMzhjPjDk
         plEw==
X-Forwarded-Encrypted: i=1; AL+hErE7/4rv9d55BDei6+ObYecSaBNX20KHmv7uDhBkxgxWMzvaMoiXvpTxJE41Uip36qWVg8e9XQwYRSR63A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1bMZ8MYwSO4/I5JuIQPvGUZ3S8DpLuZ7QtY8bkDJYMSi6lj26
	eSu9nI2tl4ucW7HLjoDZdlkzkX+zTZxyVhQMVDeZCTZSZ7RopBHHsaEjSdXQ9x6Mbrk=
X-Gm-Gg: AZFdTZfSOLbPohS2h8uqrEooLwoQNOq3jbWk1p0QV64qzPo9RlFQ0f3STmgx0Z6YgTP
	o8eb5g7/2//P0fZmg4iR+u/Pmt/D3pQBm4/+68GvTh7aojrfXiuzijMi7VejJLQwTe2HH1Q2EaG
	Atwlr0TzU90YSup8lTf5s/4ynMekepJ01PSs2vawUVpShIzgs++8CSzXrbwfzOY0gKHyqGFVnbt
	De3Qu+RJyIt9F7CXjhjhRBsZH7ApaAj4t22h//2ML++rcmVYutkR1OxeytlshmDQWs8J6Yq0VJT
	PtQe9C1dQwx7pQ/PtD+k8Icbm4SVuX5YBxjzE/g7jjUg6vfx8srNaWRv4bKu9IAxl5BSDs3VXtJ
	8+DjLSWACuhcbiztwbEDZWj2oRKzb59tRZS6i/ZJr3Z4to4DnrRN7yKMaqGB4gMTDJKi3py/+FZ
	rUCYk57Q4KibtqKsrKXXUsuivBd9pdzzvfWcrhOlbW/l8wBJULnUXyDR9ETvJCoPr1Un1xabeOF
	0vEF/yezusMS8PDWVq3m0AWMJ9JAglIRZAc2T4+unoMp2+CkroINcybSBV7MKE4ICKC2Xy29SA7
	DP4UfMIvPyv1MW2La17PApUVnYZIw4vu7btpHPqBkviN7sX3BHUG273/C8HSFLFddycceWSB18m
	K5w==
X-Received: by 2002:a05:693c:881a:20b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3796047ff23mr15531117eec.0.1794836810089;
        Mon, 16 Nov 2026 05:46:50 -0800 (PST)
Received: from kenhou-claw.tailf09bb7.ts.net ([2400:4051:e0c3:e700:d08c:ceab:2318:7238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm35595777eec.2.2026.11.16.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:46:49 -0800 (PST)
From: Kenhou Iijima <kenhou@kenhou.net>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenhou Iijima <kenhou@kenhou.net>
Subject: [PATCH v3] HID: hid-msi: Ignore unexpected 0x06 ACKs outside WRITE_PROFILE_DATA
Date: Mon, 16 Nov 2026 22:46:33 +0900
Message-ID: <20261116134633.5498-1-kenhou@kenhou.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114125059.17772-1-kenhou@kenhou.net>
References: <20261114125059.17772-1-kenhou@kenhou.net>
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

On the MSI Claw handhelds (e.g. 0db0:1901), some timeout-0 commands
answer with more than one generic 0x06 ACK: SYNC_TO_ROM (0x22) sends an
immediate ACK plus a flash commit ACK about 560 ms later, and
SWITCH_MODE (0x24) can answer with a second ACK about 15 ms after the
command (~8 ms after the first ACK). The first ACK is consumed by the
orphan_ack_pending path; the delayed ones fall through to the rest of
the CLAW_COMMAND_TYPE_ACK handler.

That handler only ignores an ACK when waiting_cmd is
CLAW_COMMAND_TYPE_NONE. If a delayed 0x06 arrives while a read command
is in flight, e.g. READ_GAMEPAD_MODE after an RGB update sequence, the
ACK completes send_cmd_complete early without invoking the read response
handler: the caller returns stale cached data and the real 0x27 reply
arriving moments later is discarded. Reproduced on firmware 2.30: a
READ_GAMEPAD_MODE that normally takes about 6 ms completed in 1.56 ms
and returned the cached gamepad mode. The same fall-through also makes
every expected second ACK print a "Got unexpected ACK from MCU"
dev_warn during normal operation.

Only WRITE_PROFILE_DATA (0x21) waits for a generic 0x06 ACK; reads wait
for their own ACK command types. Complete send_cmd_complete on an ACK
only while WRITE_PROFILE_DATA is pending, and downgrade the rest to a
dev_dbg including the command being waited on so they can still be
traced when needed.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Signed-off-by: Kenhou Iijima <kenhou@kenhou.net>
---
Changes in v3:
- Apologies for the noise in v1/v2: the "MCU re-sends the 0x06 ACK
  every ~2 s" claim was my own misdiagnosis. A local userspace LED
  daemon on my test machine had a bug that kept re-writing the LED
  sysfs every ~2 s, and each write's trailing SYNC_TO_ROM produced its
  normal ~560 ms flash-commit ACK. Timestamped captures of the config
  interface on firmware 2.30 with local userspace helpers stopped
  confirm the firmware only ever sends the two ACKs described above.
  Drop orphan_ack_work, claw_orphan_ack_drain(), the
  disable_work_sync()/enable_work() pairing and the .reset_resume hook
  accordingly: there is nothing left to drain.
- Keep the core fix: complete send_cmd_complete on a generic 0x06 ACK
  only while WRITE_PROFILE_DATA is pending, and demote the
  ignored-ACK log to dev_dbg with the command being waited on.

- Link to v2: https://lore.kernel.org/linux-input/20261114125059.17772-1-kenhou@kenhou.net/
- Link to v1: https://lore.kernel.org/linux-input/20261114101045.21986-1-kenhou@kenhou.net/
 drivers/hid/hid-msi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 23d731f700..0c30846ac8 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -531,8 +531,20 @@ static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *repor
 			break;
 		}
 
-		if (drvdata->waiting_cmd == CLAW_COMMAND_TYPE_NONE) {
-			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\n");
+		if (drvdata->waiting_cmd != CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA) {
+			/*
+			 * Only WRITE_PROFILE_DATA waits for a generic 0x06 ACK;
+			 * reads wait for their own ACK command type. SYNC_TO_ROM
+			 * answers twice (an immediate ACK and a flash commit ACK
+			 * ~560 ms later) and SWITCH_MODE can answer with a second
+			 * delayed ACK as well; the first is consumed above, so any
+			 * 0x06 arriving here is a leftover of an already finished
+			 * command. Ignore it instead of completing the pending
+			 * read early.
+			 */
+			dev_dbg(&drvdata->hdev->dev,
+				"Got unexpected ACK from MCU, ignoring (waiting CMD: %x)\n",
+				drvdata->waiting_cmd);
 			break;
 		}
 
-- 
2.56.0

