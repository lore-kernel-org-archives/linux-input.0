Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793194923;
	b=o3e3N1wY0iLE9y7/SEl9ajU5x9Ib3S7+/ZMglbFqaQhdo6fbtPguz7RlhiAPmrHVbctC
	 uYetS5lWlnGRd269QqtoqBPl6yKlqS/Dfd2sQXvCFHZAw8+5VS5oLW9zxUQhTBDkAhV31
	 EbuAAePyDP4zFKPZUgiztCdctDs0xM/w1pDC4NTOkbIYjfrecj8FGvF5bvxZXPBRMJ03f
	 YqydVl1wr5+2m8207OBg9vKOxuMLwKslZ4X5nIf8qe2kEbIZdmFI+yYplsxtHiADK7gJ+
	 U9Rv5eg+IhNkSQaXKD2AkmnnhD6U0qVcCQLTAWMJmLITEmD91DjU6W70ZKNnVaxIbnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
	b=pRgLVCnqRl0F3JXdRSp3Qxp6X7pNB80Mwvv6uQ33+sO7FgDDgW9LnxMgKtGcAdOg1L2U
	 WrdKS7S56UwEXx5OfcjDa9hNCXqGTg3IcM2NDsKd9EDSElmwbOD28nEu3n44dNTVlL/no
	 n89e95fwsaOIwxT59eeTX1X2zwRNwjT/WqjJ6lq819MOTrDPMqj3sQR3Ud/pcwyzcrQbi
	 3QXGRsGUiSD7SUwh/HajkJU4rV890xdnO5MO42z94Z27frE/9qMsesJfsSIpVi0t0bZp6
	 MxBUl7NfE86lDcqnydABF1v0ai1HT+9Ny9AGfm/chmybXic9OwSUPf7tOCSAt411SUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNVGOqae;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF84606A325
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF84606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNVGOqae
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a755bbe158so539986fac.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 06:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793194921; cv=none;
        d=google.com; s=arc-20260327;
        b=EHmouxkAe4IX31KyU8dxzDWgRhb78/UKGGOHY4QVp/hoVqLD0vGDN9NEsaEMmbdqPq
         Gj4hjFXzfGZeE5O2uHpMx0dO6RzshwcoTbCs1/LoHcmbasLRiABzp+eHXinqGUaiEuMp
         ae9f1hLvG+JYFZqu2VAVFPcnUn12jHUAMXFN4fDgOd9neD/TKtpdm3GFpfMCds9Oflt5
         byMTSUCh4LRDm6F9BfbTiJ3lrSBXYaOCMxVmDOKx4M+dnWgos0S4zHRNPr3d9AGRRgvT
         G0AB8BHB9OCvK6isou4MLxoY0No8TTqhz0aYB/fnMDK21lZUKKj4Ucn3Qovkf8Jd5xOq
         i2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
        fh=Z8GCLh+xJvAv6VJVzvsi1aQaCyefwE1GVZ/55uuHblk=;
        b=kpb/nnGesgRT5Aekpqcfbum0mtT9NFbQGdRVy16Iaybg6WXlMMZoPyiEZaqXe0/zKe
         2gqFSFWANeJPxqKmmKxrMvSmmzOVQKl68lHpWBjQfKlE2dgYgsU+sWs1VhyJe3yFDzpJ
         eMXIiQvB8ImUNBk7PMZyevx5021f6Dky18JCSzdwoSSegdjZBdHFZy65fUMKIKTPyR/l
         JvDSAyDZ0B6mMa96+5TwuQhvN8ICyqVfhieBtaYrOf7Ecm8VRksg3IJdZucrF8thqAPK
         RbkMBkBJXLGmfxC17jAaRt9qyuFWr3W0PfOGWZ5bPJe8VDMSe8HUN7+TtMrVEUBpaQca
         TOEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793194921; x=1793799721; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
        b=pNVGOqaeKAtj8aHOhd6hnqx48NNmdU4C26vXEIldW1SIz6scAQK1yO8g3LVWASQasc
         q7CD4KqCrCmAwq5jscXXokg99hdiAOe77ctP/mBrjC2Vy2SSW+N8GfbaiR/BNq4vufEm
         69lqPJSco4TKJNcx0FtvevRZgZWtSARqZHnZUWRquB3O19K+pN90fCnlBzTWn2xOLq37
         cJQOOuJenLSfSGCYChUpYKeQU9SPd4kHwjXI28bQnTfnHpK77T2MOuOMI1/SNhIykSli
         hJSXsWuT7ZV5l2RvIVTf4yzaOmGhV/uTtT7+gx/OkA7Am4i1388Dsl9Mii7ZaJ2bcISV
         QWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194921; x=1793799721;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
        b=0m6xM57rsEocvX5dlBo1qSDom2b8le2DI6bYk+PW/RXCYX45cQR0cNbMdo8lcxpRXy
         6IDNcnxIGhqLPk6S8uqsbBO+zO4VxdszJ2lUCcSlZpNvXT8sS5QmNq1+CAhjlOPxtr78
         gr7kgaq+UK7pGg2P1y4ECtdyYX0Kg2wWfWQqmftwymKm04NlXMXiCsWvTaJ5lM887dkn
         v2rJ4Dn5lf8oN96oVykHxA2e89NdhZrSFY5sUhQ6x6xmAYp9oovlq6UN05AKpD0lu1Nn
         /e8sIf6zTLSdX0sqTHSHDPuCM6O/t7P2eSw/hftqGh9OITk1v4aSgBGVthZmM9IC7R3R
         DaQQ==
