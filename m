Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024815;
	b=IuVEAIY7ZApr+3O1OENnx6sSMiQzBz1oMZeo65cCw13h722ZcQyW6FtTdo6M/2mdZFAC
	 NF06L4SrowMM3upsVoDdh2JXLH0PAt15+uWswD5zVbpXBq37tOMSTsVXKv/uI9XZcjn/O
	 bMpigXehFLvTY/pVPySk52FIMxKSuSqTSk/g89tpVx/IPkwdXzueQ8Ky54u9cEL2Mb2uN
	 50CGYF78IhvFOlUFMN3VWm36gvQ0jFFL1FthZH0thtQqdiNJsAMz6z77R2a65U2OKpOL8
	 kj+RfkYgQnjrrGeOm9L5mvUzwZbfudkEbmeRQ0SS+A+d1I84w9MmY/mBxrS/Wi9XZNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kqsneomx7oxt7G8JgkY/wgvljJcG1r2hAmJ3TT9dba8=;
	b=AHebjPpFXe9zeYfcpEwPIQLeFFYuDY0p4nz7Ji0IF5CWTcdW9FBlu2FNd2Znwnye7lnM
	 ZXef+f4/UWSc7M5XPC4ebG95IHZrFj8j6qVVOhU6Sw79dMha5i01v/TMS+Bh7+oI0gyth
	 xuCTReU5529JKhtDtyX67Y+gIh5bNyJY5ce9+eb2bZBC17/ClKGcFTpCIMpmkLHSls3nR
	 WeC0Xgj1X8r7oRxrVqpgc1TvUX5BDKU3OGXP1eg37yMrbRgKb39Pcxrf3ah2oVAEv4M8z
	 0UwWg1HACyn+61sruot2jJs6JWzwJ4anwhObXek1fCpkd41YR/qSQL4KuKSV7BhQB7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=fUBFZXQx;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08470606A33C
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08470606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=fUBFZXQx
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48affdf66f8so388390f8f.2
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793024813; x=1793629613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kqsneomx7oxt7G8JgkY/wgvljJcG1r2hAmJ3TT9dba8=;
        b=fUBFZXQx6lGyWMoSQ21EiEhm1q0JIJItErQC/zLQ6moUmkaaEHN/OTa7A9i2kOjyip
         5ytxXNBgVOaIJOwfHEB0CuJUgz6jAF7kLshRaDQUPag3q6Szv/ndtZhLsl+sEh3g9CKS
         RA4rjrjcfvUTLvxXgiRddWCkGTEn8NmGjmRAQun+pVBtvhsS8rFme7P/WfR28hU1pp9I
         K5JFy6RQnHPSS5hL8ZY0rasvsuKEhAK6uRmNubrlIjML+UOK56TEtVReZYnqSOtInPjR
         /md7WD7FoTNTTygRNH8I4tCsu+tgDsQvD6SqmaeTTxysvIivQcUKhUY1BDmidDvhgESn
         1lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024813; x=1793629613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kqsneomx7oxt7G8JgkY/wgvljJcG1r2hAmJ3TT9dba8=;
        b=m5nvrxPM/RzyYOlE6qqTMBT6aEn6Ii1bd6Z3cI7GzLK06vct1bTr0h9kd72JAswR3W
         VWaZZFGilAPldApOsbdObvU1w+NVBDFGBUECCOeKO0w9hYdScUM28HEhuya8Oiysnp2X
         S24pPOM4ZwOA3erO6aZEe+ymM1OcDMyc7neoeijNQEfhrVwh9XPCGN9KA1FYoDil9NBP
         R44QcFGooXHhBmHumrVtCikGr9wlBbHtdYJdJNlaOSVSyKtSzVIMs+XQy9/3wa2VAfLv
         pWXLq2Wce7ViHnTK190HoxdC3sum+RZEQVJaaiKmBxqZwQpBNgZ9DqFjtlHTyWXTT59+
         Wymw==
