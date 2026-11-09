Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260762;
	b=tbOlwOXekVLUa8P3DkPg/cfKY9eW6jiQ5B5uIhu9t+Qyj3Ln+fsLdWVBanshQ/MfeoId
	 LBDMtgSgoCAqN8S60hH1hWlSu12Gbui1PdeviHkZagkATIdVPFsy57i1G33N88zqAtPL4
	 1Aruk8Mr/w+e1OCsFmCC1uG0kcxt9OesoLJRLglnz7iTrVGht+jxv5Qv3s6Gkc+ztLXVR
	 aaOj0jwzgC1kHmopC/L/HSBtyXBb4YEJTleWRUEl46+/+P3H/USq3p6tA2u8x8vUiOxv9
	 iDTnLWSJT3TSqIZ2ACnpmHUuJvAUweBbzpQcnrJseEGRm0rktnJxn6PpXBsYDUltbtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	b=go+foysxKETqo9jET4saQXvk7uLyVfzMdRxJrCmhYLVUhMW4fG01HhsVQ3OoLovso/vn
	 nxJN+WmBIycSJKqUaFb/pKIhw1dq+IzPwnAwSYEy0AF6iEdu8K+5ldVSi27ncX5E8TXqU
	 QP0FgbepMvJyPkpMDoZiZlw218pPKF/7Qdqb3U1bbYZlvWXrq7sLw5YY0pqXCFytL1r7M
	 Hz9qbaRNK9mYPSs4fWUIZXTXC0ibqSNIIDVsJd7EECWLopOq9y7NbYzq7WeMonTygQ8xh
	 eeCgpe2F5pEqhVitIRe/glPcjZxsApd52iMTZMtBdQxKgIoFUTl2TRAHM3YTr5xILxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254C606A333
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9254C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490c1d337d8so966213f8f.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=LaZ0qPv5+whTFQHjIA7oYo021SUS2QeXnWN8ii9Y4im7Ue68o46nz2xh/hHMwIUfQ/
         ICad5fyoXePYl6/8nNVhZk6UxBKiDwJbHcHq6QklDSJskt7Ox2MaUqpcgklbAASOb1WD
         7U13gt1MK2zXHTSuMFiAfjmE40I4QhfpTIR2Mc6nMOBQW6Dg/mqe6U/h69Hyf/QnrKae
         CyKIviPRPYc2tnG0IM8qOylYYY2PKnrUJzf833wY0ZcFYDbyZdAS7ekVESO+FaUUNtdA
         WzN6sPDUCv7pE3hPSGmxzNcqgZM1jmpktE+mpPCXGo9ukB9qCsiBySNit7DIM51G+Ivt
         K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=hkHoLOu6dpTM4g0RWaQVz8Tij9OZmJaAXP11E9F6FzGk6az17UgVuUo1AgxVaNf4Ew
         h2ulrRhuDDxagrk6B6spNN4PZ4/05lnapfiJAslBKl+nrt6jmA81Q68lvGJVmNXhmO1m
         2DnXSzPJXzWia4wXVjMOpEsom8M5o2ZjdhWH5nUfnixpnugi+iMe1x9NH6QN+d6KxBXF
         syUu8Vuo01AI4mZrM2+AJY1DieC9TBjEAXHieZDP9LJcjEfL+XU9dd9qAHwHEM8oCUlL
         8nNcZ+6AMEcoFZkJETGW3FnvQYGadiicdTVRZ1UlONO2dl/eF7Zz+KpoGBUfMOMq/POm
         FI1Q==
X-Forwarded-Encrypted: i=1; AL+hErGTYeiLJm34cGy5d09Nx8ISNKRlojzNCBMPTEJOFxdU6pZRepkEJJ0Y/sd8aEs/U1IzFLkaZccosOBpIg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+RqJ2Lda+Xa8O4AjPTWKudAGQ7LdLyY9bDN5XmQHTIj3E7k5f/
	Yzqq2s3Sbh8d1QDxCZE06TXL05sOOUz5QXcl2/1Upt5t+R7EkBsgo+5F
X-Gm-Gg: AYBFou0iYWu5bXd3UMOItW3DT5By36HQcleMazQquCofSuCWIEvpyKy700OUP3++pyK
	wXeEx9E4so8oIAWjMDFR5dGfCClm0tcLaQp78hQic8yZnGexa/iJlKgWIjWvoa+D2n3Na/R17fJ
	6I0e6c6UI5/ob5BguXi5QHJPDg9Tdu2VawLRqSiLQ3yEbumEUOgS8SAlMzDxkwIpUg7MHzBehCf
	l4rELhECMEKu4bujcel3HTQGwsc0iVJJlnUV3CZiEcpZKT7ACLTk4x1McZCqxZVzKNS7VPRVSfc
	rixLUvN7/C4b16cuEUkWQasSgEvZH4MNasNfQPN1be0meBfaYLm2hnQZFbRKcdwrD3BI9lpZ2Iy
	dzSdsVOdOWBHVv0OXv9gGLG7DOrEgHkPUlcfaBwYrLi9Oq/sLyvP7AUVpKjXnVy+3GSyM1OQV1m
	PvHm+zpi5Q8jAkD4+o0yv+nYuBNLt6PLxoYYmGIQnUv4NSqsQVLiQr66mk4JC2brhJuYC4xPnkT
	+LeImvQx6Jh2CdlT/F0xrJR+USTkBcnaH6VH8J8+8CbJkHzwNBHWHW5aTzlPdkKavy1N6zX7pNZ
	8Zc2Ja90dWxkol2EG7UmCoN31fRlhqDpaF38SIyDZG9Gshem/AA2Oq0zATxgZwqDSg==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
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

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 

