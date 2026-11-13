Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562712;
	b=2/3N3lOu47Rp/ryBYuEL6zR5qbaH29t/bdXRAxSOuALhPr8WjzrRUuJzs3vRxABPJ+WG
	 BAolSiOQhsZwiylV8ShYFTGETuJU20i8CrPaczGJOvl61Cr8WkHk/sPrmVugXuvOq3tBN
	 tfY4z9s9/sXFz/nnziCjmIyOw/fNPlmXBowmCaF20Orq+GY0+Jh+k/3AlFwcnzafS8+uL
	 14PR5IkpxW7xWUICnEfk2KZ+hmDoRA/OrruUPwmVFZvM6+rSWCCFXfaCBefeCZPy0B2bf
	 yI14ynBjU+4qYXOKKH0TrbytbS5uy8ufjRGEAU2JyLiRb5zt1ehneBbVHCMCOvaNJKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
	b=BjJ3C098W2yCwEv3zJIWb0l+Fx+M+uB1U4hRlUxsivBg1K+sW+kxavpJiHr4loCbTyLC
	 D9STeh4Dj+BgzN6bbYsHChq9JhbxnHT4ETQf7NaUwyswLjePYyO52Vuqrtm9m/zXLzp6o
	 GEhZWOh9dPWmw+/d2fdLfXz8FpJehvc3PFFCCqfk9PEBPjzdB+DSk8DL7Wg12XrMjj2V5
	 shWfpRYrk1G3PUkks9UrLhIlgbK3YQnb5IpxN8q2xlhYN3bE3XtASmrD0Y7PEYdNlZlr0
	 tDXz5xZM4/HlT+uGMOhxO101WEpJql7UFlameA2Z6RiDN3FXGxrlXxEVt8KviSOOOiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avpyrTvi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F966606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F966606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avpyrTvi
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b308fca7c3so5939817b3.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562710; cv=none;
        d=google.com; s=arc-20260327;
        b=GoqHL4BfzYplMusGaaDzEg2KCjI9xOBGZ1jiHuMf9TwLxB0i0qK3N4uDfXCmDg2guH
         XmBX2sfpQ0Kg7x9wFi4Gq9fejeah4wlXDvNmwt0000Mw1EBuaBW/Bob9YP7sFxqdzGmY
         sfgAwWuQwTSLfXOTUl9BSMBoKy0aiPUZ0MPbqsgPCTelv3oDFCf2OmqBKXLBl/EGcRqs
         jl3wa2UvItayojDIvR8KFbBu3/wVy63hgbjpKQ8EzvZ1E/G5dVCoDv/80rWZZ290xOvE
         bFpuWjiegO9Tp7l0rTVcqAubYR1B5cbSWgImqNpZBCj7/UOQCIsxhGr1QL0p+8Il9cNv
         fghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        fh=zm5O+JMld3rrt6YO3BESPlMWQzsuVc3BH1Z0zfBKsoo=;
        b=EOnZ9/2cDzk/wqYGh0CaabsDoqSDHsCN8OBTiPTyxZwqRSwsEQ5N/eD+60F/dJO2+1
         OnfajuOD5WNI0DqRPFd/X22ZWaMANTkRJpAOabe8kx7L5/cVx0A1VLwZG+c/IFXac9nG
         bGSgIc66UXFhnGZkUon4YTVFiP0DKUCBxfrCLs+HBv2zpk00GjWGR1DywoHBuMHkrT3/
         MQj9TeuyBaGDRz5Cq9fb3nsQHWHBVzBS7A7ZfYgo4vuUT5SAlxEl0H2+1kQdng6yLRNK
         axHyVTYIotso7KI1BVYL9bCZWR+SwdYgZ15IwdTF3EuhqrbVOVbGhj7p4OHCe0qgqfPd
         Z3Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562710; x=1795167510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        b=avpyrTvi4oK5W3E4mvGN2d3McV1cvJMinrQQk9ZcQAlCjlH0BfUksq4dhRDqRitzIn
         wB1FCrOOPRqI3Rn7xXhQW11ZOgRa0Gjd3ExI03bogX9cwH4iCYOu+/BPwkahcbRAN/6d
         NTWuIeW0NbkghW7vkpnUfx6CYRzzIdDWsleLny2760Xsq3YhS+u2DOnmdoP/25yfBihU
         MoEk9e4jmII8V2TVVwx69pIsY3XcR4b+NoqzJYVmYPvRLQfAKzg5EDTrtsEhwoCi6gD7
         FBguBY9bMbd0GGBhb/nRJOYo2PHYSuKAe3F68zv8Q22pCiKCQSjZdXTq5q6sWNrn0mYM
         6wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562710; x=1795167510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwaSOUD1+F3Uh3wDhst/F9A1M+bA9w5kaeCRuz3dMQ0=;
        b=EHIL0+8aLIocjzzE+ovWGSmbZD+VWzQKsB5Nz6LgTprcPHVIgc2EOEOmLJ6jEfH8iq
         +vi6Gf2czXqQbNLV98d4Hu4O2y4PQLlhXrQYQAViIR76Kiu85lev68S3Ci+Noc1pMvL/
         9tQhVqSSPwIiIPLWOzoFNb4mmP2d1FVXfC0mj8UZ4nxDaFQS3HYj4T9xUQT/wG5Vzq4q
         1nqN7t6rXL4Rp2vukJUSJa2tak51cuq+zOxZS9Eh7eLopSQRHWVjXz8PDwDEdCeY4vK+
         +Ol7mZZjg/Rlb7mPbANEwEubmiJEu4bO8Qr5aiTPtadVWRxQ2Pz/cFmswlm41Tf6tSNu
         /YRA==
