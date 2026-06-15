Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3193B42E6
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559907; cv=none; b=iqIE+/qUrEQ+24LBuQG+VOCLrNcETObVOdbhaDRM/qjcqNL36Cd0tx88pjdnV9IXNtRQ5/osmQkmyP9kxfSTM9lulGtNppXbM9MT90gyTP44Hoa6Aq2mIYIkCs0zrOqDJeI+qLZUtjJNXd2f/H9a72JDm9H6KMGYKyml8o+uV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559907; c=relaxed/simple;
	bh=seora9rXBvHqU7B4rHYdjobYA41wO6cDNcalPIbo8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPTWfmGOgsBTH774i2/E1DcpWsoKujhNH9L/Dm/7TesVrT43hP/7Ix/i7aeeMZeA01vyCzKvjNwaq3/2PASz0jqeXq1IMhTlHIs3ybOMyh7yjLdSmcdHkXjTLu/CcPFCb5hGG5Y7RzRcKujjjgFN7oElS7SGywhckF8801M39+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=irBj8f0P; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="irBj8f0P"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 91BC6BD9C8
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:44:56 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 1C1F6BD9BE
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:44:56 +0300 (EEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 525F81FFCC9
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 00:44:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781559895;
	bh=JE8sq9BfEJetlOuDsg9zFWj9sWr+ft84RGN4wJbJiK4=;
	h=Received:From:Subject:To;
	b=irBj8f0PZ653bCR0G2w2TE229Op3/KGhw0aDeqtyN/XPmafMjbEU9ONoKN7/pO+ln
	 9VWVumylPXPN3MSWHfI5ivfWOUODiQLNzIKoqJIb+1xVV4v6LLGhTLF7885bEAZ6jQ
	 vvkGmgNTKNyCJPJNHUjrNIh1fkloM7oUt5p8FxbBbxGnB1wn3mXD1FyFNCWrTvAe83
	 dIUuBSVhf6O3i56YuTjqnWeDkWLoVm7lnFDlFRkllzV+GZDWFdY+4HI1s7aDt8PFjb
	 7AtN/LDzGaII7AxbFV3OlFQSiMR3qIKIkA3TWwUx+hchRAYe1yc0BHhm+gP41AGJAE
	 pq4FgevIHLTEg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.48) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f48.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36da151a152so2702566a91.1
        for <linux-input@vger.kernel.org>;
 Mon, 15 Jun 2026 14:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZTNW4ysfn4ZoDxO/nrucK6mDBTa+mfBszCpKpOVYt1MjO/hXVlU6g3+UAbARznHM2w7N/6NLCf6NEHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiY0rVdnlDBDeW24zWqzDwTpstB0w5aOiE7EqEwPwBJqHJ1bua
	0lzAQBF0/ySEa/q42g+YFsEPmssbgyXQOQAiyAXE6jIDZp4d1dc/ROpEcQxLy0tdAefnAf649x3
	85JiRGLOENdAFakamNSBYun8u6jn1++4=
X-Received: by 2002:a17:90b:2dca:b0:36a:6ac2:8bc8 with SMTP id
 98e67ed59e1d1-37c2bcef7dfmr12309073a91.14.1781559893710; Mon, 15 Jun 2026
 14:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615165058.3845-1-denis.benato@linux.dev>
 <20260615165058.3845-4-denis.benato@linux.dev>
In-Reply-To: <20260615165058.3845-4-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 15 Jun 2026 23:44:41 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHnmPEcROYXZgC1C7-mXWEnRfOCKwVB_4kPAj+xpY8Uuw@mail.gmail.com>
X-Gm-Features: AVVi8Cc7Mjxa7Qg8WR_X9ZRf86gh828hXV-l0-SptiYW_NQlR3gMzC-mxlw3dSk
Message-ID: 
 <CAGwozwHnmPEcROYXZgC1C7-mXWEnRfOCKwVB_4kPAj+xpY8Uuw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] HID: asus: fix a off-by-one issue making a check
 stricter that it needs to be
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178155989556.3271381.3948765359117287636@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 15 Jun 2026 at 18:51, Denis Benato <denis.benato@linux.dev> wrote:
>
> In mcu_parse_version_string() a size validation for response is stricter
> that it needs to be: relax the check by one byte.

"making a check stricter that it needs to be"

what check, you might need to reword the title

> Fixes: ("hid-asus: check ROG Ally MCU version and warn")
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bbf964b12c16..6896730efafc 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -835,7 +835,7 @@ static int mcu_parse_version_string(const u8 *response, size_t response_size)
>                         dots++;
>         }
>
> -       if (dots != 2 || p >= end || (p + 3) >= end)
> +       if (dots != 2 || end - p < 3)
>                 return -EINVAL;
>
>         memcpy(buf, p, 3);
> --
> 2.47.3
>
>

