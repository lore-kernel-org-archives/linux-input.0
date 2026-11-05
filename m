Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873624;
	b=X9Ao+/Cy86qFxCfrz6eVnD5UdzREPyTHhEBCp1jlUl0Ac/XpDeNINyfQfuyDNkBKutmw
	 eG1WZYnErHsHbUtBE/r4M054ZLPOHkFB0AHyfd+axcMw1AYOYmphiGS/JbrgtoHy5/pp9
	 624O6pNK4vPl0v2BDMMGAwnv8bLCsBRhS70cQl+Df5DTYe0neu6RUQzWr589yudr/wZNs
	 DoSRUv6SCztwd6ItrmDL4ZxyFZ9FoF/xARxeANuwphpzDxL79Bik5oBaxsPW+jKjV5YEw
	 ykyBYthjAcGcE+fXwenmqtyizh8eRyGfdKrBXbs1R9K8U1tvWC0/Q8mVc3sH5dyezDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873624;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=0D3ubOlpJD4Yyv2M77cmI08cULh9lipDgKECg2lKj2YeUz3ZAtZfKhVxGwrmENA2bFC8
	 HCcP/QHAYYeL3wBYKxydF3oRK51r8s5kNvuqo9aKG8HwPFLGgRJ5oZmVpbHReyefp9C/B
	 TV8nfALmgrKM78d6mYR8qDOld4TWL16WcHbE2/zaa/RdahnQ/OJFNrb4dqbusOKasF/U0
	 sMPgS+S/yUuuyd9rKyoNi+6t1tUt5O4o0ky4JCWWPeKjJGeLktTa4zmV8euLYMwWW0nci
	 TcR/NkJ3x57D7qu3ED6ABl9EO/X4RVTF4jKcK9/DvL0wFFaH3ImpC8s2VGLRsOXIgcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB79606A328
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB79606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e503815adso152271485a.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873623; x=1794478423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=Q/OyuXhqsvmVWfkOArk2ucHCf0sjlW8IN/m7A4/ktgecCkMY8t9bYmO/+ASkvIvsAy
         er+sYIauTAiziDvO1kKpyOAOnP1DdDvxxlhBxK1tc/Eanpjiu6SDLz+YTs4zcvdKCCac
         XkZF9ZFgtxgHETYoPOF1m5xQq/i3vrXCsoGccWtIqMjKi1i5pCXYEnj8cJOlt12i59f6
         +d1XpkedJ9pDO8ehPDbB+rJvEsmn/OD47Fb5R2hhVn7q0Yam4W0qQyyU1HBDpQPGjwU+
         TNBoMTeXZn4JmuS2oV5Bp3ieaSGeO5QsatITkrZUfuJWQ7ZlKRbog25eSmwueJJ8TNeh
         YZgA==
X-Forwarded-Encrypted: i=1; AKwUvByhUy0S6Q/C9AC0A4IhODnK3kVCRhh5Fg9VQVbq/DZeDftkkqN03/p+yKmM+wN9ohdvDe8+hufG3ZDtzg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/MXtJa2owCgOB29q6qa4eWB787UKTrcqMRvVioRsnhPv7MFrz4
	i57JzBRZPdgZ3yEbtqCExDoDZX/9iqCXox7HOZt93xIapD/ki9RwGPNYsx2MmQ8RMrw=
X-Gm-Gg: AYBFou2AAl/WXYpP71u4IixqWE4OKvyW2CeFZT45HwmGgH43C7Lc6wJKm5KqDsWEShY
	ly53BWEsVPesu0dgVWWVyigkMiNf8yZcQhtjVphUc9NqXkJLUsr7Wh493hYx7aiFv7ruxvt8WiP
	w8JyelkAQNep5+g/5Om9qf9kxuLyV+zaQw1P2t60Og5fUhKn9HD45uAtLLqGNHD+wEQU+xqkVFc
	3hNcJ9bQ2kdDVsIMcliJr2YrtWgZtYPnakS8tGX43FzkX3EvdVzsuJ4JRu/8y86ORcaEbwjAqtL
	1tQpzw6pkVa4qWCFawy9WAn6r1JtkQxs1FzKx+TxWa61wAH2+AkhHwbfOtDDglJcBynYDQsepS5
	1b+oddInLePTFpeuF77zCSnsBU4dPkiVBNWyM/cTHcLeEISj4l+lNTIDPQWGxZnKN0WaaMQ4V9Q
	Rp9Oy3wvFfcLN2G3w/pGyC5s6S50BSFGlZGMxa8o2FFp1lY08TqRB/418xbZDM1zm2Lj3XsUO1J
	72u3Qa8nGombohzX5Fl9AP2XuWiYxOrsosnquch0nqFsHXkCSl89SWsXnT1pSOW/cl5gqp6XYmf
	5qAbU3XF9e5YU8yg5QzkuBrycGPJCuiHEsaBwR5jw8+Syczw0c186b2/wM+ay/sNlz4aDw==
X-Received: by 2002:a05:620a:1a27:b0:944:192:85ef with SMTP id af79cd13be357-9442171b0aamr3473450785a.22.1793873622957;
        Thu, 05 Nov 2026 02:13:42 -0800 (PST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dad29a5sm43762766d6.3.2026.11.05.02.13.42
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:13:42 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5363316fa0cso18965741cf.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 02:13:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwMHtRclJ0xKO6K0Yfed4EXup6A3c7wNHgq3c4xNAxOAe0hTIr31LjJoydE1p+3Gtl2tOaAdleLB8i1PQ==@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