X-Forwarded-Encrypted: i=1; AKwUvByeTW0yJ5E4+CiWWIn8eVzlA5QNAXLLlbu9zSGjSdbNFR2wQBuQzwWf8aM4cXmbWXcSUdAvxRXfTGeGIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhAghtxQY/MvlzP6jCZGypnceWnvVEBW0zNKYnq66BYdhaxEhM
	dTvlKVpm1Ze5Z6sVlwCAjgyhsFsAw2L8HkgHbmY5PBTOdDySiilBErsuvBqsfrtqDh+9SknShTE
	+ryMpCtEaqq76CTib5sB1/HFmljUBI/Cs5+3wjXmWxA==
X-Gm-Gg: AYBFou2i22G8UNscYN2MzdU0GyXbjcf2mPGHJzr4YeT1qIE+jzrunIJOrSp28DY3dWp
	2Vsk++eHWckFOKEYtPIwe/A/asA1wFvA4YSF0oigu5gnsKvoGLyDjbgX3dOzgR+xhYfA0oBrq/w
	LhFZr5IYz8YUg7Eg04vkxor85+3arZXWWIU3rSqDBbvWjk0B1G1DC3aFExRlWDAivKxZ3XhTNE2
	eiRcj6bPc9LdyMrcyBHD0E5o81emsbrcwVzIuJd6URvuPL8cMJY8QhReg0zGR9lZuPnZqC5SfQr
	G6o3v1iGtGE9rdefTsG08XdOXBchkSgptiob/K43UDz4RsYrsGOJSfMNYURE94cY09LQ4G8S000
	TtC6Ih6gYTuAfvgC2hHNfiv2kHB/O7O0u6LD/WgiRowxwC6SUK+0/aXjtlhCErB7reF9E8C7+
X-Received: by 2002:a05:6870:f202:b0:49e:cbe:9968 with SMTP id
 586e51a60fabf-4a89b867a92mr3003622fac.28.1793194921538; Wed, 28 Oct 2026
 06:42:01 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028132536.375927-1-ziaowang2007@gmail.com> <20261028132536.375927-3-ziaowang2007@gmail.com>
In-Reply-To: <20261028132536.375927-3-ziaowang2007@gmail.com>
From: Jie Feng <hjf3108@gmail.com>
Date: Wed, 28 Oct 2026 21:41:24 +0800
X-Gm-Features: AclHuK_zqJxUnPCaNFg8MbtA5PoBLjeNjF1hMKIEkWPTHAkMWku6PNDEB4ByHCM
Message-ID: <CABOQOSUsZ6C324EXJgVKeshpQ3druMU331n9Gp-bOC18FimQXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: quirks: Ignore Valkyrie USB LCD devices
To: ZiAo Wang <ziaowang2007@gmail.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 21:26, ZiAo Wang <ziaowang2007@gmail.com> wrote:
>
> Valkyrie USB LCD devices (0x345f:0x9132) expose a HID interface
> for vendor-specific display control commands and a separate USB
> interface for bulk framebuffer transfers.
>
> The HID interface is not intended for input and should be managed
> by the dedicated USB display driver instead of the HID subsystem.
>
> Add the device to the HID quirk table with HID_QUIRK_IGNORE to
> prevent the HID driver from binding to it.
>
> Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
> ---
>  drivers/hid/hid-ids.h    | 3 +++
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 91319aa651..d135ea8f06 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1704,4 +1704,7 @@
>  #define USB_VENDOR_ID_HUAWEI                   0x12d1
>  #define USB_DEVICE_ID_HUAWEI_CD30KBD           0x109b
>
> +#define USB_VENDOR_ID_VALKYRIE                 0x345f
> +#define USB_PRODUCT_ID_VALKYRIE_LCD            0x9132
This VID and PID pair is used by all macrosilicon usb display adapters,
so it wouldn't just affect this product.

It also doesn't seem to negatively affect the device and is
useful for debugging, so I wouldn't recommend ignoring it.

>  #endif
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 793db001a6..70ada7320c 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -226,6 +226,7 @@ static const struct hid_device_id hid_quirks[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
>                 HID_QUIRK_ALWAYS_POLL },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALKYRIE, USB_PRODUCT_ID_VALKYRIE_LCD), HID_QUIRK_IGNORE },
>
>         { 0 }
>  };
> --
> 2.56.0
>
