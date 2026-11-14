Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794680259;
	b=nmi6mQ9Bpplx7JzmrJRDtT6bcyFOWp6OzVT/8pTg7/etYA41ytUf2S1RJ1SK9Z0MBudP
	 05xEgy2a5H5f4ZsLlikoQJFUWyBVzKghZQl+npMmDYWM1Jg2xLZH0BZvPAOwqN3bExHHG
	 fihvSXkP41V1UuNplOuHeSSo2sWuFYF0gk5HrUQe0QLgKWjElZM0ftRDvuOE9lW/i1jGE
	 co4QmGMHc5RiOz2KcvJ4gqOFmYj3XbGhpmprtsRB6aRCUW8ZDNMBZIldw3PIab85nVZD9
	 zdBOPV89Q5JAHysZ63qYYVVAuqPCGm//vCotGM+w2qHa3huy6Oaj3LLZLUl1kNaXscQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
	b=s5v4XWhzjAx75LKaEdUV3EuFoPKKnM1FLfgcDRpGeNu8S68acLQImks4BktbzvIsByz+
	 O3fwNSJtxoFRCp4+G722lypG/iJbp0A1gFEOfsOG1tL0pIl32r+4YF16Hjf4ttueIofGt
	 QEaK+fmFsnLnHpT0Phv+mosez26jEk64Jf31YASd1tCGurf/FSDbua1TxvT8bX0Xc70hu
	 AZEMh1lHmq9OQ67oPttA/xGHiKTmwdCB4VHzpAThRurzyd71FXRD9CzQvXoQPPDPRDNm8
	 Bfilhx3vIDxGgVVnv4CnvU25DV8tAxLaC2Hf5z7r2A+VcKeojFLpqMgEyf4BoSVl0PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXVOsOUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE7606A32D
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 18:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CE7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXVOsOUK
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99075306daaso2296770241.3
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 10:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794680257; cv=none;
        d=google.com; s=arc-20260327;
        b=E/MIO0vgyeWdSQkwFENwcleV7VaX/rH35P9FB+SN4Moa2AqHmo4ZvN5SKiTEMmDPe2
         foOnsd4pPAUUHZmGUkC2g0A2ToGhaIdP8CDhIMUV8+45bjF0uf4/DKrPVuEQtF1AelmA
         XMrjkXaAO6/eayt+sEgCv3Val15RsryTFcyqRcdeRdCafTi5YOJmMeWDl5n1z5yNLHqp
         PVB4pTEhwgLgf9GkqErx+MJaCZa8OcivFzytSewsDvl+inUd4X3due/APzpL+Q6nSGbm
         WDHbFbgXLr8+SpL3H4RFTvy/l8MRTMMalxo4Q1Q5FMUVLjwl/KWzaRXOXGp1Y85IjAcv
         AaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        fh=Xp6SJkK6kuGwzAcLoNsJ7UvJQ10Ln/ibRxZSzOPb2r8=;
        b=kuwucVrJXxD8g4XuDGKTADVL0KgyL5oWBvsB9tkAAQpMYAKD+7DqWKK8WyPNDQTVXX
         AtFKXQ4R7UgjvyH4INP9fj5fQ+fBoHibLjXflhz7sEVJAf0bknH6EYY5FGWHIl4HvCj1
         s2OTP5m3Qx7xnoKa7lo1/XVFsv0fMG1qiO4RzHMUOxaaW9pvbJXtkXKw49EJsFDoXVfW
         89CFGcTihxYUhMhFo4QREwJ5sA4nqpbkU4KA2CKJzwCfOEuO6OH63VPi6bGdb4tseIGb
         1m3IozL/45BIguPOVEFokrcm6C0ZYKteNw+hoQeBaoK1zGdf1BYwtTmFj1gK6hosaBJq
         kIQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794680257; x=1795285057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        b=mXVOsOUKNAJeo3ZO3fzDWnh6gj9KJzfdTLuB9IRjHlWh4Nit9zPTAnajqt84e8RVPv
         L472Pihle4AR+2PogxGgWNAO36LIkZJQgpwzFM2MMFEsHdRsRmNsAE+8x8RGcaI5ZSmi
         Yt1hgOdSKtLekx90VVujp+zofGT8mX4KiOxKkZNkG0b535JM72hw6vmkLm6ZkW3MCwJr
         R5pVv87wfXrbumPvOB7BpKaCiDCsIp9tFbXuP96qQIjFULf+dBKE12kOkg5M44uewczb
         ZpgsDH9LCETVRBlm/QsWsMq75Smd2gyhaHhRH1Rcc38tx9BC5snLs4YFr+1vwJJWQ1Ki
         Ci6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794680257; x=1795285057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Akw4w+Mm9p0/w7vgjEImHk5sQ6l3ya6ZIdLy8E2yDA8=;
        b=piYjK7BFC0kOpwEpHAV6evhVt8NxNd3c6UVKrPTdKR9uyym8UBkBk9KHqajZdZtWf/
         WgIoZUSC+ex7Vh/CB7fvKx2jsDayVoNzcIduz4e+b3UXYT9xhbRgQAxbRjK3IyrUI4D7
         8PCh9Y5PjSeWvkXC9B5PJ2f+KJWXkAO06d+oc1UdKp9YZuXmGoFqgAvW6op6WyxF1pqg
         KRIVaghjerXeHzjQOgTmUpBA6njdh0ndjUbNKvbYWWeuV9u+qgi25Ixxj/U1BHSp/47g
         lZMtqbcozFP6muArPj4R3r7lOeuHuPhOMrJuhmLJttjZA7O5aWD2aGz71MkAPnDAs4T0
         tF/g==
