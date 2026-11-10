Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273280;
	b=eg8JPY/LjarLVnwPfL74yjs0KfnMXrLZ0T6EY5DyMqNpnXpCLHvsF7S12GSCTKMl0P4m
	 Wam6y+VDRsilyRq8HgDegSy4GWyZYg13DXrPly4RmE8AIOfmK5UFKp4ZKLUF1HfKwmAwu
	 7w22B7gDPZkKAFMIqW4UYyjSj2l50AP+qqEqMz1VTSZe2csDZX9++P0GcrjyrMB9740nN
	 lSQ5/LVMLnui8QRfwXiR3QpwCADaFPqWKXSd9TMDJAqrjKEuFTuG4r1h3UQqkJ62riGAV
	 PxGN5cg6Y9Sr7/tPx6+XdG5fIvjj4BzSww4s4xNspp6LHhVDG40+ymncD9WYzWcQv7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=dNGhpcomhgOO140dfuHMlJFMh9xdU0t/oiEKSQbCzb5hFfGPdEkefEDTtAvs80VLzKO2
	 2PAJZcLWTtZ/pnSCefTY4mr+I0p8WGyuu1dThVr4pRAMXDmBQDY8wVbl65bjE4dO1xn6t
	 rRMhBfrBYlinTwL1DFw/9cuSJVR1568U04yt4nXog+Wx3LRX31wKPITq2hGvuoTJA2eAh
	 JQWPe5uA6Uuy1e8+t6JWkDVnwxxTxJ6QcT60zbyudbXswmQx4aGAAn9zKPSph1PzGuxXy
	 Tkp4iujiidvu3jKKn8uL05543RJ53aDfSs0scUfh1p+NqT1sNFwP0JMRsmovm6Uzt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=c3HPZ9w3;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248C606A330
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 01:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B248C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=c3HPZ9w3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so11415115e9.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273278; x=1794878078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=c3HPZ9w3X3vdF/+J+vaP+PQYAUd2+9JOKWwj6JMce2A8a3XTTDedjlXPO55cC45zjl
         2hZf2gArAaC7b2VANcAz9siQ8hXOL0yOpee0+28IQ4U11h71kiwdUMjW00TOftz1OChD
         IA4Fb2sqqSoZR8rQ6NvDOj7SKOizFmF/BfqF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273278; x=1794878078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=nE/i7JPN6kusRNtgwbMBPX38MwTIHvlkuBX9tYkcg0D3GwxR9oDhOIFW+iueM1q/sY
         bsUPQKCJ6mdh+9iTTEuG9sEU6+hwZRGaFkpIhSQsl8Xn/UvM8iAwGDnUXeZ1+H+CMsoK
         rVH2vv7691i8HeiUv5d5o0jn3KOyMANxzbvbIuV5FfFcojTm0jFVJFXVGbzDUO6EHEQs
         V59J1YEvofSKKcqMWAMhOzAo3x1PULoDNBoFFJbtwdZ+9BHKk8VBeFzVcfoVeQrVer3l
         TVGoXo2dNk3qxoYeDzbuDs67/LavHOUC3VQ2jun7Pj4A6cNzil5en5NvgwwtAbJAAlTQ
         IYCA==
X-Forwarded-Encrypted: i=1; AL+hErF9QL1IMAth59T294uDOsA2jxtuiLwhQQjzulQS/A3/mAjpIDVv3gYP2Kfm+44o+cc83YgZY23515jPMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z89uaipTboxQITF/mQKvjKHz+maiLnjI2VjItU8qIeXV0m2I7KG
	fQaJOJ2M2cRIW04Y6+DKTC9SAfYOFFYAbB3BdCB1aSOljcoKuw81WrD+u4gE3+Ux9V5dC0nxLsw
	duOOjhVpacg==
X-Gm-Gg: AYBFou0Sp4QltSuSyV5/3ekuynl5mU+3IUCgOl5HSyuwYmmWY47oHGpeH+0ZYBtDb49
	TqYxBLuRLnOh9Cc1Iqy29W4KzJ93qFIz0C8p3IHWF99a1P6xT4EBcizFqL1ZRUPRZOqHhuRxNMV
	oswYxjx/3P/phmA5PmHJmnhixk4s2XZwSEjmHof2UOjB4ydDorKklRab2191S3vKtBnBFV0yJYZ
	Of/XsooA57aQh4uTxtxj2H9GGm9POSg5bKrHvBAeILrarouG9flxr0MK+hahCeKy7Btq1L7mrus
	NQ8EuMUbFayVPoHQt1iRCB66DxmCOW2K7jl/gpoZLNNRuF19K9k8P3oAcPBjTcdjiVkUISDuBdJ
	kvH/RGiOTt+rFB3Rj2x7mNd0kv/+EB3566D5ZLLRx91W1PWLIknBpXxv61Hkg485odaOW/7m5Ax
	hhZXaUz10iYhayM40OhmbKlgc630y0AI6BjXLQe+9XKYN0NetdSnAWN6+dt2PB5sdF/3sfgJoiB
	K4LCy0xTwYX5zYf0tyw4sejWcUioxBvoeb5DtImqEIpabORB8GK4tF7S+AtVAiLvO2w8NioSpj2
	bYu/xH80tMk9ta3XzQvFFeTiTZd2zyCUeaWdam8hQCfpjpmXh7WnL7c4Lmyb/o5jUzdCkErIi3p
	lxw==
X-Received: by 2002:a05:600c:8b88:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4ba0235632cmr13228385e9.32.1794273278198;
        Mon, 09 Nov 2026 17:14:38 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fdac9csm41414005e9.0.2026.11.09.17.14.36
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:14:37 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so2026689a12.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 17:14:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGi9lU2yrmeCYvdUu7X1cjkSxYDkpiB1yy9swxg0xtwBiIjREJqUZ8gqMKGAtqqZmE2m2aMHhS88UnvgA==@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
