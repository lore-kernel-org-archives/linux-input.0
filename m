Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=jKlUvU0We6K6TrTfjK2mmj8UxE8mDngUnjoT6J1nwWHO4yDRMRSe8HtccVrg0uCqcqDJ
	 9o3KNAR7QzJF5b7pCQykhPndG1UuS+W96zanIIkpRP9tfnTWQP9Y2HhstHQQB6lkcBPD0
	 F5bOzH3TNbMvMDhfkJt8BiarfY3GTOG9tezxYY4XQK+EKMlxovHlWBOgzR3juzeQZmLYM
	 3LyDQSQMrht9Dkj3he/qvqgdFuiCQMF8S03fmv+gwuGPr8XoYm/4YFbEUmh1IWsqnj/oF
	 Dh4EFR/cATaBv/a537ze8TjulgTMVdVz/hPfCEJgcL9tVRhAvV7f0dWH4e/hQtBSNNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=eXbEi3kXkPZJlZhJHNCOiaDGfYCV/DwNdQWlu7bT+0wcwPZiAZpKYdPFMFZKKpc5+wNn
	 1HCfKXb2VKYlIFmboCHZ3p/p9FVtEaQnpCcU8JG7By0A/wFyJZe9srAsoqf1Ed6z+wSOo
	 WA5EsLHQlK3f2Q70ARiRmbVaVyhO43jlM73Gl5qYMJlnUr2utRsZzyJ6UreJUuIdJ6is+
	 q8f2RNUnVOtd1YXk02umv8ddQEs4UFfDZK9We4xiAfqgxwzDwTT9R90MGj23TcwLjMi/I
	 iz7yLkztZkZr5tqbNUHLWXluE+DzXa/J88XzFSn6y/mWAJZ61xi/qF7k3Nsq6AtO8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A38606D802
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A38606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791535e9.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=CBjv8VAprwutEv68YPg0iWfZzjRzQjsuX2b2Mb9X2yLaurH/ulxPPB1IU0oTTYC8WJ
         mwA0sMoTcop4SgeNwZM6srfibOo/SPhidiDiMYmfGVA0SvEm/BrqxFQseiBMtHhWIvbo
         4WACSuRq7L7jpKHmND9ql05TZm/VEIjZgz3fY40x9l8opeH9cxza3tq0C4oH0jRDJxp8
         fDPKoi4DT+wvr/SVMeHIQTlh5WbS9V3KbEnZkvhwMxgwzXABNFEOh6mAQ5QIk/F58TpF
         moxxkhe2jz62ip7VPXndmxywwPy2tbBFlg6DTlFI1evXsjVKsPWgWb6j1O1lAMrqsc65
         dfDA==
X-Forwarded-Encrypted: i=1; AL+hErFME2hAsOOLl/A3bo6iRxW19BYb9SwIAtMzrDT+Bs4L8y5wG6kAxcMmwEE6gMgHv1/PIk9Gx6JikGAzew==@vger.kernel.org
X-Gm-Message-State: APuU4Z8F8NGhsMnA+KWXimqnbnONgvQw183ZwBrB4dckkFX+HGZOiD4/
	nit3mImBrTixy8MaqCF8UlPhuHoTXJDehDpPK3MxzlMh4/MNJpoVCxUC
X-Gm-Gg: AYBFou3xmqvylL1aGMJkPUmBwcXtv1yYPtnksCmHyvMYWgLGmPIXvy+XriIp3ldcBS9
	MqEtHEQv9JVj/hikB4Th2LfUWTh3eun2aQq+fHe0Q/h0yC8fwzAiADKOYrQdF0o02G1B8tcOKe9
	PhN5NqpzAsszZ5ykgorWvIrwNsl4fsB1JfQ7ZBF+cOzsaRyRLafzANW5vJNPfnOD3xjyHnTGRN/
	tmQ1lFz2euWe588D1wP8UA8uz73kDfh4z1ZHR0Ogh0TslEnN1QWNp+TVNieMlLlAPUztllFfsYv
	pyTK23Hgl16OKIf2EliMNjC+dmojLONIcTRP4UaVgtGjuSsApP3vkXPweiydjPUNy+TprothEyK
	IlrdMUyErWbs5Jf4WieB7qvFvS+Fpy/nCrd3pBqb6o78IyntAgJm5UHsQ2GZQVb0ZusKVk4TCnl
	4mHrmZIKtplvppYEEm7IoJgho5F1W4Hq+8BzBUaRtTPbHYptTGdOUcK3A4TcW8BZhavJUxZmpEp
	b0c4UehBaDcOcZp8/ICagrNPt3CEzOjybuW8clDtLCXcRxSMYzKJF4R6NPo/0AQxT9Z+KXKUr4E
	N7nr6sS1KKD88LOEo5lUwiVF2nkT0+E3G/m+RDVqdX8Z6d8UCdU2bCCQ8CwKoQKC
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
