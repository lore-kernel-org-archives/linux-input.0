Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9036C9C2
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238402; cv=none; b=WC2EtCJKjNc0/U34x6T4pKYD3uNFKJkUMbDJp6iDRmgHiedKjoyyEfTZJ2Co4R7KUrXva3IgEQAybyY03M9ckxn41N/oH/HoslfTS9YqRWrbHGbP7uY7diDYtbEXr88lVyiko36XGlg1E848Y1HkAnC8eok1QeVZdfUayQExgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238402; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/LoULU+nIN2Z29PA79FmpHZUIjq2Q3hjFzeKYkRGBRPw+ehSaDUlVK93h3DDTCBueVAa/60DTGxD7nuBWcd9E3OPnIYB+0NV6IDTL62ZmKzlcMs7iHDtwGvYEUDbGjt6iLkqsEM+7U2fOi0uFLEDEXItoUP6qpE+SnJDIFXZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b93698bb57aso170423566b.0
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 07:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238398; x=1773843198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=K8vXl28x6yHf54b3I7sqL3HGqNz72s4weozhH406Ofylr1AddS/W8MbuTusRHj2wQM
         F6laf1lfu3KSZalD6jxYCpswOx7WFR5vY4oL4pAAOomFtOGjbJwNDNq0ohSRehf4gDRi
         R3dFnaXhQitg5oRBJqewlNPaKNtIYGTgQGX31ZAnTl/4ZSj7RqSbg27Nh3atPg13Q6P2
         yLNy2R8CifNmjjEh7Ja8vwlM9Ca17PBEmyZFh9Ft7lfSw9Okd+vW52MBpEUPMUg15y4g
         ckhPLZ909GPuTO3ULLBA+cBuUOyxRN0lVcCOtB3xZa+Shc0OQWCjugxuMXBoJ8Zx7vo/
         0tVg==
X-Forwarded-Encrypted: i=1; AJvYcCXK0YGgnYrW2uhIy+GFS0Nne2SV0q0krJvdFf4Q3W53S/fA/84xu66PPd+wbnwE+ihO8M6lUsktZcKp5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaV6p+vGjBfX9qKtILNZOxmWDrxpv96Y8q4gtZw5TMGDjhmmP
	c4PxgNQJ9uh7CscUeC7DrC3df9OFEP0eXcvedjMoW53a/wgno7tXpx38XwM9FMe6gYXIvg==
X-Gm-Gg: ATEYQzyFdwfDLK7TBIrltFmlmu9/8V7w9jtF2jP1O1pKKUpTuHi8oppiriO3WOBFWuh
	SMMGX2fGGRTqCPghvpQyELV1GKxUryLzXQ4E7brQMJUCL0ie7HfNkQy8GDXIVog65rLqj+Pwwm0
	KRh0+3mBXgcEHILaAI6RzVlRXhBtRgCS4SuwbF46eQk2zG9EZJ/qYhCQJmKfiORoWs/ozwPiRSN
	5KAinF5wuZCahMeoUhuRj+JqIoKIXG2OYudNU2ztziXu3MPuG6akH3u0k2qd+WsTc4yl5wDWDko
	kKo3SC7uPxh9niSgQGrdvx6y0EONXX5+CT9/H6rFVUBPMz9oOl40lAngXt4voyYipsCOJgHh8Sk
	x2gOGQ86j3o2nqZWmXlad5AUQArL/U+yEbfZ9DrTKlwfZoynyYfOS+Y+cAa3LvEFT9DmsKe+tGk
	RGLCJBF8i40ET5zO5/B1og1tPW+C9elN02yeOileQ1SiOFrm4nLvrWD4sqc7ed
X-Received: by 2002:a17:907:3cc2:b0:b96:ddb5:fbe8 with SMTP id a640c23a62f3a-b9711ab5d75mr460410866b.29.1773238397924;
        Wed, 11 Mar 2026 07:13:17 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de092b0sm59014166b.3.2026.03.11.07.13.17
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:17 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so984560a12.1
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 07:13:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr1+fKL8pSujBNVW8ytdd6ql6iz5XrcSCMVgMC2UPhjvA3xYLG/70pYqOCFcTxAdN7CSO1cVw0k8nwBg==@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
