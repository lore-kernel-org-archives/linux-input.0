Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278014;
	b=b/RebtXCHQYzdSvUwULGwXA89XPiyDnsXKIPkwWgAZQrSqJVmSwS0X664ZuAmI5u7VSu
	 +OH7uQgH4umSnSrxLkblxigCcHjlDaenIbUBOSAItKUvCwBXFoQrKO9XukDtPJIKfxe0z
	 7dcuxmQklt0vqoH1zXwoTPsL5n92DPrSfpL/ttf+874D26uuLwm/HVh44twRufyBsfkXj
	 QRa8uqz3GO59m53ZzPYe8kzZvr0h3uWhN/jlTg1Mgh/uY9w0m2llYtHr+VExdPFSpv5U3
	 F774hCqbDHELOE5g9QO9/B3OvpGMYhjWYhhZTjZCB/+KYLQJQKRlPh/A04rZ+7e1TZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
	b=BUkgliyBUYkXk+QEo9hrmUdrq9i+JMbYUU9hY9+hZ+8wPKGwcW3K18CtD4SB6e8nzwhj
	 bKYe70YwqfFJZDqfD7ea65VdQHLPSmM62MUSkPBPT97SpJ+klvN20BCJ9b9cKS93CnftD
	 /igNgYcRKxvVRpf4Mq6A4L5X36M0ixsOiew3as5uDxqvgiG7eX7CSusV8sj7YyJissbZM
	 mL5ni8DiLbkltNT9ojuGqkGvCzu7otLUIbJF1mCS54RvmGj2uszs6H0UiGmB+8M5CICZ7
	 c/ctFKkDOyNn/GoeQuw3XsycZPuGN9ThoGsZxGKEPSQ84s6hqBq28T40zedj36HlEWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232E606A32A
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0232E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPwTGqod
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1878516a12.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794278012; cv=none;
        d=google.com; s=arc-20260327;
        b=RPFz8Am9MEBf3V93zsJyNSujDZHWELzGiVHBdwPydQ4Tm3m4P+5n+m2qJ7z97Libyu
         nfm3SXG9NcJ4Nm9E8N6R+2Q6OjI60bbkO6K2o2j2Q1wA2JI4D3k2/pcqMjNrKvWvOiUi
         bELvd+gHo5gIbrDPTKRm4YnfYzmrMG13nrlkPNwHfWJ5nDLeKOb8Qa5KnyJZB7qs8PY4
         rnz3Q+T+3OauLq5UKtOoZU6BJTFN6UvlVWZe34neONXG9JpkkeMuvAuO7E2gZ+ythucJ
         gk7L6FpcCuK3FSSve6lUK+p6SdQdXaYDzf37nwmv4x/XYGN1NLdQr9Bc25oHTyMrImCh
         mYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        fh=KIPM9nXJgYjCsNLZ3gNqFIIZ0WDnbRGUWzGeN9fLt+8=;
        b=l6v8cZ6CmHwAL420EtO/DkceCxFvogEHXCwQqbRCAlAOKINCpmCdQE91L2ff4MBng0
         PnKjAZT59GvkcH3gYUVmHKzN8d3edC0UAydSw0bSM6UAR9mi01bIohQ3GbWe6xH8GGG2
         Z3iUEnU4jYF0D8F73dA6IrwdC6WAKBZUr8MDE2/Egz2fsg7v3KEmM8TDM/SLcuS9B0Vq
         8bclixdGMUOGG7W9/6F7o4RWzMzpm4rWW06Dh6U5lpCQv0h482OYRrEVbph3apaUqiF+
         YibALYybITtmpakUq6Yk3m1ir0WylYVXCrvFIJhlpCfy5ee82LF+Y18z+cZK5+GZr+tb
         SFjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278012; x=1794882812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=yPwTGqodd7n8H1mxcfS43lExUvi0jzQJU+ntBIlR4pprDZdl1TVrV7IbOibnNXcuNF
         DfuCSXoUIjxEK/WuoROirOzkOtDBCuOYUf8FTQuhGN/3OSpvmWL9upVt+5OSUY+BA1Md
         EP51Wv7G3gWQ/TjLOxX/nlHk+lT/lByA+C9Y2XOloW3P50RtVZOHu1p6THXe4zxqIZWc
         HtA5gxGAzy6tlbJp2T5twXh+f6WvRnTzeFgFCgRnDBNd8qMU9WETLMADtfnjGT3rP6aR
         8umd9BDxeT55xe3RiTcauiFKWvpIAeV9D8cmRfLcw/X/L8yNYtl1ln9HMc2idk8YD0Yp
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278012; x=1794882812;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir6+0LktXyNV5hGF4yG0Zsi8r3P+hNjzS2NcO8JzLHM=;
        b=Y2ITduNCOf29pnqQDDOmbIJRTRNs+yQtOGAJqaXbfkDRq7iG9RZ93Xr3P4DH1KAJ2p
         ylAmMBE2HNyxcCrBrM5YXjoCHeV+5ZL67szqDI8N/8lOXTXD6p/0OgOkZYGPdkX+UCgV
         mwp1bq4vdFll0aqP7gYxjqPwWN2+OdZ4rSRkNhATFF4E2LWu7ZgEFu2CanOCL5LG6Vem
         lQI1bdfihp/7Rank+H30GAs4EVZEXF3MCW2x2mxAxyCCgpkrRamLZtiR0Vtvuz5xZ/EB
         qtqjz06UFXvc6SY5D1dOeqCl7GXJs2EdOcd91O9PbRGzv+lb1IE6WhcTzAPGN3fvd/MK
         cF7g==
