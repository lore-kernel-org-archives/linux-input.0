Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035441;
	b=hJna0j3U2o/yaImZqBGCzpA+2eBPerrRDf1spzWXdrYa28ijHJToYN5twwUx6JMHgZIV
	 XNxRdBMbZiGXhzAVozVPtZHFgOiB74vV/nx0oOVwn1Vq5E7WD0KrbF9BF0NJtlIY+2C+r
	 jvV0eM7c+pYHeKmIgSoboQeHZEuHg8iJ7n/EZTHZ1OY2Fjt3ZsN/9xs9atc8enXuG53BL
	 CK1SpDIxdgJGmfS7w81wOIXXtCWDfGOCGS/c7NXnTNzMM4TpagGpjobFaRT7MoSrClFNh
	 ol2h4TJDcDXLwcaEg/+MWpdcvq6eFfe9MiO5JxYb4ECAdlTTLwbgTjYibjbTh/aR4FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
	b=sXsuTR08VcKnu+SkuuP4T3KGP0NUS6VTZihFK9DrUi1KNPFyLTMqppqZN/Gz0zY2+x35
	 +JDNmm8d4owwptaJx/EvYUbKVaeHCK9AbuBYsMva8bfdPMG5/K3T2kFplPPlJ1MAIY0TM
	 /+Afm+IVO3UWgOA+XxrZGT9Bx9Kc8HQaDJzBgMt8UA8GU+OWP0EOQ7s29MrOAe/iFg5Jx
	 CEZ8H8tu97Wjydr99a3x8ioCZ76aNa/D8OKfOP0xPrRUx4ioUnygu+v+x0bH/R4L0n6Qx
	 BkpI88VaZbeFneqQY0Ax4gSFDPGuE+xsN2/R26G94CU/43N50XcdEphiQnaT3tl1IVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ3U6pM4;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89C606A331
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 20:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B89C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ3U6pM4
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1378578f8f.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035440; x=1795640240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
        b=eZ3U6pM4uWJAg0soB/+ulwruWIsechmVHctntlrGfFAqhTYhXgCJHlROKnJ6NWnq1M
         laW+G5ENbDVDab3NiCysSPmTXaeHdNeJFajmjVOasM0gJcbZ+MfTwYBW3zm54ce1kICJ
         hY+WWaTNVK+KTLU6RflsZwY34xeYZ7hw5ASyRvArs/CPArbC6OKothn8Zv5+huSb5kaE
         HMEfQgptHblJF8aAtmqIsAFas2RViUEo0KFttKWUHsgsuh00kGjh+0scqN7PPKwt1fUb
         RXzhJt1sLYeZXh/FkEEwZDNWpqns2B3YzK6/7TazCF08CXfnRCan/NaG/2KidQ1vyWfV
         rp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035440; x=1795640240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rD0rqzmylq+YWadKYJUM3h2KbEjwE3lCD2TvIMgXYy8=;
        b=LFbEpkiXIJFwQ1+igsGqihSAsk4UQ9OmmC14LhsFrIem6uTlEMBGVk8N22B6Wyua9T
         ABedntLth4eRsGw4/RlwBDlVDZQKZ29L9mRj5SsVomSNNkJeQvguI+lg/7iHzau7t8CM
         09Ct6dI4xBr5hpGs89xTibNJEJo5IgbuAUsyQNr2cuVA1bVD7KUIuC0aRZv7zFYnOv3I
         6JqYpohHcIBQOoAzldm8bJWOArs+SsHpn3yKkrYQstyiu1Jp+ihpFtjaGut3JqNEElbn
         bKxvV6YVC1YCoYqYrqAtS+le8Gc/XvG7L2r2hLo18lmFsHTSWtdt6xAxcp5r5fR0eZJz
         09gg==
X-Forwarded-Encrypted: i=1; AL+hErGFkuZDrtJcDaies1EU47sPyKf/JZ+uyQyE4WwRnfOwYXgnmiAL32moezGp2Ay5a7700DClORxPaJUXJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vuNiooiRQ1mrpr8xE+8xsptVio3q72X2WBTHz170swtHxBm3Y
	VxiaJB6WFcztd6xH6CB7cMTYAfJXYxLl4SNl2BSrz0+D7ih5S8voNi3y
X-Gm-Gg: AZFdTZf+fpOfLDwE+Ffmp8KAieD+KJ7U8iWT5skBETSCwMRyd4z97xHYiXjZl15lluD
	xd7HYXZiNSW/hQmE35I2YNGWRyGD6+bd62dzZq6sjVq/nnr05lMCF77SjANgY5PHiHd24oLVEix
	Nc3XEVwAT3OlmlcbiaZkvFQ07bjxH9kjUupDNuBbskHHPO2pPziB8pWZoDzt2dB2YC8exJScyNE
	9Bs5xQ+wVBP9ICTahaIOlDbxwvf17boL59D0Xi4Pen/jAjJdVnpbL88pYG+5S9mkaDXbcn/Tycw
	9uCABfbehu3DoOe7TklaBY18eVjoc7f25wkNC5K4b8r9pIulOQaxChGseuMsxo/N071OGGQ8pED
	pG3vZVctt/6HVyMHHzk74yXn+6Mgm3Di0zQH05QeCn1nDg2ZadyPpni31pjAOIDVdclhAddlj/O
	jBD5WHI2+eO/WELSi1Eob5+KyzJR2O5SBz6zrvjaj5wgnU5C8x3HziLFPSLkLPuK9Y1fR2eFejs
	xsz6N3oK6PYk3JPH3qs23jwUCn3dEe8NrRVTsP6fmZ776vk/0OAFvS35thlbBerD1Dbhi7V+0g2
	fT396nFrdRelzc1aQ3DUKr3CCjwj
X-Received: by 2002:a05:6000:2f81:b0:4a9:4dfa:c151 with SMTP id ffacd0b85a97d-4a94dfac238mr347385f8f.26.1795035439821;
        Wed, 18 Nov 2026 12:57:19 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a65560bd46sm6675311f8f.31.2026.11.18.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:57:18 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 11/16] HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration
Date: Wed, 18 Nov 2026 22:57:10 +0200
Message-ID: <20261118205712.49261-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219658@kernel.org>
References: <sashiko-outbox-219658@kernel.org>
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

On Tue, Nov 17, 2026 at 08:50:51PM +0000, sashiko-bot@kernel.org wrote:
> Can ft260_reset_and_rebind() race with an active ft260_probe() when the
> driver is bound outside USB enumeration?

Thanks, this race is real. I reproduced the order on an FT260 board
with test-only delays in the probe and in the reset work: the probe of
interface 1 passes both TN_189 checks during the unbind. On this
kernel it then fails at its first HID raw request with -ENODEV from
hid-bpf, and no subdevice is registered. Without CONFIG_HID_BPF,
hid-bpf does not stop the request. v5 fixes the race in the driver.
