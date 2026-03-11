Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4C314D07
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235465; cv=none; b=EMRKQOESkxfPRhLDCh9boeTre67kP2H6P5Q68tLio22gnjUTp2uB7ODdSQ+DtXeQB/1PYMKw9p5TdhZ6HW+j3dFC9vXLHOhapRQnb4Mf42+CLXlOhrIfky5pdS8yDzl1v+YLdUrliqo9f7TxXDcbdeu2uboEKCPqtxlOdJTJdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235465; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7m7sqP8RpGcMEWBTUAJ7kiDifphoSHHzhYKQZ4n2HRIjHf6925sb4+w3xgcETMGKmFuBGKwkgPeSHOuvkk2bMfF+H+h2I7rZtN3LIrMPI9d+GD7NTRmB5moXKNcFT8vtF/jE8utiitzSmC2eok5sluZaH/x5hY9oIJx5ODe414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2424732e0c.1
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 06:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235463; x=1773840263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=cWmygRjznJ5vqPgsLmVnU9NhopE5a2m6dHT6p0mY16roefHLWnGq4VnNNmPsxazeVC
         rsSGmEw416mOyi98brLARSodQOR+udDOnEPZ5wsfegBCXerCb1fNv6aAlAo4IzT7FUkX
         SYsTmev6Btjr3B76FFAsI6ia3jFgVB2gejaxvKALRDgXjtbTiLoBYEf2jLu8F5gW63xz
         1gXInxypy3rPwVgfvCVhaRL5javwCGfG8lhk1NRC9sRoFE+bi8EaIes2KkeWJwB1Vggh
         Ou4wPi68E3/ttHXKl7WzRh7rUdHQKTLAF1gVXkguEhuoJi2KhzOrLNxT7q8c76uTv19k
         Zy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFm0Ma7h2uGAB6wow07X21fTTrQUqUz1/gJCCCcZhDNIjAfdS+3cz65KgGAN+uP9b5vHwWUt08UFdePA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQZRycwxFX+dh0qhcXcETf8XVzLHRyEMlfNuu8HNRQ3bey0sS
	+4l4MAWpns85sN2fhHz+5ftb0+OkiyXKmn4sJdS0ueM9GC8Mi74CZwZfmtgd0aU4Lno=
X-Gm-Gg: ATEYQzwqdAgwV7oqxWdQi181BS3zDiSqi71DqYeIGm4r2MM00n7pdoqhsh2fRtDiZ50
	NKohUBvB8gzFPubO3RVGM5Het8TC5DXGe2BAMeT559AlhlY33IwEizwP4X+zH72b02B2W08MZt3
	27u6TslxBrdxKIYt5h+pcVLnii2C6kFv2elebx8m141Jeh+0oxNT+ekyNaPr63T6szNFzGP910s
	Et948vivbsFgmsj9Y8neEE1/78YNTBiOD5afh7LFoO3Ak50Y0oNhJf+dnImZzPRA9Ry9aJb8hJf
	gKrxqI1rABUSInzLjPbBLks99jRfBtCGS24DefgulB03ddoMkheAn1L04YXeRsNA/3OwM+sCFBz
	U8WVBK8UG5SMoT93rEhkfG2BP7hQCqPJZ/GCMO8L7ZLwnaPBRS+4C17sL1u+h/Tcp/w0luOGvIO
	eEG2PvEhKQngfVtnDf0SBvAlypDnKyYywxamZgSSgZYxaVCyKbFvdJDCNxBbZv
X-Received: by 2002:a05:6122:82a7:b0:56b:3736:a6e6 with SMTP id 71dfb90a1353d-56b4754e90emr872378e0c.14.1773235462672;
        Wed, 11 Mar 2026 06:24:22 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecff69249sm542111241.12.2026.03.11.06.24.21
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:24:22 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94de88e52e5so8501045241.0
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 06:24:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYhelvdOUBTC4uvXzkKHmItMqkxtnf1o3HQvittoRjcbwCSEKfoQcLo5RNgdD9/u+EwPx056HWHP0XHw==@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
