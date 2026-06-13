Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8E2F25F5
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366367; cv=none; b=GRO2nFkpHyLHWaWZvLwOEdXLObIvVtjEIjKnMNsz8mwkKJBy/XImtuDwv3zunythBICVSpeV1YMNB+D2Qp47YO3NC2XGrEpcgigbe43U0ioaAtFQZgvCiqBOgMVkhXusad2C6v6Cny90P+x+rPtCdzGEWt5/+lKssyfk4buHTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366367; c=relaxed/simple;
	bh=kl2LsefFtQq7kcGW5ZmKyx93Bi8IWXp0RtRtl/5oq48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR5BQXg9w5GEIp666u5MDDaLBlu5QVrTAb7P9TJ876oVWRcEuaOYeFSSiQOQSyLbvmTjm44vfirbyjOe2nTCnVFmjPhO2C7VsKwCZxy1HdTGU17C53Jc/rxeSwLmacON0yMMTmi2cLWpSf4q8M4xm+92Y+QCH9JMIMzTC5qisFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XfR8k+AB; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XfR8k+AB"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 76E265E5A4
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:59:17 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 13E695E4A3
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:59:17 +0300 (EEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0C2B71FD5EC
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 18:59:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781366356;
	bh=PU3XeGvC2AQdgzcu3y/iedmipiwek1Fd2I/Mvo+6ZZM=;
	h=Received:From:Subject:To;
	b=XfR8k+ABsEBZTDJUyqdrWLURlMOABzteeWYLmGpM73QLZU0iD8J7JUlfTID99COAS
	 5iFNNSRVSzno1nKncBIQc4scgOuj6E62NB0Z71uUBBvJuZLYd8jkZQvvTJsXQN0ska
	 lW+hQLOgARYVJpjG3yOlberO3Rgtnn1p133+3XMiH5qhFKY7tYFHW/P6IWF/VnRAuc
	 5iBLsISQTh+3xCAP9OGwKYAwcPbkh9FIkrhs59IslsAGCIz6sihA+qzgKuJSOhPn2r
	 PN4Su64SaHOfUxiU85/YIH8knZ1dgCKCCj69HqzuU7DzpJgHvemnecev4vbzdP+aOx
	 1Zls3IzzqvVFQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2c0c35980fdso19882905ad.2
        for <linux-input@vger.kernel.org>;
 Sat, 13 Jun 2026 08:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ89Q9pviU24BypAUuiJtvAP06WsFlWyudXblQafBi3mBVrQAzGTLV7vufTe/ODiO7HO5RVBaXbMTZP2oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1WDTu+Lt87Qv8w46SNWJZceV3bnSKBJFCdVP+dpSiACjw21p
	/3Jj0sxi62sDVgLkaxAG2xfuYYkzdeLaCwBTHclFzZs7mGDWMNgXUpj/S0bW2DWHZ8xBtumIDdH
	TjouTQMJnlfi6sd9DeaZykGhksb5MpAc=
X-Received: by 2002:a17:903:3d10:b0:2be:bcae:f6b0 with SMTP id
 d9443c01a7336-2c41235d122mr89969795ad.22.1781366354916; Sat, 13 Jun 2026
 08:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-2-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-2-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 13 Jun 2026 17:59:04 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwG9AQ6q4JvhOgsMGz22h1Ex5h2AV9ymAVCjOwfAydziwQ@mail.gmail.com>
X-Gm-Features: AVVi8CfY7RO5ErR9VjbW-g7dzRevOofmIQJzg8cIs3Qmc6lGk2lUkGEu0cWw77o
Message-ID: 
 <CAGwozwG9AQ6q4JvhOgsMGz22h1Ex5h2AV9ymAVCjOwfAydziwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] HID: asus: mitigate possible use-after-free
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178136635622.1218404.14943075596553055999@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>
> The kbd_backlight pointer is not being set to NULL after being freed in
> asus_kbd_register_leds and other portions of the driver checks that field,
> therefore set the pointer to NULL after being freed.
>
> Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.org/
>

If you do another revision, you should drop the space between the link and tags

> Suggested-by: sashiko-bot@kernel.org
> Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d34d74df3dc0..4d7110b892bd 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>         if (ret < 0) {
>                 /* No need to have this still around */
>                 devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> +               drvdata->kbd_backlight = NULL;
>         }
>
>         return ret;
> --
> 2.47.3
>
>