X-Forwarded-Encrypted: i=1; AKwUvBwkeaPgnuXK23IFF7pst/BrL+BETLU1/Y6ruKk7o74lbl8LuhnGs5zk+7os8Ou+mvnRpr7VcdrsFNJ2qQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIveAclOEyA4W8zkB1xAwnZmWJl1aVOFCo549XRS0zKryUbTj+i
	FR4TtKmah0bACo6Yk9Z3nShy4Q7vMfJlW1hctHxQYkfTH8aPzWrc4jRe/ye2SsdwduM=
X-Gm-Gg: AYBFou3mHFcjTJ8xVBDPEGX7lmOsb80duATqsWXW2cZk1BVgpEOUb8+xkLgvojHv5Le
	L95zOJ3LLMQPZEMtFXcxqvxDpdiRJUyijOx/BTZs07ZQd9N/y1KYclktqvexIUHqLN9H/tffQJv
	U2J6dJubqg8qx3f95Y5D/Jvi4dvgovxZQUfKDGeOEaelPjYgWsLQ0saT8ftE1WlaoeeVGvCH9QP
	96BCFQR/sXuq/O471r4t13MBkCNxx06nj1NaAvw1IZKD7pSRUKGSBz2pWUZUz7i4CosEbCA3fLL
	AMoO3Xm/YG7kBSKG3wS8K0QpC65iEqVSzk8fmjDg7mK/5W2d+a/E1YXf3EUTMDdxQO9iz6z9Elm
	zm28mxy88AQMzpH6Snijjne0m1ywc9umsrmZ//T+eB+4uxh3QebWjF9LrBNx3azmXZ5wyQhRuIf
	8ubEUUtk818BkADR/zYRIRu5fI6qDUut+RtUTknFlVcm0SLRb3w/fLUfLLvLi68zhRHg8E9OkTO
	kmrnJe/IK6hX5LoLqfNzFjFGlLsZOStUraDL1PuMBs1re/yVhOTHP4CpTkVEwNdpSieSkhexXVb
	DJHvn9em4oekxYiEWi+bWsKXfmP/gJxvSI4fDHeNCFTzjSgFXhxEWSnpRblxu9G93vBOh1wmyls
	nBCxSK1uSgxYD3J72s2M=
X-Received: by 2002:a05:6000:40c7:b0:48a:f5c5:d067 with SMTP id ffacd0b85a97d-48e3eb36376mr14822402f8f.2.1793024813472;
        Mon, 26 Oct 2026 07:26:53 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm16400703f8f.4.2026.10.26.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:26:52 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Input: synaptics - add LEN2072 to smbus_pnp_ids for ThinkPad P14s Gen 2i
Date: Mon, 26 Oct 2026 15:26:48 +0100
Message-ID: <20261026142648.2567233-4-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026142648.2567233-1-dmitry@kernelgen.org>
References: <20261026142648.2567233-1-dmitry@kernelgen.org>
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

The ThinkPad P14s Gen 2i (20VX) has a Synaptics TM3471-030 touchpad
(PNP ID LEN2072, firmware 3324237) that supports SMBus/RMI4, but it is
not in smbus_pnp_ids[], so psmouse drives it in legacy PS/2 mode. There
it is limited to two tracked contacts and shares the i8042 channel with
the TrackPoint.

With psmouse.synaptics_intertouch=1 the touchpad binds to rmi4 at SMBus
address 0x2c, reports four contacts, and the TrackPoint keeps working
through the RMI4 pass-through port. Suspend/resume (s2idle) works.

Add LEN2072 to the smbus_pnp_ids[] passlist.

Signed-off-by: Dmitry Mikushin <dmitry@kernelgen.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1ed9261bff2b..b007e642ea76 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -194,6 +194,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2058", /* E490 */
 	"LEN205b", /* T490 */
 	"LEN2068", /* T14 Gen 1 */
+	"LEN2072", /* P14s Gen 2i */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
-- 
2.56.0

