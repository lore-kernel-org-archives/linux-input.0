Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007083;
	b=wxkucmB2BJALXYStvgcR11hNzeThqNuPlEMSnLAUXz0qaMxtWJl10Y3jcarLf6EJdb9j
	 zsXb+qzjWqd/TaRVT2ZJwdEWcyPfQCFIP5eQG5MYkYbKtboMOSxtqV7VB4IsexdSkRagz
	 FNRorPsWPIiVEdzT0DPuaBCdy5m2eF92r9y2xBYveib+N9LPG4jtRQ49FuE27dOlheggu
	 4IpfnHqSQvqKHbqLd4jj3kT2CRDcybJfR7Sf4GYDINb59lQOGZNbSzw610IdReVdaXdEQ
	 w8kfSMavY3ZQ6pClQDJtVVQVYcJEFXpUXVTzvSWJEWzqVUXFt1I0YVm0uTDN4r917zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=inG+eG1nMsX+iByUG8PvEF7bboqnh0n7ThmAeiyUE+U=;
	b=JKjuj6QOGvIzkuqq5UPG9F81jNTa01SEPcI8kqWIHw2I6VlYN9S9o4xykgT8HWDEw9jI
	 cRQIK8WiLhMqtLnnSHNVfpKj4w5KrNfP9IAZLGDsb2pkVtCbnv5G3hF/bBD/ZKWkTcUpT
	 7W+oxd4VgcX0Yf4G3jAHV8RoChae83III5K0N8nahv7NL9RhNiHfBiO7HrkPfUBU1HLLg
	 fXVWcA10FwGMQSQ4rd6ryo2ltKvfxHnu24VKNvB9GDnF7sQmCQquZnIQRLnVR9f1czI27
	 dic094NvlQi7yv4wSLD0RwKfFFokknfyXVgi/zdmPoFDjRci/UtGNTyYUvfXViGbtWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kjgYg7Wr;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED85606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 09:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ED85606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kjgYg7Wr
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40aa03a96fso22504666b.1
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793007081; x=1793611881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=inG+eG1nMsX+iByUG8PvEF7bboqnh0n7ThmAeiyUE+U=;
        b=kjgYg7WrGEcBuhpl3CUGzxWJjnIK673xx0heVzn3yFtADaSoYkCqrDOM1sBmZ7r3dD
         mhM5pT2HIv0M0zyqiPiBGol2bhRNeagZAzbpiyG3tKlY0jS0lV1Pb1tstAHqv/5q/l2u
         zqjjZH2AaqXWXsaFy+3pz+K7BdenONp+DTYdVl//R4jdKomaNud00OXJBD0sGD8wPnE2
         fFR6fZ1xtCtmjBUiSnqPsFhKdWq7r6oH3S35sbpGeuz2N2JtFIhCJYGqUOPAjX815ypJ
         LorZp1dfg0b+rS1iI9Bi+gWnCgDVXBFpeNFrT0AJhPiFvVoRYoVLnS+PWGAj4l8/rWBg
         oqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007081; x=1793611881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=inG+eG1nMsX+iByUG8PvEF7bboqnh0n7ThmAeiyUE+U=;
        b=SoRYNPEW2yMYTOJEKnzm1JFE3itG31NCGgKmVQROU5lzhiyobzOHvbr67c3Kam1ThS
         4Yqm5dvz2cZQP5+yx3j/Lb9br0TybTCnFhZoA3m9BkqKqSKF+9Ny6m4sBbBFxV7idNFL
         tXJgnyUPISCp4x0VGxX1uRs5q4z6ZnoQpJL+1IM3dW6sgDjTA8XytATDbyGVEaOIJSrT
         QzIKjKAjmW6cRaLjSoZdslGTSB6wdB7eRIGJq/PRA8d0xlRLDresKqun/aNoBseJ9LsG
         P3s7c43/jjfkElBQlle9DP8MOy+dc1yktTBStk2e42ZaVIKa/HB9hFerjhdi0pbomehb
         vwMQ==
