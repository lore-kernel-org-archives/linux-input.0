Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012B413259
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543394; cv=pass; b=m/AK09BfgpN/dj1o4KZ5iGNKw2NhTYPXZ6Ie023+za/egi0d0eZiFuBOsUdwMb+Yx+hxZUKdsGlV/aiCePwuOBV4y5zKEKUYwhn5CaE5zGvmeD+GuNvnVBc/8DT9+nDxH/8/lqRXQZwVVpmBLd9Nko4ID602CMCx8E1ucSs4Or4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543394; c=relaxed/simple;
	bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW4UtGOHhgEHQGtjF/+ctrMMOHXfgeeEbapPl2Q/JpQJXTre4hes54h7VzR88sMEnqWO1Xi+dKvRHulQWeVepL/5gsFDCtfJHTWPczVDRzDEwl8/nKhGgGqidsKzupgx70Lisgvb7Nn+vuJXnL4nucq5YYDVZldIKro97I0Jp4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU2Iblhk; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU2Iblhk"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bf0170c80f7so614220866b.3
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 10:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543391; cv=none;
        d=google.com; s=arc-20240605;
        b=ID664nQXEWK9CeG+QOQnwcYsGIBAAcJDvfZUzhSGibaVPMF1ezEp9noV9puTfy2z1v
         RclgHgtaOoKevGk5KoMtuptkTc+lkIbMjzkcbPkKy5SXm6lcFo6SI+lVnbCUcM2jcS4f
         Z8Ji36Yb9G6FY2V2ACxkYQL7HM53EP0TJmR3EnIwSfQGclQaBL4B+/7XYJkaD+y1cHzf
         PPUn0nRyjW2hlHCPMb+BudFhv1bXEN48AHqHH+Rme/b315nr7bH0Kka4vsyKjUGuWWkW
         9A9/SoYaLE/V7D85vbw8iIT1lonZwpRHp1Er3x+XIGTiWNeouh9Q181NgRlI2kr3kooO
         jOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        fh=tWB+Nc5WHjDL5lFRq/9okMmZU3/35/zCgs7cg9s6AJ0=;
        b=KUkVAYuTjyqa/7RjIYgyH3GqCYT8BMmnSBybG/tgNF5zntx63YFBfPTMiOvWyF4lFL
         nAou+9LsVDnyKxPM6rsflEFTvOa1MOAon0VGYb0OGuArWEcD15QFYgJWDtcPIcduTley
         eLe8za9XDtRbPG4vVqvfSsAAoCxNEGXDYdnMsTGcUsKMglqKqH4fxy8Hk+Sx0pTxLQNu
         QXFIceruuT3CLCxEuZfkZsITHQygID4b81wUpt2ws9n+rykrnRJKd9YMpeSN5CcjBCBk
         Dcgn0BsbUK11UQcP0iQt1Cc6+JP5HNnVCwmtVcVZbCjxWl6Zzuu33vXoTU8gf+4ahREW
         n+Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543391; x=1782148191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        b=bU2Iblhk9vnsDgxKxhXjiCS2mj7KbveT4augZWlTS6ux58qPS754bw7G+7+uJqKHi6
         94kyHYvMEuQOn17rovkHBYwgLZ8V2jwcTV/FJ8meab5Jbv74cOonR7apCDQj5rlH/KJ0
         /4yVzA8HArrPKtkyyb0ssZSbr1jfVj59ntpAdQV71pDu0KzeibnBqtdwdDVQiwaPnu1M
         Mw5AMag5P2ngaFmhlJrCA7D6lvASB7VtVykTakWfnEx6uOCaDGJMcyogV8FJq+tld6g2
         1dIHFO+Fu+J2UK9OFZ5wsroZG7o440c59fGLL63lcLUc8p9y0sADHiHVsbD2E8QSHUeb
         nHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543391; x=1782148191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr21gZwUWq9jfHVaUeu1Ubez84cqLx99H1U3aLVfnCI=;
        b=HUfUCF0mpExX3o+iOa+xc5anVvijRHcBe2KSxL3KiTXUod+KRUT0TZElEY9qv+Umu8
         I4ASzbNoWFEC4hkhsXvMqZMci4IUV73+oPK8p7KF1yDKbe7yNCuGftC4NzoSwH4tDTP+
         K9veZU9RdXL8yJQdnA3POfVFJRoZZBmYTxp6p3CSiCmaKwPga2Hq8/HlQRC804Fd82nE
         QCmNPaxHZQozJKbJ4waGyWTlKIJRuXHdJXEkFCN9idtl+tTa72T2IACXCJkWpPoTnzy6
         tQrqgH+fWgKoSuadxotwzZrxVde1ofwp6A7ct4zHepPJvauT8CMXMcFS0WLSSNjtez/B
         wBUg==
X-Forwarded-Encrypted: i=1; AFNElJ+ftu4+cdGKgEBxwbwfVcN5/vsNeONyUrrUZXTonM1R2sMbb+AQ9Ej8ItFnTOJCuvBT6g1DCpjODdASDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytHF3MuylXMTihHX3/5LePzgE/xKaBywBHFlqQuGbH867aexhx
	6B+yX6Iqt8mN0dnIMT0nfj7IyD6OG76/L6lGegK0zqMypkNHem8twNDCIZfsbDHJuY08+hsSWCx
	sy5UXQWW6bJxjHAcwQdWDmur4ZIPf1Io=
X-Gm-Gg: Acq92OEZ1QaZeG2oDfFnjev6y/H6LRl1LJr1OU6Idl32/pdda45A35x/h32NlPr4j/0
	FsgOIuuYLu2oaAMjUC0B3BfhhXc1LjkwrWhl5rKCnIqBJXG59lTlknwxDhz8CRCzHgaajLaegl+
	R6YrvPY9bBFmHcixuxMELxIYjO7zMqiMUGNLB7kdYZPt3mhMrvOnqM6Z+W3HItpJH9VgohlVxEb
	82/OYZghFi4CSNqX+i+Hd8c+SP0RPIj6QZcm221/xTqVKX6HOYpUjlkYZqzhc6u3u+QPMK3Dh/4
	qTP+za5Gr4km7UHa
X-Received: by 2002:a17:907:3f8d:b0:bed:2a8b:3e73 with SMTP id
 a640c23a62f3a-bff4cddd831mr594131266b.41.1781543390991; Mon, 15 Jun 2026
 10:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612200717.361018-1-l.scorcia@gmail.com> <20260612200717.361018-2-l.scorcia@gmail.com>
 <20260615-palatable-aerobics-3091229b6ada@spud>
In-Reply-To: <20260615-palatable-aerobics-3091229b6ada@spud>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 15 Jun 2026 19:09:39 +0200
X-Gm-Features: AVVi8CcgapzCFj6cwsB094FQLtSSMmdLrOP26pKMcjV8D9cFGpyiqQvrj10_jjw
Message-ID: <CAORyz2+4EquYcUHEnoq0N_p7vCmDpPONEhVrmAfO1eX_RNMYbQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Conor Dooley <conor@kernel.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
yes, sorry about that, series v6 has been superseded by v7 (I replied
to the thread and marked it as archived in patchwork, please let me
know if I have to do something else to mark it as obsolete).
Sashiko was correct, the regulators node is required for this device.

Sashiko also has suggestions for v7, a few pre existing issues and a
few nits here and there but some are actual improvements. One bit that
caught my eye is the use of the modeset register in the
mt6392_ldo_get_mode function. I have to double check that with the
data sheet and the android kernel sources. Not sure if I can do that
before next week though.

Is there any way I can trigger a Sashiko review before sending patches
to the ML?

Thank you,
Luca