X-Forwarded-Encrypted: i=1; AL+hErHa/Hg/WtG87DyXbFjaRN3QqL/+fBonQwaxJDDHTBqn+CjHSPdOX0Pz6ssu7k1HR1REu8lVr+ab9vZLvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/eFqFsSSI41fxdEM+ttVzp6YQ5HqX7Wvb1iZVrRUDD+i3gYZEw
	Ngs7SWNp1tF09dX8gRog8j8c54ozTnkUQA/lpp2bHjJaO1ywH1rgtDXHV2CMO2PXeCnhTXkUV8L
	9InHkiJJ2zML0rkZeF/uEKnPn8lOaqzM=
X-Gm-Gg: AYBFou0gQmLjtJ/WhWw0lYDr/blbjrGE5SYFersjO5PpxpFR5ZC0HkdiB3qVkXDHrUA
	nJnG4k5AQd616nDRjJxKyuB9Hac6V7TRMZkAbfzYbphG2D6+KBU2Xzx+f8xNF4HQmPOPQLj313H
	2wwI3dWr9b1+rPTu5k9Vs+uvC1U0lyI3tuZYIKqXLemzIBo8tLa347d7zYwEn5Bh2IfkQHBicTv
	LyzIDs7B2AwA1St7jLdV+DQNr2ACNt3clegm9AF9FuJPTrMHYFLykHq0f3+aOTM1UUuELlg6NyU
	nDYGJRTLA5wL6jsT1ytoC4XgBJvBpr9xrQDCXIeVeNA9ivGo8K7jihaa0ZECGpNvk/ED5DUAKIu
	Vuqpvc9ItQMFD1Rvnd5H/yrS5ku/o0Wup80DIQRSs+fkI1QXDHbDPgfBAX0IkSh1j1jQwj5gtei
	jK3NPmLGW1rbZZAmoo5427FDEq1nhGbDl8B00FdoL+jRFs5w7dDTe5KMs2LyjSmcrEKkFMy/l9X
	WZ4YPxEkA==
X-Received: by 2002:a05:6102:94d:b0:7cc:2cef:b330 with SMTP id
 ada2fe7eead31-7d64d6ea31fmr2531841137.12.1794680257398; Sat, 14 Nov 2026
 10:17:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010095211.12831-1-krishgulati7@gmail.com>
In-Reply-To: <20261010095211.12831-1-krishgulati7@gmail.com>
From: Krish Gulati <krishgulati7@gmail.com>
Date: Sat, 14 Nov 2026 23:47:26 +0530
X-Gm-Features: AclHuK8z0QCSIrVMOeF9oHB31OfX_1Kym3M-aXR-skyGrdiQWegAViV-btSEV5Y
Message-ID: <CAOzTEaUWqAh14GFL2ZfrLS8q6EU2VsY1TyG8Tw2C53+6d5R6HA@mail.gmail.com>
Subject: Re: [PATCH] HID: core: serialize report_descriptor_read() against
 probe and remove
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Gentle ping on this patch.

Please let me know if you=E2=80=99d like any changes.

Thanks,
Krish Gulati
