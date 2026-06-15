Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A0309F00
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560380; cv=none; b=mbydl3UBKG7HkWa1IAWMzpEEpPOnv3Y0oJ0Ij7fHJ31II60OxblKze+EovXNpYN3/iO29WzNcKciB8GRbpY6+mwnLzz5eTqHjX2UBQB0aHHPdyQuHlHEODpdoOcz3zfo1R4jYTdnU0bZTq7oXIS4Y3RQWkUTCgMMXJRxlM6E74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560380; c=relaxed/simple;
	bh=Vx1k/1i2/CJk2kg33MwwnmUvQfFhZqF203Af6jVcRT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUi8x7WnZcv72MS0pNFCM9Ppmy8oh4j3Q1ZGeqobsUha/hubP3EpfgJUQjUkfNKwPuv2Zk8ZdSUujG6DOyDbN/qBcINYswcrpwv72i5o1gFACUs7w1bkEf2XZjFWioFl9blDkJuSnNABb0z9bp7Zrj72V60bW1txuD3RXiFrpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NgHwvm20; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NgHwvm20"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 67D86BDA20
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:52:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 0406FBDA2C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:52:57 +0300 (EEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5C4971FFE29
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:52:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781560376;
	bh=sjBLEttWFbXmYZ4Nhc27OwnBiGWzOR5XNLMyWKq+RCI=;
	h=Received:From:Subject:To;
	b=NgHwvm20gy8Y958OZ+hZHWiJqcBxEmtR2xhT5fVxSKn1r3KWjuQkZWlagWwV05MZv
	 np/5oWdDxljCQWSlqfSayEI/oIGOIeq7bt4zDZjWKa56VF93G5RIAgONUBsLDoNG4B
	 AQyVOWJxrCM3M0BZh2No1Ta6qNTnm52TI6casD3gHh3BaPdKsiqZdhxcc59JYeNN6b
	 2WeEyc0aVrd4ik0RIRtvHQnz8A/8UjIw6Gxyj2gfaQ9kbJTkGoE40tQoM+SQdJ2z0f
	 zmXrUwEf3fjdh96SLcIDegvsY2p/0Xii/iE099iTgOsW2oTiXbuV3ZdsRN3EkhrEdM
	 auqO4eOhMRhXw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.49) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f49.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so2443129a91.3
        for <linux-input@vger.kernel.org>;
 Mon, 15 Jun 2026 14:52:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9MGpdsQP8aa1am3vKu8rCWmS8TbL+YekWMQm7nOpoubLAEBRN0BFWnHGVXg67ezO94BWmiHdremHuiIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5beBF1ZK7kKVR7rnNs4HA2AEG1kpt9H9kjKXWBjjWp+a4KFs
	mw+4ml+0YYVo7Dmdh75IBJBtZcjtDi7f8EmvC+9q+q0+BSLux9Le7WDtcsGL/wCLh90mm71WSr8
	lvWWDs4701D/xMva8sjOHdTmPqPuTzaU=
X-Received: by 2002:a17:90a:f944:b0:369:7421:b376 with SMTP id
 98e67ed59e1d1-37c529000c9mr868462a91.19.1781560375078; Mon, 15 Jun 2026
 14:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615165058.3845-1-denis.benato@linux.dev>
 <20260615165058.3845-3-denis.benato@linux.dev>
In-Reply-To: <20260615165058.3845-3-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 15 Jun 2026 23:52:43 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGXJJAAQp2oY+9ByT57emGjCgraim=tNVQWCsK8KcGbPA@mail.gmail.com>
X-Gm-Features: AVVi8CdCGCMU74J5stmKPp6rtemSmuFQ8s_Zt2Qyh531DnE_QD0TrMLd1obddK8
Message-ID: 
 <CAGwozwGXJJAAQp2oY+9ByT57emGjCgraim=tNVQWCsK8KcGbPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] HID: asus: remove unnecessary OOM message
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178156037660.3302987.9508601295805685983@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 15 Jun 2026 at 18:51, Denis Benato <denis.benato@linux.dev> wrote:
>
> If devm_kzalloc fails an allocation error is already being reported:
> there is no need for the driver to repeat it, moreover if this were
> new code checkpatch.pl would throw a warning.

Perhaps something more of:

HID: asus: remove extraneous allocation warning

If devm_kzalloc fails an allocation error is already being reported.
Therefore, there is no need for the driver to repeat it. For new code,
this behavior is disincentivized and checkpatch.pl reports a warning.

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>

> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 05ca6665e0a4..bbf964b12c16 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1377,10 +1377,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         int ret;
>
>         drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> -       if (drvdata == NULL) {
> -               hid_err(hdev, "Can't alloc Asus descriptor\n");
> +       if (drvdata == NULL)
>                 return -ENOMEM;
> -       }
>
>         hid_set_drvdata(hdev, drvdata);
>
> --
> 2.47.3
>
>

