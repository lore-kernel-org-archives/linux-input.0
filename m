Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822729;
	b=DG0wdgxEP0i3aVCC18QSZj3/uP1cOjIkHcwV8nz9+ZpOk9RhcCYRILlQoQHsgbJTIVKi
	 zg4wKwUNWO1YzpKKa97ZnKU2o67ItvF9c1rAtnckTkd9kBNtisCf9+pmlug217j2+HSdZ
	 L0wtWkWGaXJw9Pywws3GD07JhdwI+qKBhA9D7ztCA11sSzqFs+cooysvnYWRSJqH7zqdq
	 alLj/AEl/TX3dmjuY+DPb1u0sb2cC+BY/5VQdeDCd4x773xlzPjb8SCoL3oTSiPjr2JuF
	 acI95zzoErusvLp7BylT9eo/XXFmGKH9ATzTQjW/RJog/D7rKVRIO/VL3fQyp2afoFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=IV1n1kHUwIzNKwTDiWr6x79T90b7ZEoFzdduTZAWTZsS78WKZ7CKiKshtkZ1xw3f7NRM
	 +F4yW8XdWn+Mvr8I6WJJYsyCxSh26lVyz0lwrwJfnS4vZu2C2DS3ZDfTCaqhSH/gpJ2m+
	 R9ZIwE4gG1PdpHIvkQMaz/1ymp2Ef6TCT1P9QeHDze44P2gN0ZzKAcW3SEQy9qobJNaMB
	 DDVZP+cWVYsC4b7URc6W25yBRJvWD/BHF5E9EB1Nj7htur2uFJTCehI8SwM8GqRodHqnS
	 Pevc74y+oaQx9TSPPIaM6J00NM/s4NNliRu6VabrqHa2ybc3jTChCYG27IfLozGTQiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fI2nmlcI;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EE606EEAB
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 20:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C7EE606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fI2nmlcI
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4550d8ab15so175926066b.2
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793822727; x=1794427527; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=fI2nmlcItpwZxqRsmDWssHJaMT2IN8dLg7E1xDQbx0Et/5dAwJ3lC+28bQvSn3TcBy
         jCCz6aP+hY985kmEWKQ8J3n3DZJgb7Mf7tqsXWxEtttRySDwTo9j3SEkofmGPUukuzUB
         aTxGLiQfrDGmJiexVo8c15QHheFgr9P51oFII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822727; x=1794427527;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=ris7o/lLZ/EU9EPnwIXElD2uezkHwmq2DBGs5gMLqQJ99QUuWBoZ13LUGLGRuraeZa
         VJVt91zxzQ3XTCsQhg234534ZIvYpnLJ23UW09d4CSCme48Lqj8DFT9jkjZ2cjfy/xWW
         JI024A93NZeuaeH++IK2hBJz8HVJF/1xv8uagShQWs7FqpoqsCDPW89j7PFyx/RqQkgD
         aMse/bpmZtFflVxNFud56doBJ7w9J8SjcXhST1nC1zFbrL+QFur4bW9Ywfyd4EToiIDz
         jalMzvqy/Zo22OzCZUseT8lmOyW6nvEdI/ApmPON+3FQ8RNjWy/xKs65bITlEObH+mrI
         nU1A==
X-Forwarded-Encrypted: i=1; AKwUvBzhm3yuu1wneia1u4uxxO1q8Y+rtqxCH3pi7DE/XC8AH2bVlgfy2rsggTLIiE1F2DLFs6xwoT/ciCTCZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/FqkABF3YSwKP4SNYuYuZgAdelDFVXuWpaDuJQcP/Hq6NxgnQR
	mgZppaLiQzmlCoSawTaAr+sr+JzybU52NV3uojEkFWdRWVu/me/1UW08fu8nUYzssNPU6VISTpQ
	HfxDo6XtMcw==
X-Gm-Gg: AYBFou3QifAUI2k+vs4f4V/2eJznJJ4NliNOebvz5sXK97wcB/bRMe+ew22iSxtR1Fm
	GRXTImERmEvQ1b0j8A+9gxFf4RaFuh/uUn9X8di2finbRJL8oI+UlKmRz85fALsOsddtsCNVY4y
	sxzg866PpVr44wyusDUH0o8KyGli243AB4oLGMrUM8ydPHwd06Xiwidx//WFsQ7OcvLAx1FMG3f
	7YAjqSLqMtbL+PkqiYxZoupdqJEgF4AIYwP6ieGVn8Ls6ILBBwMi7PN5ZLqG4ym1x5dWAD01LWm
	lWTTcdSKm0QkfdYE+t7pD/OxAbY1c2xxQ7G/NOiIAe9ULYNgf8tu7vfnWWqvlnhfQJtC8iOSVoZ
	l26uiCWNrHdLkd9yG63XCEIqEUXgvCWZsXG9XEPdpih2/8anGoXyT7tukJ+Vics5kJSVi9kmZnK
	8qHWnkOMhDGA//iauKbJKHwWGfmNpupVHJmY3u7jvH6CsMisdsnirmRAIC/ewhcI3ObBDUP2M+3
	oB/xB/ba92NYf0vKw9Lk9glhwkIT9kIJLMY/N7TxlY+ljbmoXY2kQA3/+Gh55mf/weZdt2/TY5g
	2UlnQGe/SilqG5fMaUYN90mMfkz1q4o9rmDpuEDjntiHog6QKX8Rf5vQM1Emi5fNHaqTVK541jQ
	d0w==
X-Received: by 2002:a17:907:940f:b0:c25:afb6:2d91 with SMTP id a640c23a62f3a-c4ca795fa03mr1525220966b.2.1793822726712;
        Wed, 04 Nov 2026 12:05:26 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e4a48f8sm103691666b.79.2026.11.04.12.05.25
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:05:25 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c445c95d553so164001266b.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 12:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw5QibDL1hwCK64PbSLhNoJM8IO7IPEiivYvNJw5cy4w/qrJL4u5mPKPadu4BLj9gpWMQMpZex7psXs0A==@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
