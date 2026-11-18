Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014255;
	b=u3mlnpEJzit8n3BDiaCJDjwrKsTlERUIy7MlpGZPMdaniV6N+s++h95H04iJ71FVa8Ux
	 Zu8d1LpzVpltX1uSMw88iOtVFXFRM6WBLwUysUfQeCyJwuialgwBNQ3zst8SHtrOv5qCT
	 CqTfalM3o08b/ZSPYOvOCkKONo2bgADeMiOnTH+WExEU6NB4S37JR57UsWjeGQMEB4iS/
	 uODg3ExyGE1buz0fNOTHIw/JwcKUvl/vgRDsLhUmqTNtvgsz6G3KEzQ93hsVtxH2qPGQG
	 mSZLJoL25cR8AFnaRKvTi6SEkLxdX7E3dgeWBupHdzrwLYQJQC7WB7FF0galruAP/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Disposition-Notification-To:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
	b=NBh13g+YNsB1MGFT8akfLrfWZQNge83qfdFs3Rs8KZVWdyvB4GhdyDlLWzM6wnqcK//I
	 hZvJfwNpcjDrHiIdwZnO5LJDeTNVt7lRNnQj7XpQQxEkj5IiTir1MPVe7nrWpXseQmvzu
	 NgP1tJlUc+L9abSDA8kiFb0a8ksy1jy6iZlI6wKMdOPVjoDbisH59OCQXQX2V1Uli0BdN
	 Z70/9hAuCNGih4w5jzjtr1NKiMepnnsUtsjfmt0pIoY8vF7yStoUU/BQJtF1OLBo7lECX
	 LFQMWp/KTuxeFho/QUe8W3GnxADYTza3+TclNmmLDW+OZ8F95ldt1junbwkvirFCL9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZgNY5oh;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A20606A33A
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 15:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A20606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZgNY5oh
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c505994e5f5so17603766b.1
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795014254; x=1795619054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
        b=BZgNY5ohqoEFQkAOL/iufDJibOewT3UgU2WVfwz5xpbqpBVbkYqnhc5ABRsYqWLPj7
         8GTikK+xnUaXefdEgttPL5Dir2FKlQPUJi8SXvikn6YoJ8UbiIxeNQg7jnDHaaDw3Osc
         7HMiGLt7nV5j86eNOAMOXcwjFXjU5ruEQXU4NglemLKDqQEaYmweQOhUf6y5XignaU7O
         piEJezvPTns6OaohWw2T+dnTPhfD44fRRmw2aW3DQLnvkEuv9wCRY/p7kGA0jZIVhCLa
         ud9DSv7W/UVw0VCagPDTiXYbdGPHJa2o2Mgq0t6CGcMtFx8rf8QAjg9T8icFuXsQLdxF
         VUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014254; x=1795619054;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
        b=evEOhKqE3Y4dB53qVLVHxF5KCUNHkoGaIa/tDaDcTrsC8Q0jVNToiHSFdkm4fFjtg7
         Zu1W5Xwt3jr9QegtERkJusNWQWWl0y1Q43ChUei/XFGpnGX/BwqKWhpTLUXRBCuTXUzR
         wI+91NAtP9/ox0Y39j7XptbFAp2XS85ZGA5iNjGl8EuZi7mTqAwNzWGOnSncwsU2FnAp
         RENBcQ+/ZCpvM59zgRWE+8PWQhqralSb+EeKlDsQSzRnbBfQySKlDvtn4eO4uQRgxyAi
         6Ch95suiiw6z6ii4wIpT8ePiXVof/3MlIjZJQlXJV4dgJk/scUX/utdMYRCnjUEC4GgU
         MqEw==
X-Gm-Message-State: APuU4Z9XOo+jJPUKYSqDa8t7dKhx/iGGZwpBWEwRtLCEdkem459NpcDN
	7suRW8ab9zd0YhErusT2zpcRCfCZoNaIntcPJgDo0/8Y4/8K2NY8oFOT
X-Gm-Gg: AYBFou1/jfoSbe4iJEJLrnYdnLHovG7qkIyxPexA4x+GLiMQBulF8UlW/BEZ88D1eM2
	z7S7I357liRSMAjp/XSricErLmJ4sSKuu0DmyNL+Yrn+IcIq4H+Td2fpxn7TsFveky00kdEg9U7
	lnp47JOLPIlPr7/vyzv582cfTnkU0XumZ9vNNj8FbjSWd2XJKU2exgFm08XioRAlsPwu2+rdp+p
	uR7M0oA7pLv5nmd4J3PfhdxSrCuAayMvXk6YbYny+ab7Sj/MTkxTYYJELy5fu0MREAA1RVsayPj
	IX3QqO1rSAyuTTdkJZjijHSBGQJfraCbjSqYEyGauzXy208fHoUKi4gYbfFlHZU6OPkfwGt/1cg
	HBM4ZWEFl5/1nyXyJZ5kzrgMNO6lp0vvb3/3qVDHrbwAWWO1mh4+YuwavKsttTTN0JEFoLR0jEZ
	KZezGtUOI5Ss67WXeoYmzeASgCPo+f/XtVNyfr1mBMJEabKuaZANWbYjP80U2JstnoWeTsGRMnv
	75MiTAClRq197F/rP5hMvrGAz/nzkG3NeSc3B9H3C40zqsFD0NhAZQproQfoZf/XDOBt8Hl7geo
	ztdmh+wlyjZ+md1Wqbh1CVGpB43nsXugiqNK6vpNDAIGAV9vUZ2T3LO6hxeScwtqR78QeVMaWEO
	rN6GHYDK7mJfo8g==
X-Received: by 2002:a17:906:7085:b0:c2e:8801:9139 with SMTP id a640c23a62f3a-c510deb9e53mr253754166b.1.1795014253543;
        Wed, 18 Nov 2026 07:04:13 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d52sm7516566b.14.2026.11.18.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:04:12 -0800 (PST)
Message-ID: <b6b45a76699f8b5dcfb2fdb1ee682bac0ed501df.camel@gmail.com>
Subject: Re: [PATCH v3] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 18 Nov 2026 16:04:07 +0100
In-Reply-To: <c80644469f01ae6d2ba0339a7a2fcd7c6080c310.camel@gmail.com>
References: <20261104-b4-pidff-rescale-exponent-v3-1-f45e64cf488c@cherr.cc>
	 <c80644469f01ae6d2ba0339a7a2fcd7c6080c310.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 08:41 +0100, Tomasz Paku=C5=82a wrote:
> On Wed, 2026-11-04 at 03:44 +0800, Shengzhuo Wei wrote:
>=20
> Works as expected. Thanks!

BTW Jiri, I'll re-send this as part of a series shortly as I ended up
doing another big overhaul of most of the driver code. It's currently
waiting for Oleg's review.
