Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872381;
	b=RXVuy65QqoX6rlEkNrGBWHWeqeKJgqpnRgxJuiLthErTZotFXbmb/+yb1h39xztRc5t4
	 fRZgKqcFcP8JVXkl5vQsV8MaOsuq50WJa6lohoAo76gl6n6NRcYqQIbrSW6fk+3X4XoBc
	 PXriA7m8AzsGj3KXFZ21s0vB2YxE8XIqIyZPSu9Z4sY6oPGz1dfci0RuVUNWYHM0VdFO0
	 YDufScXk1bco2zsOgCkOnXjBax3qHh4/+sBRwxwz7YG89+yVKdwWMAoG3UcawVIFBAYI2
	 C/apErF+OrhzOjhT1bQSJX+jT9Tn+pXuSbbZa9/QnEnGTLNvNcLQxCOePkAt10fg0iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872381;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=pa8/REBLkt4aj9/01nHohbOgotVACHhCEpNKjOITC2CiUG/CVZpHeOlHKdT0AcFLAw5Y
	 DJcuvEbMO2ICG5mqYKSOBW+Zv0F7QUfxRs+ySxYi2+hCnK/5VzbiagI9tXTsC03eRMpiH
	 JR+10KzTNcsQvwBAZSGsnPnYsm/B0e553+b4ePc1CerGV/SjYlixfG9T6rJ4h9/E2Eont
	 jiVP+NEeZ2RAWFCZaBihj57d23IGeo1IjQtI6vf1/Ljkh/gFYFR+y7v0EmFNLIlVRojqC
	 xfugnPwZ9Kbs5iMZFnD/8yYjwoFKWSx33ODym2agdelb9ZATPjZepD3HsbJWzYVQGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDE606A32D
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 09:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4BDE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5365f9a04c5so23476261cf.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 01:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872380; x=1794477180;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=G1Pyw6Iy6u6waPP5dzZGuBTjprwj/snfvtL2wJrshVDfSsmtw2l6nriRcfWcaXzKUY
         myApeMHaTPYPBHze8WJJXbryFCDGL7YuTppElSWouWp+ApaXxXADbKwqLda511KmtBlE
         AKp7PJMVHe79OyBLv7uc9wPSSalr+hbHr+BE4RlcWoADRPj/V1//IPbaUe1awXpEQ0iL
         1LmV2sWOUPCP/j7GL/lkC10S/d94h2ZPPeqtPzqNXELvDRasLFv/QZfGfB7jyVpCZFxn
         drF7qaSHGx+3UEGkuu51v1y+XbhThVfCw+i/WhTAFtsJ9jfMMPTLsRC8DGcF4fUfMBqC
         P1zQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlbcNK743Idl5HFG8fQhaODOQbM9D9GXc9zC9jq2DuqIT7E+drRki3YkGRdlbIPQPRGXv2j8uIt2ar1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qdPXZlYq8ZOGq0+4h+Haib+HSoBWf6CVzu/GQvM2HLfHEqFz8
	5VZyX4Ju8YF0vI5qEmWu1nkViuPZWp3ZVh5GryYgO0HTMFjmTM9j+Pj1/vrM/JEjNTs=
X-Gm-Gg: AYBFou3qTv2l/YH5AoWdPfjzauWWgnp4Z24EIcfRAIs7BT8XJ8oJgmD1TlHMvVJdXl/
	RTVKNfviWLrdotluooZTC0DUiaYFXy/dxfSODPaggXm9P+tUtofoNBHzKI3dIQgDpXA1ov6PLy3
	cxddYq03AtuIGQ8kEACLv1XR77gnPnxPvXslyV+OAWvI+GcN03sQgrhmk+Nz7axHjviZ5QbHmGb
	O8JQ2+PBb7UR6eL0Y8odBUd1LFidSILJPmcRdioPOqbB7P8c1qqjR1d64Atb1F+ZPzkQiE1xS5H
	WHp7DuFZGKUoFSocM1WoIQ+2VI63vN5vTQANFjQ7O5YnEM8/gnKBshd6Wht72jzbkKGgCqduQs2
	mDEP2bm4+pSEt2D70fKixFcPnCzO4gj0JQsPgdOitDvRTRJ9EKad8CIvybacfquDJlEfBoQxNPY
	6Nx71BJc9zC7/G+Z1gz/9kRwjhlDc/Df5b9IPAUOzo9WLx4RX0V0DtQ5XpT6VBUa9G4XGu2rz2+
	IiVti9OpihImTD4Z5c8ZAkcRRBFMnrj0GE/qxspDiTKTufmUV503+3Ccj69ua38rD+GtEH8yUHX
	DCLBDM5fI2wqtFQBmzHxcJMyR9bReGN8iAysaZLTJ2ulJoDnbzYagaA/Ic7Lc0otC6WL2w==
X-Received: by 2002:a05:620a:4693:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-9442175e896mr3341066585a.81.1793872379837;
        Thu, 05 Nov 2026 01:52:59 -0800 (PST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48577ebsm422964985a.33.2026.11.05.01.52.59
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:52:59 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533778ab0bdso18450431cf.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 01:52:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBweaWVEO2m0q0WcCFXjr41EXIFTZonBDLBOlt444qcT+k1lKJ/P4/56bOqVzffFATX/TSRiYts4kv/hbQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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
