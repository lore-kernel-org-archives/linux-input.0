Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872945;
	b=rlN1O+JQtrHdeXBpm/c8vQNzJSNPhvSr8CS7MMU5xiqPCoXPnVrOiE6RskUFGVCeQaF3
	 vJk3NAnzm+ORlYyNHlnEVPrSipzDc+cIAwwrY+pHwGzcaumJ29yDX6Ypnu5H2dlt3gyVU
	 A6yjzwrVlb3zZa35H7t+AullPGMYBbVTjct/uffFNd6e88BO8mQyTCSLJIqTKQpnVrevq
	 XPtxV9Y36LKGMlRGk/X45jRPXzb0LW45E8Z1l0haHOkZWTrjlI1B1mLagGNLopN1sohv2
	 ZYG26dNC0xtA+vGwKqFzoG7W+qVA4Nm38bVYWHJjKjz5yOoLH4+brPQdADVfgfjxr0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872945;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
	b=ljCBvM+13UwciKRyRTiUBi/tokjh6GLCiGlIk2hOEXsOC10V4mszF0vL8H0nmRGiesOY
	 DS2IdcHCtRAMFAMT0l67ArVQ8peU/zcenultkqvaESEyAi6hEdtzggR000UjLJbgCcgGv
	 V4Mr9bApK9sICU0PCDiv1myVU7zNDBp4/pDl0+HooqKSefR2A1G66ygmAgVZDWTNBvBwb
	 ZWoBkN9YbkUb0lYm09UcCF7I487nkXJ93A9uaNyfTBP9xLyJTjNrUJeds9ezl/VkUcyBH
	 hbNO3p3J88y9ooZTksIeKK1l50pkniEFvr+h32v9w+gS9RSjBieowPtnOikUSOb7tlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F6606A328
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 10:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3F6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b19e291cc6so1477344eaf.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872944; x=1794477744;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
        b=wwRMFbBDQhrFZ91LKZHP+25TLikDDRbbR7+kHkDKIqchlY0mtLBBws49YubUedtfNC
         2DNZ0tmxNfCNso6WFwn242xAGZGN3KKGXPmCL2LbGvtljRuoOwfLcdfnp8iFXXmT7wQ9
         rvTDa8Xt9Ol/BGgRzIkrPU+Fn25rLtreu+lk9Hr0bxlz6iuTsbfksJjK2IfQMTDviZ7E
         IxssoaXbnqc0l91Hcxt0EO3WutSrFzQ6YFN0rCCRMutFcLCsO5GnZIZZJf/PbEBc35ev
         DQIJ5An2dL5basGEOETv2K9La4XpfqyUKtm142aoWMDCKC7lDNQVUFEf8v1tn+mjtXTC
         4TPQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1PcInX87+aiUe8iyoJIrYfoBdZIYzcym5C19pO6LFwNR4pGtE2po57Q1HKDEjHyhI566cwnDxsxJYFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/FoAX50vJIgWkwuAjCXM96zUhNhWHjy4yeNjpS/pfBtuTeeIhH
	sQZ8F30IcdBzxm/o4gDxHolUw9vN1OR15N8trjUCo6rW4bIZwQ83ohYuUwc6FZN+EMo=
X-Gm-Gg: AYBFou1t7piXptNkX4d2uh5gQYANnOoCdDaw4SA2n8C9CLF5zVtFUq/cGyquBGTsrZn
	f8tZDLECnb6d0wJRXI2HWGvoQn7cXmU4JUo5EKu9zFn4ZEmnGq5pCPAknjLSAs5Dw7wcX7DPVHL
	wiOF0nI7NH/cBQIKdO3sw4VzZp6wTpQoRhUg5YHDnM2AIZDa66PwUO2flveuzoRiVAHgixjjHot
	CKm/zrsp+6bEYBIdViGQ7xoc+gjlXZlGWaYgi2Qw1LRQSGfN8l88gSRSnV9XdcNjqtJ45waiIf7
	6/pmyLSXLkZsnbAAuNmRQSswrC8eGJC/9AeskQXU3jyC0rGvGCmxQdOrRTIBkyYEd+Kl1vAddeO
	HClKxuY04TbT6YVatymG0oqNxZ8cGV6p84pCs7tlASy/oJKw8tgMLCV2GFa+K4s/5PDdFvMltVT
	ZyNsl59YizMcdHd6hjKK0VHdHXHua1whyJl6sMKDFUznwJRi6lDGXw2b99mcfPk0aI6b5sgbEdZ
	IxXg4UzPtrs+DxF+1J1ZaAlTg6BgtZ+JynLy/qRQykskE7yxyOIMNmnZ5VqGD8h79YTwr3YuYid
	Pjrc347xfKSa0s9RsrMR046M0nuTCF4orj7e7ZsmMWB4uRUWFq3kHo4Vb26hu1sNpQ==
X-Received: by 2002:a05:6820:3415:10b0:716:d376:1676 with SMTP id 006d021491bc7-716d3761f49mr739373eaf.87.1793872944108;
        Thu, 05 Nov 2026 02:02:24 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c0cdb22dsm3695859eaf.0.2026.11.05.02.02.23
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:23 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-83bbcfba0ffso1148384a34.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:02:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByA5lwTVAiBTEhAXincSViz2cA43L677v5UcrDywZeh1lnKCDolxhIEHJ9eqNVNtKOwQGXcO94h1EA7tg==@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr8218716137.13.1793872596997; Thu, 05 Nov 2026
 01:56:36 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-cleanup-v2-0-1e6687e226b1@kernel.org> <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
In-Reply-To: <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:56:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
X-Gm-Features: AclHuK_YSG69l_UQ8CXymziWm2hhXR-Ce9gvdG6ZGXmuBEE26IV_RBgt33sxH_I
Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/6] proc: drop the _buf suffix from the new methods
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Wed, 4 Nov 2026 at 22:16, Christian Brauner <brauner@kernel.org> wrote:
> The _buf suffix told them apart from ->proc_write(), ->proc_read() and
> ->proc_ioctl(), which copied to and from userspace themselves. Those
> are gone now. So drop the suffix. ->proc_write(), ->proc_read() and
> ->proc_ioctl() are the methods that work on procfs' buffers from now
> on, which is what kernfs calls its read and write as well.
>
> Done with sed. The flags and helpers in fs/proc that go with them are
> renamed to match.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

>  arch/m68k/kernel/bootinfo_proc.c                   |  2 +-
>  drivers/zorro/proc.c                               |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k/zorro

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
