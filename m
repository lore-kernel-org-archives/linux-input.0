Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872843;
	b=nbCnRmvrBVwHwoZ2hwnW3ADDIQCFuj9wlRcT17pPHhnFPm9jnD3BBykJjUYURiFCPBJ+
	 nlKKeSUH/DmNU3bsqXfJjYimh9fdA2/4RUEx44XW6TGcO2zdUEIUpHj571omxHqvCcFWB
	 Y99CL9mcctAcmaLtDLaffSRTlk2Q3oDGCeH9mjq6EOQTCCGjUHL8FzVPIDxPXtPozM8Ik
	 dhriXgl1XSCCq6fSeNlhVqM9hx9xVi3nSvzj52rHH4q7Du2wL3i0nvtzMhFz+tlhfxbkd
	 WKxGBRf7tc/WMkLYacKZqtkR8196gT9qnG8/h44Q3NpjrbdBmoczxOBC/3HpSRhDZCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872843;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=IMKrtyQbyIDfwVcbLIqaKonBWdndgeErJ8euFCcullLpMcc3DuJpu8f7BiSJfphWDVAY
	 UmC1M2DVNaK6WNXZRAOS1ULICMGug6DhTajLIe6mEjtMmzaNWGZatq4a+QGLrJNR0MfoH
	 XGAfr14yWjA7gXQjeRpYJX7u6jUL3G7Iy6Boj04NzRD8OZ/j3Y9IaKOqCGOLcspI8X5MX
	 QJrrt78VB9e5ARScwV4u5PQZFd8oQW/J0KEMRW8Fg2y96f5I043JN4hixY1qfowpvJOzs
	 XmS+cGxb93qOyDaXihmMixHQEYDPOnzq7e9rQbKO6qeORGatm82l9UWUxWGLOSWDCbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8395606A333
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 10:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8395606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c1f548f87so26523916d6.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872841; x=1794477641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=XqpfWGFaTnr0RsHhUkJVW7g4tmMjiH0IUVetXA3BPa1KaAa0UL/h6TtoX7qJAooEn2
         RE7l/rieSbPtBcFAap3aUQsTE+QIDYG3N1EAsrY/f10sajE/A7OOR8H0YKpRPQqyVte7
         9kAmi9F4MP7W5tm2LRuPMLrsjoU8TyK6B9jNISe455id2SzZH/Zo9AGZIgHMnPEnrZhS
         dnFGnUc1+EQpYP6/8WRSoAmDbISDqoZSHBeAqHB26PTAj1SJ+r8ZRDG7Bt7CgKu2GzX+
         I1MyBkgGeCJf1Eapu/15B7k3ojNH3UtGj/P9PcINR2V17zeU6VwJEyrHup0L2fDCWc6/
         zQMg==
X-Forwarded-Encrypted: i=1; AKwUvBxhfswrn4RJThyzZYEWd/XmAjULejln9lorEjYakS03it5iQB5sYJOkGe/qPBqtG/wFK+0cBE9GdrDizQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vOGVq7tI29L1K/uCX5QUMS9xyqWp6zaeDzanR3eCKSRS2pITi
	1DKy/d8lcPxUczNbb8fq2eEw7X7Xqt3I+vGjsBGwcSHQBLWtTUn9xFOZC5/ByirYqOA=
X-Gm-Gg: AYBFou231lpAmMeNc5nrT2EzXdgLoId41c8qGdA1DkljJC3SN8e/0Xg2oOF790rJpTm
	gELe4WbP3aNFmlVq8ydJC6RgSW0pTgu6/FvoQ3USkpaQHmG4N9Z987I6VGK6UIFx2DVhaXbl2VE
	YPldsztMdedVKJY1xdWxMdRRalF9tVKuHG7Eu/RpKupRkrX9lmSFDQ/7Nb857t1wEOOD47dQ8dB
	8mV9h7JqKsciIMnzwxQ7iTkiKKaGZwg6tpsQvR7Ba6o8PDMRwa07yg5ABJws3LuIPxV1dMEUsXO
	GJ2usv8Alis1c8u3+eMhysCfm42uaBhEc8rw/jAq0SKorwyIpzABeK/Xk4M1B8xhNOIhAMZXw9E
	mtVBTEe2FKEWgBchGP48ZFVa+MuceB+sC6M2zi+/OoAGcrfk84XD2tAeHlcCQoAIFJszJKdeeC+
	SniVDc0X12WuIBwhXeruT8tjdOSzXTNyBWI4KbnvkmAhE+ppnMx0MU+HMxbfJ+hLQ9HP7ElX01+
	AjmlRvp7fip939NmIUGEP/i8o3GOJPIkEPFFQx3r/Hh3DgppS8BxXDw0Mx/aXltbRmVSAwpH+lA
	/n8qurYH9DQRUH4XV8lwFDlGEjGyCxJob0HmY65aO9K9lnMmDmomDnOMo35/rqyakR8=
X-Received: by 2002:a05:6214:e88:b0:91e:938c:1615 with SMTP id 6a1803df08f44-91e938c1b02mr37769236d6.40.1793872841397;
        Thu, 05 Nov 2026 02:00:41 -0800 (PST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb3aadsm43195736d6.8.2026.11.05.02.00.39
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:39 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c6ce60697so22208276d6.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:00:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByXq5miYJAwMiPoxzKPHcS5wfjDt2OMwDePace318fICrrpgCI2KM9CLVEFydd6eTD3bjGIg/N38V/8Zw==@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
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
