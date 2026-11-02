Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642810;
	b=tdkP96dmPhPyZ6gcr4Bu2DW4sougDOhvEdXhuLl5ktcDDoCxsblOtlYh7Q/N5VzZTZJ9
	 L85HGaOgAKI+5bWPayW4EQv/gCKYzfOdnTIwYiioUluVWQ6IwU21jbyVjcZdJiqjefb0g
	 zOCsJq2Ssg+7seCt/9PJf+er0m+oJI8mBt+ASvsP90D++WJErY6vh2tZNWVkiHNFcfWyP
	 phCzxqONu1u0V5rvVzxtvVkSvA10DGaRVFb8jCRzFUlRbyfgwtMIinCG0ecUeRbbCqhVf
	 N2jK/X79yx6lWrrW4y6+h03kGGDoqISCMkMt4hX+B9/T3mvYy01JYzE8IEnQETgV+cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=kS8+XH4Tp3hhyxIsZ2VYtwczugSCnQv11qW2KmuaDoarlsuoizKv1BzMZW8b5OKv8saQ
	 Ha8uJDIYDpRX3I4Ve/hqVX08ZiiA6/1U8AUrwwipehRQ0jbRSZ4K42b4vAmhl0H9LFhLO
	 KPgsilgEEMpusDxn0DodnRTbPJhJtslPWFJ+IlfX0ZaIlQgzpU0ChYGI4aLL+LoywuNUs
	 jCE99LeFjzvcKNnrjnisRb+jhQhqLdZCa+xQ4yuBVawQTazUEUD+0LVQnD9fCdNHhJSS8
	 8nGLowPKNQJz5n9wztwPHr0MV1DxdxC7bj84oWiJ//L+mmWZ+NNLrlVhVI1ma8UEJfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HZc1M++a;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF37606A32D
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 18:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF37606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HZc1M++a
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4fea434bso3802716e87.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642808; x=1794247608; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=HZc1M++a/JXpCXbFgidKOJGsJ6R0zglzCZq0mqwrd1oQPi9NdHOzCSmhBADUqvYyoo
         xNAKU2S7Hpou8jhuRTkwIDuD8vErZ0KCavAvR5+LJdoVnLu1PEUhLvCAYw5GTukGieCm
         +wMTPfve9cZcWDCEqKsxWCjBMyfojEYYb5ATE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642808; x=1794247608;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=E8sVDEZke3O6EjqzZnaVH/8Ma5e4OwzHtipodS87CBAw3TGkrdMk63jonovQSid0qT
         y4Ce4fjOs4jRtznvBeVzNMjK0+SyERC6I/67KXHpDy3z5hUM13grYW6FFI7xD+XSciE3
         ibZow6pg+hKplxzp01WLKhCvsYMGXHsT5ifHThZegYStYVbg2zTtkyVIgcYbDhH126eP
         x7nPxC9pdaNX8Yq8MsSOWkG/OVA7BOpMvN+SggFFbLJObNW+hSRYdxEHGp+MJUEd30Bv
         uUGhZobQ93K5N5lzPq+vmaNj88DJ+/p0uxrowkNS/BFxlfqgWKNmalEdVc54haHV1DHq
         WNNw==
X-Forwarded-Encrypted: i=1; AKwUvBwqG5cnJkIphIYutBkA51yzHigKi4SqfAeVB1pZ3vYOpJEWLqyt8ItAlDRMHU3KCD5SsDjlsaJsFUbI5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OJqyDiBT7aJQs8ZPbFcdatHeAk6G3wMQXhAnGjTM34VBqCfpd
	iZZgM/8spkWQjYdzrdI1iZWamKf/CUoHu+R0wQ/86Ykm/bImXDVIMRymHk4jj4xKjTrBzeypWxl
	GQ7DhGulBnw==
X-Gm-Gg: AYBFou308TaB/GjCnMCqZsBRAvzZUIK3XrzCH86u8BTYp+3pMi7D1V9H6h87Vs4OjKy
	WvbbrXhLfvcAdW5Cpdl86aeJZpHqujnyMs9QdR3NUVAEKuvBgkQq0yC2mkwL3sf0L7J8KFWy0ii
	nlBUD4BEyXLJfXn4TnEHSSqBh8isAHA36BtW9J1f8wlXCj/UQbmdfMx3rfqNfz5QuID4OoIWd+8
	oCigQKqM1+nIdjDE2GMQvBi63iRb6L7bCWk1zVe6WUczsd/COz/swBMM1D9EO8RZjDiswQF5Bnu
	gHjF7KeT/Y0DmwQeTan41xLE9Tv2AUJab4GhQgIoPF/x4qFxNr5Evxw88dj+vEWYEs/JseDIpKB
	g2yMBtNb3p5LWhl4Hd254sS+fEHZqrm9e+62UFdFuIdJtRrcqHWgAt+Av0vAT3grxVjd7hLLA4+
	vx9W9nuSAczbk0cWu+l51B80xbj5QTGqiTYlvmeVGlLjyl/vycBMVVuDl8HEnB/pABORivdVMj/
	MU1FIl3VSbfMJgQ+xuwjUvcfsKkq/rniKgev54fjk42tRdxe6Kwxx3xZ6l4Dobe8pqT9dsWGR5a
	PnW23YDGTAJlm7DRDovBi0ADqdfJAUwQa0AYzKxDBXz7zTDFGDh8TVvd7wlpB0t7tePa4rfTHkV
	gVxDYDmNANOJae+SN68S0of4rcwg=
X-Received: by 2002:a05:6512:33c8:b0:5bf:ca51:e2a6 with SMTP id 2adb3069b0e04-5bfd12290b3mr4008353e87.40.1793642807700;
        Mon, 02 Nov 2026 10:06:47 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acd5c41bd5sm959781fa.28.2026.11.02.10.06.47
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:06:47 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so35856981fa.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 10:06:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy3NrHT1tnMqVj8AQEpLONVd8jmkKVNmWjasdP6Xz9/8sCeUoP4VY8IVNBfJShtDLoB2fTScN8f5NE1mw==@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