X-Forwarded-Encrypted: i=1; AL+hErHqWBBsqSo7wBGanUhzmlpe2Jl/PdoD90jDoOOCMAgZTrwzcuMKO7frp1+G50oJdpiYhUF+AG1rqiz7DQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8r7dO4F+Zb4uXIR5XfbTp1G/2WLLrnMgLYop6/qmfWYJ72AKRs
	fVkP7wvvCa0kqduObf5quytu63aNTZVmBnFwvw8712vYQtT988NUOdLsVJPR2cHKDzb1LlrXfXT
	A7zS9VTLrngTkV5MsGdWq5Ikjl0n/L2M=
X-Gm-Gg: AYBFou16Ob9dLomP5ILlkCOa7nJgPFxt1juV32D+F9mmWWtxUvjo/e9feRranb96lUU
	JhM5sE8SXHKHpV2XYuFIFBYkZz2dWqBVCmHLyuuZ7bn4ZBRpI9+vn0vls7azVGfNJe6x0KURTmu
	bmNbqpf/sIt90/gqnUgSwvO1pf0iyiFY/ye0dYqEU7ObtDjAvtXhiSqvk5pdrw68JSfb5tyQWSo
	62lxnIc6xepghmbb4HRf76OVYyZKyCo9eZueB/VNRgxfkdHOrAQCyDxW5ILyyBtp/QRm3C2STKO
	LHq+PGLIl9mEyz21yZiPj4Z4tt8P8ABAPd98SzVVIKlql9ERDwPvRr2wGXhUbaymFN+yWRM4RF+
	8xmTSHwc3wrrW44c18HhFHk9X4ednTtA3uG8NrC3nQruDMUCxgphDC0EqGZO5dTgvH0BOUOSNw1
	F0o27uDA2E+A6Jjh+Npk9gDkjSVs3HNJH6xy5vbnuDanjb3FvCSPT40miRFB0ymIrjUkfOhxDHk
	NtNwL9pYqz5F9g0huAf0uVuA5FjmcQ+q2GzB4msEqYwRCB4obuOH4PPlQWD9Q==
X-Received: by 2002:a05:690c:c4e5:b0:8ab:4989:bc9d with SMTP id
 00721157ae682-8b4aa3126d2mr14797977b3.65.1794562710293; Fri, 13 Nov 2026
 01:38:30 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:37:53 +0200
X-Gm-Features: AclHuK_djmP9MqgezxklWmxc9D08cGWxuo_8XnZ2UDBve8INb7OAHhKwKVITLVk
Message-ID: <CAHp75VeWV39isCSpSxsuzw07iXf7rBfdYeSn=eJsBM-oWui01Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Request the threaded interrupt with IRQF_NO_AUTOEN so that the interrupt
> line remains disabled after probe until the input device is opened by
> user space. Explicitly initialize the stopped flag to true before
> requesting the interrupt and drop the immediate tsc2007_stop() call.

I believe this also closes a window of possible IRQ storms or floods.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
