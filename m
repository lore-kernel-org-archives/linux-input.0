Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872893;
	b=tQHLO+a2dNcqe/Lj/ustgoSaVICoGPAvEQHcTbzwt+U69BUhnBR06xNArAdJQuyZm20z
	 KhfUSUoSuG0VjW71To0TrPy9yUunYXLSfbWPNBm/xPenrcWDXBxd5HMFOMJCvB+RXeksN
	 OvJELEXTW8bKIVDgRj3fWd1T6uKgquxw+mNLoeB0H403Yn6uX6QoYK+RHK5GSEPGQ2Ic3
	 1igRci9sdtmRT556fuyi4kaqJTRkXj355yNPFH56jDDtSgfxfSz5xvkppzWqVnRKIKPRd
	 hUhVp7thn3o8Eq8SjBEoNyhffO6FjZEtBeKBErb7TzEdi+PZHxM6/IKTzhTRvmu/2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872893;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=KPjpYOcWt5GxXivulSG/p3mw8hRPawgHOVsYJC3fs/QgbWi6ZbAm2iwkk2WeAgI1U4bJ
	 Hlcy2XwWZRDXTx6cUcOFfTG3PbjUle9gmwUL+swuUExKjwq8OzjqS4Au3R3Hc1PYtBUDl
	 dFPrD0xdGd8U+lesQewqHYkitglnnuJUKhrIVqmUeGx26EF8tZxy1q3XzN+xthGB+TaAU
	 2kUzlt4Is/v+6/CBlLQtTsUskgjmw2kjib8AGR7kv1HP7XCku/DRo9hNJvVFZAzJy+IJl
	 sciqVQVfzhSUC5NWvi1iJnkkFdrIlAJIv798/3b8hla5HunKdf9G6gyeZKsd7hscvRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69E606A31B
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 10:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F69E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364042eecfso22724531cf.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872893; x=1794477693;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=DRjw8qe4CEMYQfbFHIjf/e+za77uRPXjSEZEbZtUqKHRte48HNtbGQBzL6HAOGni8H
         o6pxGXPbQCPNPg3MB1hJy0/5F/tYkBk/gD1Xb8fzTPRWJylH0ijkfpd/QO1K/aqHKuXX
         Uyt4YDNcJ6Ux4tFp/9TKFsPYrkzmAWfA2jez/WjrccdqGE0ZpuMb2AeEysn/sQoidxu0
         jZ96GQmhcK/rgLKuvzQblHPLyEIJENiI8x6rFaWGzXj2hFaI1IopjAn2LtjeYwY9zhYw
         HsJISMm1ikmonYSU8udn3WC2tgdM95aKsUupPzSi02KlRaYQ+CwtssJAUrJam18YmOUR
         B+xw==
X-Forwarded-Encrypted: i=1; AKwUvBwNTxTgXtUr7An49auHIfZoueMGfcbAYTYWmSR35QnKfhgrner64JUByLvOYEYT2nWTR6fzecmqTVpMbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8t3H3xT7Mk/KIuwW3wvcMBqLljRzseBc2ukbkbFnJeU/TmEYuU
	9bYz1goSckl+uQISRpo+RPa0zgnJEJIVFNxSDkxphn5Bx6a7Xa0x1IIRZeuSp1kTZpo=
X-Gm-Gg: AYBFou1daQ+I0AS9/pnjGQzZsXZVUJ9XJlHi7JEcy1EXbwc6lYHtIXMDDajDBlr/l3R
	vx2si9S/k1WEm8aY5DvUJC8oI8RX8+rv5cAtCc5xCmSftv0hP8HscdCuGdDWxYMf7cB/0m3xMxQ
	bvuilE7dES10ibLZGjQ92rxHspJ+uDwnkfBRLYioU6m0KrZOh2NCQO+c7bM8mrlTM9iJiEXh/O+
	L4j4XTahDDuLvjcroV2ySKFT7kkNSVvMZ9Mz48tOcWTdtMUTtEbKvv5RBnXEOHzHyTE/X0Ht8Fc
	2QWItky/rdj9FNpI53bhXUfoTqUCrlglVfol/XFuwwB+mXV3DRrfft3rpUdQbwDICkTo37UUT9J
	uUsqLbRod69laTHyMFehAZWJuJ9Ia2skBJhU07YzEfuFFBsjfbBqS1tQHpD/PnmVtN2BALRrvWD
	dxo0pq11kMwwF2ZhLS4ovPDqrO0Jtyyr8+nuZFuGBsqELam4Met/cvhjZ8GCrcFxRoGvWVnolgT
	NA8ljOYcukfCF83JZy2abG+Fl910lDAfqRLHjUNlAQBoO1cHLIKjqoJ15tVL6bX141rKNzbRAbG
	SFJ7j6MsnGLH+/XaPrgw/JBKEoIjFwkCLjdbX959vUOl/3DoG0FVEppYwM7BbW5WYIhdvw==
X-Received: by 2002:a05:622a:1247:b0:533:983b:e53f with SMTP id d75a77b69052e-542b781d936mr283892471cf.59.1793872892549;
        Thu, 05 Nov 2026 02:01:32 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb8c99sm44013756d6.11.2026.11.05.02.01.32
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:32 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f20c3aaa5so168569485a.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:01:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxqZzDkSSuhRPC102XP+sMiBcXVQXR+xaZ1cXu1zpRnrSHQy2sCGCgGSp44MPTbxL/j2K+0G0+7h41qHA==@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
