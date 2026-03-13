Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAA1F1518
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391321; cv=none; b=Y/zdEtFF/wdwZAOXOqEFqvnbkjiKZIPf/AVYGBOvqG3yZ9LIjC7YuxpCaz94GAQldMVV2FJnUOvGAO+LrgXuIDT7Z4HX6SbNgW3bDhYcsqHrbRLlGO4U3VS6CdYysmaQ9GXeO3CyJqp3NYkiDOAtYNRRh/GgJy3g+bKhUsDeuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391321; c=relaxed/simple;
	bh=Ua52PBrMRguUB1TFGkRs7ufN3Wn+UHTtA/Ozw/l0cQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpF9Yr9bqG/jC8ZI89rM6b51a1hcCB6rqHX9UVaeVHPJ/yJJkkmBB9xxVreZVsr3sx2yjFOJ2aDUbShSQ8WPOeWZlaMDLN6ZKg5HhfyPxOSBPtUdSk6seSiorFwAC/1mNxX8CJsZ3SKjKWaQErq/dj2+yh0mtQm2FM+UOIIrwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56b18b520e3so1569884e0c.1
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773391319; x=1773996119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aDo7j94ftgy77ygvSOcZoX2nYRGeP4vCbL31PwDsek=;
        b=bnvv/S9YY0m9dmxDXr4aploW/07mwGmXUz2i4+SeovilosOGSGiaVYzcKKbdxPLwQj
         ZBrxPmhyGLSUYDJSS9jBsLdCqZuccsN3yBJIjKUGA5+GRD6fpY0Yt71R7BrPqJ9Lf9Py
         dmE+b/Aj7dKAeYjX3me3XlXu0KWvmOUERVjCdMlcNw+Dv9s3urILUiESLBwM7rfg5FSl
         fqC1Z88hwkh9QWpTmYVVz9VBhSsDQJwdASCSASll9NxjbvlrDRy5gaTB+aWuVUGqn3vA
         7yXOPvlrVzPRrcxHdKrwG63CnmroYwWELlfZlZaBsxCfWjl1tuK9Az3C6U6wlnupz0uV
         2u4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmGCLdRNie37XJO+UGifXmGkVGHFtJJkecfYfXGJeVp0Z+nlvn++csHEn9BEVVDrpk8qTQRB2e+zJ7Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIa8gmbepjUJovoSxKO2TtRv5AVn1OVPThZL9Z563RLIe23+/
	CWRuZF4wlnW1fvc9ddZ8Tax40/Q6DDaCxhdFYvBecAU28p5L28qMGOQb75njM5JWiS8=
X-Gm-Gg: ATEYQzxMacHpa48H/hXDaLKSodqq5G/kfRJmrg+6LsMSBA+Gnaf7zs67vRhFbgnlc+j
	NSrdKX2w7NtIPLB9TLM33Z9641RP62hijZEP6J0wcDIrBKZIEYwykSegq+GZ4nif31LOAwuILou
	j3/TM26UBFqwmCnatN2O+jWeCh69MoRznrgDA2vsnbZHFlBlWLNo0p2UCq8XNYZGIg3YZUEmp+v
	Os1T+KPXBeoRfRcrGllfzunWjfmIUtvAHEa5HbLZkRQ1N0D12EXbQcz1FOx2cWC9eynp/TQf5Vf
	kwb1QB1UuFqODet5YwnouXQrBkMs527+hI0gZ6OwQXy7d+vTLTqoO5JOJS1xCZrq98fxlpm5U8u
	PlxwfvTzVvrghErnjuC6YSxMcZiTzV08Wa/fyaanaNmV5ivmRRP3fDrDgLDuyUsREHvo+UtcThF
	jIWCPqSA8mv/Cf1LhGd/XZ5U3WwL5uQ9m3mpSmk8w5lRhi0c0PkNf1MBIkiyUY
X-Received: by 2002:a05:6122:d28:b0:54a:a3b1:db63 with SMTP id 71dfb90a1353d-56b615be567mr1293962e0c.6.1773391318988;
        Fri, 13 Mar 2026 01:41:58 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b6bb4191fsm4329e0c.1.2026.03.13.01.41.57
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 01:41:58 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so1693555241.0
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 01:41:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBSlNXl5Noe9dwys/MPXi9gHc5ncNPJIrTJs+IoqucK0bXwVoBzd6r7XN6Er2RS4uIwOKZw8TB3myBPw==@vger.kernel.org
X-Received: by 2002:a05:6102:94d:b0:600:3b3e:681a with SMTP id
 ada2fe7eead31-601f49df949mr2684902137.14.1773391317301; Fri, 13 Mar 2026
 01:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309000319.74880-1-phucduc.bui@gmail.com> <20260309000319.74880-3-phucduc.bui@gmail.com>
In-Reply-To: <20260309000319.74880-3-phucduc.bui@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Mar 2026 09:41:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqiaP=COTkKU_jK6Hdii+YJ5+zXnxFkOOnhLri5NakTw@mail.gmail.com>
X-Gm-Features: AaiRm50dDPHbKiQlKjcHuSZ939JQWLNa2vCYSRXIp8LSqUBGtQD6gyUdpS8tlkg
Message-ID: <CAMuHMdUqiaP=COTkKU_jK6Hdii+YJ5+zXnxFkOOnhLri5NakTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm: dts: renesas: r8a7740-armadillo800eva: Add
 wakeup-source to st1232
To: phucduc.bui@gmail.com
Cc: krzk+dt@kernel.org, krzk@kernel.org, krzysztof.kozlowski@oss.qualcomm.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, 
	hechtb@gmail.com, javier.carrasco@wolfvision.net, jeff@labundy.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, robh@kernel.org, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 01:04, <phucduc.bui@gmail.com> wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Add the wakeup-source property to the ST1232 touchscreen node
> in the device tree so that the touchscreen interrupt can wake
> the system from suspend when the panel is touched.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