X-Forwarded-Encrypted: i=1; AL+hErEQkTJySG8tHX8F/MmmlzpaW18xlAn7VZ0qHfAmrIBM57KOFTHtLpHolv/p+6+5dfXIhKvHVNkzOEi6PQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IzKQoVEO+zDvu0V7GwIoiFLrnWwrccMG51FfJeS5lEpBVDDij
	zNcbZwStLU9xFUNyDh3rr2bW0pdur6JgrX2pRAj7i1L4Jz6EdKKgLAi0GS/m22qXpmz5/Ut49GH
	qsdDkSfZ6a/l46fvQS0YwQDv4nHspqA==
X-Gm-Gg: AYBFou2Imh4BlEz1WGqU9gUB6V1x9ARCzGcj3vGnavnC+k49fFAwM6RlFR2B1CiV4i2
	nMYkfB7Rd5vn8352jJ6PCfJwHVtGhhUaRgjcks19XixSLUcsSzpNWe6OJ5mBG0LseQRuopmm6of
	ncSlbH2QgjNagqD3616UZze8LhZJuIBA0JPilTpl6bXNSzo587kKxyoApNibOaBiwReQJHkalpO
	o434YsZxgF9md1oRO4YR0rqkG+qJBfyKlJpPQAV+54k4kSqfePnz188RNmuw3mqclAyuQ4RvvOa
	TPQjEr3zKgGQnq2zdEeF+7jGyYbhQYXpHZ/eOTKSegzOaQ1Hwbm6+O53uekvB3Lk9hjc4hKy6CJ
	gF5PxXrGh8t3NDpsdcW8olhgbaD2MYfmuSOWMi4XUlkKw808NDRQt8Jk/vC8NDP8CO0atJjwDyL
	SFVW1h+IfGopmVX8xWpNaP+hV4fRulLLyf9BJwFWV8hRI0FOuHC0ZvYPLIzwKWpT1a
X-Received: by 2002:a17:906:c150:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c50491bd3b6mr89682666b.2.1794278012315; Mon, 09 Nov 2026
 18:33:32 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:33:30 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
In-Reply-To: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Date: Tue, 10 Nov 2026 02:33:30 +0000
X-Gm-Features: AclHuK8--TocW2ifUYfCFyXaag8s9F_8MyrCNuCPPkZVo7e4LGqYlTsfOEWdPSA
Message-ID: <CAGEsz8HEtP7c-JSV=LvhTH9k5uRxq4z+4GgypbE-gmCurghong@mail.gmail.com>
Subject: [PATCH v2 1/2] mfd: core: Reject failed IRQ domain mappings
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

irq_create_mapping() returns zero on failure. Storing that value in a
child IRQ resource lets registration succeed with an invalid IRQ. The
child then fails to probe, and retrying its probe cannot repair the
resource after a transient allocation failure.

Return -ENOMEM through the existing resource cleanup path when mapping
fails, before registering the child. Leave successful mappings owned by
the IRQ domain provider, since other consumers may share them.

Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
No hardware testing.

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16ad4fd26..e00f31402 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -255,6 +255,10 @@ static int mfd_add_device(struct device *parent, int id,
 					cell->resources[r].end);
 				res[r].start = res[r].end = irq_create_mapping(
 					domain, cell->resources[r].start);
+				if (!res[r].start) {
+					ret = -ENOMEM;
+					goto fail_res_conflict;
+				}
 			} else {
 				res[r].start = irq_base +
 					cell->resources[r].start;


On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> Hi Lee and Dmitry,
>
> This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> The provider and consumers are converted together to keep their IRQ
> resources consistent.
>
> Changes since v1:
> - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> - Move IRQ mapping into MFD and update all platform consumers.
> - Reject failed mappings and unwind consumers before removing the domain.
> - Retain polling for release detection; the chip only interrupts on assertion.
> - Drop the previous Reviewed-by tag because the implementation changed
>   substantially.
>
> Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> No hardware testing.
>
> Previous discussion:
> https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
>
> Thanks,
> Myeonghun
