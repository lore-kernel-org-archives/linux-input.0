Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007084;
	b=kVEt/GFKPRB7LAOiEcM58M99tNE4JIgg5kib31mZhzBgaAQu9K2pA22wrOR8Qmh3alWr
	 TikHQG+q3cnwjq8A3NP2jP2Xl23dmkLA82K811oJ4akierus2+NelvPLGgkUq6Xw7ROZq
	 oYP/eV3tn8lx/706xBjfD/iQbRdwHLRg01lcKZfqC0d2mSXN+4FoDvmjwazcngHNBl3M/
	 ssvc3xwXqkuM1mohq1qx44NOo0N/ZyLNzllkjDOWZR02SnM8KvRvneNTzAB6yQ83ci0Sy
	 Ff5ebTYOi9yD2PCntLknzqVSyUSJmKkQRdIFx8XE3nnwZ/mLVCcEW8umgKnoqrJBGiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W8Mga2ustW/C+r7h5ElKYQM659dh0dLRlTT/X6xp4Hk=;
	b=WtzgHtAyN33NBeEVrvNmvLP6/uZbc4ShYvRKNFa5TMSRo9YZeogzR9ZKssmgpAa8NfJM
	 UTPeF48M0LsDQqtWkHLDXjdJ57AqkM9ju5Vu6BN6Ogdwa/fDh5HLIGIC4hhbfAR7Kek0c
	 UslF/fpIsCiwMZhQiZEqc3eIj745OxQJaumlFgIdD6j3ZrG7DtwPrlLXnrULJAewxsFjo
	 fQhNbhHLf6K9UkRWkiUkDxmXc4pwYSEi7M57/uho4oZOPYx3teFzAD7kd41F08+0Cyrlr
	 spyM6BmfgIwzeJpKNrGbd0dvfTFD2q7L3zGf6xHKc6QOxJfA4rRsoLXe76+QBUzGRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=s8ELpLIg;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABF606A330
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 09:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55ABF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=s8ELpLIg
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcb1e5f9so420432f8f.2
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793007083; x=1793611883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8Mga2ustW/C+r7h5ElKYQM659dh0dLRlTT/X6xp4Hk=;
        b=s8ELpLIgRvmZKl4lDv563HGJYeGt9I2gDk5yb5Oha5jj+AfYxh26jXG37Q8sHeHuE8
         tXXwty8OKSgWati7lbBB6bKW1yYHWWQVS93IO67RnI9O/Dtj7iAK9Ll1pqqomtIF8nQq
         nircMpJ+YhbTSnpIIG5/oRjVCPsx8H6vVO3WWHHHh233TV/rQ9u5AEPAxD3NwxW0KRUw
         ZeDOLpgnNCZN2E3vaFEhiWnGY3cI678Fp4JLhEKTmpIRytTYOrHPm5VFY0QG9futefIa
         F/RG/pdJmueM/hghsX9FCpDec7X862q5LGXuc1o3wwPUxlz1HIqSDD2qrCgCSWdRjdge
         eJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007083; x=1793611883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8Mga2ustW/C+r7h5ElKYQM659dh0dLRlTT/X6xp4Hk=;
        b=2IMxeKakZMsaSBPoB+o1hluL/920jRak/I2J1UFjGJxrXPJyrLb5HOo82+gtoVXle/
         TH/G/esIe2uN169WLDymAMoCbajngQ2d27o9+HV2aHkXl0fhKYAF2t3zmyX6N8JKP8iF
         2OvNE+po1XH9ZetZwkOb7vYGEDGsVUZ74vrTbHb2+D1qRHURf/TYTDnZMZRnvRgGxTZp
         MSIJ6qfAcKK2ZcgRQ+jRh7JiNy6kH25/bvN8ZdWAHEr9I/liM8vvUNM2/1NK832dejZW
         4OEJIopdV2Itwd0TzoeWzd0CEZEMIOKJHXdTY1WtbvRD2k2QFEvExRSRFWLF1TUjJGST
         1Y7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxz1nDwuuNEqbFBB1w5TXEJPp/vKzMTL4/wreitsXs3R9DdOCVmYJBTxNk4DzdfpKM49YNKi4CVRbQrPA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOW11Ku0cvfYw9tsKPNklLaFokly3aGtE/l+22xfSQcnAYdtu9
	mrs4FfsiqCb6s/L6xoK8yzgWpt/DIn0qrrAgHLX42KjQY5/FGXYBL4Xqjxr3fr8l1nU=
X-Gm-Gg: AYBFou2E6BYlQiHZea+WoC0YTiq5GrO3mFI0LiR5MnXJRLir0iEMd4LXjqiTyLzM+y0
	zxdvUNJE6mN2eY8qY2CY7AovqdSQ2Ub+CC62uTpF83yyKWHtYcl18SfQl74o7dyXUajp+6kEYmD
	w0SDLOpd0U5glvziz/tjbi9hfRdQF6jPvucrzLonTiYdj/4nQSzrB2GtxzZX318gU7XD2Vc0A7M
	1STBF/yIebEJl0p0Snb8qZFZPIRCAkADYvosAYiZsYy6MQ4rV0XzGdJyNodnZYYDrE8+LW9XY6X
	b34HJR4qUuZg0ABXvBDoVvSECpybylbxzoEQ3tm/3avOk6i9noJD3ptWCApmOYoR661Vav7RMar
	T34Jx+JmX6hjDqJqPJzW8oBQ7pm/L4Nb40aCgmk4BYqnstuiyNhM/qRncHDUPMq0effsmM9OckR
	fue8PooIjVO1YN/zzHUe0Cof5N7lMkat0vxDGFlF6uJx8gNH3vajXtjM78cpZLh05a61AKuL3/0
	rvaDQWh1hpWKbQVBSG3kVMQjU+CnPaQWpn2TUSlL6kHe986yJpLyr+VUUZscdRD3zIjuArlPpmC
	JHGZTc1riX/vHUfnYhTNgxs/auU3ALgdXNtFKGtWpkrNIZMm2MwhsoyOuekf7AL1iZw603avtQ=
	=
X-Received: by 2002:a5d:5506:0:b0:48d:1b82:46c5 with SMTP id ffacd0b85a97d-48e3eb8e7f6mr9172381f8f.6.1793007082724;
        Mon, 26 Oct 2026 02:31:22 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm14217710f8f.3.2026.10.26.02.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:31:22 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: synaptics - add LEN2072 to smbus_pnp_ids for ThinkPad P14s Gen 2i
Date: Mon, 26 Oct 2026 10:31:18 +0100
Message-ID: <20261026093118.2312302-3-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026093118.2312302-1-dmitry@kernelgen.org>
References: <20261026093118.2312302-1-dmitry@kernelgen.org>
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
index 1ed9261bff..b007e642ea 100644
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

