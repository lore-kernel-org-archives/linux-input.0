Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111237475C
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275479; cv=none; b=ROk1WLPsZlglf5nCsVXlinZYX16LwTp0vUK0WPvXsgWvEaNyhM8WOb5K1BUJoTZaF6rP+7aYbm4TtuHAG7hBDieIsgg0/dOF2Ex/F9HPO+px/K1JI3nr0Lp0kc8UJQKnbxELpUbEDtd1wy4kyEWI7GiXxaq+YR6yYBxJtpmOisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275479; c=relaxed/simple;
	bh=upnZKKqrTdYPQhu0I/YEmjrkOjwwTTGeBPtn+J0wIB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf4Ru0txvFf7F6kemWQfCTc+6M7cSyDjpenYTCXHmYHRVmSmfhZI5VmP9Zoe3KxqXhFnrkirWSDSXyI86TMCq0hJXtNZcDBQeYFhlAbIyR0x281G9N1o/jG0x/c9yoxaAqj3hjRona5XWEOVDQmwbtI/MQCWFM0wLH8aUipv/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=hFNCeMa6; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="hFNCeMa6"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id AC06F4085B
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:44:30 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id DA4C14078C
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:44:29 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3DDDE1FF1E8
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:44:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781275469;
	bh=00sEvH7oHPiBpKlkfQvwzkLisjcwoe3ZKdQKLGBmPfg=;
	h=Received:From:Subject:To;
	b=hFNCeMa6tFf4XjKOYZR0/VjBMlQVGhXPMJQb/nb/Fn8kl5W6gXMNL19nUw0gRTF3V
	 5PUwVg+ruUs6JOsSMJ+ynpcJvNcaezIfQRaBpvVYTF7kSfI9WgXh77E8SFnEGMbbsL
	 il1122wblCIwpfkim9rybD/97Mm3yqiCNtcgRqVsC15fBghlU1rYfydpjZYhkzeQTH
	 vazc4MDxP+DudxmbctzdTOOsDze+Pge3sYkmsSZ7SUeY7o1Uo+4PZRJ0Hld4zVFjo1
	 PHZBtDji5eKy6Ulcv+CZpxGaNEHrI1vlapyKfaKi49oY1LEAJ+GP8gxyKVo8qBqVQc
	 41/p2I1mGOxsg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c855599a77aso562585a12.0
        for <linux-input@vger.kernel.org>;
 Fri, 12 Jun 2026 07:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ94aaJ5v9YO/qv07Q/nLhKG0FxOWZOqGYQCzY/X51yP89ElkqENLRHf9WmIL70pxUf76xwAwZxMSO5UKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZcxnTilO9v3C6aAWmK5UxcSO9hgmrJUL6Ft0ycg6aLchSPMN
	wFcQ829Mjvm2sv2w7Ssle9DT0vyKTEWJBZeJ1awOkwbHCQdVVVMSJ6NaO7RyKxiH4V3gMGdyK1j
	98uqVVVhNHb8R7OGEDtNaPvvYnml1f2A=
X-Received: by 2002:a05:6a21:6906:b0:3b5:52b4:87a7 with SMTP id
 adf61e73a8af0-3b783b22dc8mr4016292637.6.1781275467977; Fri, 12 Jun 2026
 07:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-2-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-2-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 12 Jun 2026 16:44:16 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEJa3gNqxcCLxpA+DzLy03VbwxRYG1AEBHW2zf_WwZELg@mail.gmail.com>
X-Gm-Features: AVVi8CfTicNofw3Ym6Lkgw0lBi5BidNPOBB1HboGqU-znEovT8B-CumIsMVNdSw
Message-ID: 
 <CAGwozwEJa3gNqxcCLxpA+DzLy03VbwxRYG1AEBHW2zf_WwZELg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] HID: asus: mitigate possible use-after-free
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178127546948.2742736.3599212646537260304@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
>
> The kbd_backlight pointer is not being set to NULL after being freed in
> asus_kbd_register_leds and other portions of the driver checks that field,
> therefore set the pointer to NULL after being freed.
>
> Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.org/
>
> Suggested-by: sashiko-bot@kernel.org

Good catch. I verified devm_kfree does not mutate the pointer. I
recall this being there before from the comment.

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>

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