X-Forwarded-Encrypted: i=1; AKwUvBztZx/perEqYB1WWd59dynut8YrJW9DBnu+chcf3JO4wcFZm5AlnBoNIYAkIN0gnLi0rfjSBqAzERklCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKts2jsE+rNHpZJBqbHp8q1PwtWiWzIODwscOI5xLqyOzfK0BKY
	nwcuosf0Jk5BaSuobi4IT/mchFHXoIHQRdiGPQjHtbeW48YOYE9G+Gz2VVQPOvk9nqFS222VoJq
	Q7Mr50L57ww==
X-Gm-Gg: AYBFou15QB9dv80ex/IQZ+umBBmcNYCSZc3Ajz2w85YgJ40vwuqRmYhWyP5HDz8+yI5
	JExHjJ2BdYOHiAWi6k5sNOsHx0DrZAO72Kw9+agzRsDMPadfAk01S//LMrigUXvJgz2mcwf94o2
	NxJAkBmSBK+38tPDq/b8nZGlSY/+DBAprWWM1ha0r1SekB88d87GFfOEhI0fDAMFd26T72SkUNm
	i+fHSttDsZpXm3KCmKOISRTpWxf41SnkpCm5X7ToDvPzBzDbtXZtcIeLKupyhGtuIXMhPfL/X7g
	eBw3xKZ2ANN9iLbUIAZyf0L+g1soanAgpbzO309BEnZrLUg4Y0rUc6IB95IAA366v22YGkpcXqG
	z5DdCMiwTou6N4aufVlLaoQMGi2XpLyxq9S9baxcwfm8MUem0xHgTJ95Dt25pQU4JJrSfmB9kfC
	H7kiUtwlfem5nU5kLNzLDy+sLZJLkBI1Rrfb3f4xLWM2jC7E27b/7w/cLucn50C5ps6UBhrhbNf
	wuqwdMS0P2uKAJ1mat5APT08+lOu3ofjVQn2OkzpxDZ3eTiAikQCkrtrhcf4IBAxH5uWmu7MCqt
	MQVn725uNCi10tVlPZdujBSj/Ms4pNDePl4U/FHq05fGr2kXlQln3R70SDNye1wmib2cSPBu89f
	Lq+QnfzbvKDWsCczZSE5d
X-Received: by 2002:a17:906:2886:b0:c46:b5a7:5b29 with SMTP id a640c23a62f3a-c46bddd029fmr713493166b.2.1793007080405;
        Mon, 26 Oct 2026 02:31:20 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm14217710f8f.3.2026.10.26.02.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:31:19 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: synaptics - enable SMBus for ThinkPad P14s Gen 2i (LEN2072)
Date: Mon, 26 Oct 2026 10:31:16 +0100
Message-ID: <20261026093118.2312302-1-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
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

The ThinkPad P14s Gen 2i touchpad (Synaptics TM3471-030, LEN2072) is
not on the SMBus passlist and runs in PS/2 mode. Forcing RMI4 alone
does not help: the F12 attention handler reads the whole 79-byte data
packet over SMBus on every frame, which caps the report rate at about
43 Hz and loses fast swipes.

Patch 1 makes F12 read only the object data it consumes, raising the
report rate to about 65 Hz on this machine. Patch 2 then adds LEN2072
to smbus_pnp_ids. Patch 2 should not be applied without patch 1.

Both were tested on a ThinkPad P14s Gen 2i (20VX) on 7.2.9, including
s2idle suspend/resume and the TrackPoint on the RMI4 pass-through port.

Dmitry Mikushin (2):
  Input: synaptics-rmi4 - f12: read only the object data on attention
  Input: synaptics - add LEN2072 to smbus_pnp_ids for ThinkPad P14s Gen
    2i

 drivers/input/mouse/synaptics.c |  1 +
 drivers/input/rmi4/rmi_f12.c    | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.56.0

