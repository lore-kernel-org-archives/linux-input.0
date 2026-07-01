Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F23491C4
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916376; cv=pass; b=tcNsFsHFVfJXhkZRe6tDeyW0ww6TVi/LjhKQ5quSvH7JVh/lB/ap3NflNlsPsbkr2Z4AiZgR4eEGeLIsuJUwo51dlDQ9PKVPrlvG4w5bq2qAEdlf22b1qD+L3vu4L35sHx5oLzzf3lWTb0qR2bzvZUWeSOYsgi60Z106mPcdtt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916376; c=relaxed/simple;
	bh=sZ+JoBpUWCF0i/dfiNw2PzLfB8Xqm/+jouOkAHa0NR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8W/fHHfUTCcvI2Khd3W26uv/Eu5r4WpZvdM3BVzf7tMUd8Ku7YBtrvuk/yYElQrU0iPWt8r0rI95EQvvgk4HuENcq2SYpFndYArFIMGuVCyRrDp1wHVIUVVVDGXld4/vTijd/xXDCbi5PT+0oYbt1ufNFfEtjsWoQ3uY3E+Ip4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm4srtnb; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm4srtnb"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66493875766so910506d50.0
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916374; cv=none;
        d=google.com; s=arc-20260327;
        b=IzgnbUvlS39yWSZRZ1SaN69r0PNekWG1d+I7S6REf45BJwFp/wtHEMPK881yoiVnAo
         SuvEdX4qDlYZ9hDtby/2WYAgO4wb7qEOyoIEHBQV4Gtla9/RR3bJbMJxrEHQxX+S+m85
         GJvmwUErcobqb/P00o9FdD2+qMHuLXm2C3BlAIPPdWVVm11MWNg9pHWbud+bXlJYL5rH
         oUe4FdzTNWcrWtyjQkFhznc0ixvFvO13bTlR5MBZ+OwpLhxsJMHG7MBI3FzQCK0UYJZt
         UDQcN9EU53j7UX25fxNCCm3XjWGgH+8ZSjGZE+nsoH2tJzTpHX2llA8SIaW3DWycqBL2
         EbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        fh=LzA+Ni8Z3fC3z1SHsIsMFzs+x/W7XC+as/qlkmKAn/w=;
        b=EY1/ubLO9daWfR24IyzTZN25pGEy4Rr4AEa0sz0/+BJUPJ2P15lf+9mNJk3CIGti/9
         6nxv4oBxVU85kpZL8Gg1a8LoGhl1Np5RuqxIZnMT5ihKFi946JUFUZOIadwQ/jfcpvRh
         cKyHBkPBwvaB0zBLK+GAAmAWra1dnQfTJ6WKzZmzb2CzSiz6IrET+QWc+/AaacL5kQeK
         S4avnTtZCR8W7HvZB49GB2huKDQho0nRUw3kyF6EYSFniaIgqaVaa+FTcrQTwFkcISjH
         GIKzWj7Ce1I6D6nwpMAVaxu9N5c7Q7hAnEn1KS+l9xebPq6fm/OyoEoPER+NFGCQrQHd
         /0ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916374; x=1783521174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        b=Bm4srtnbXfxE08SMcdbDuXZbfjIn44GxLF+Kz6nSzEvVIRh4iW8SHYds4De8tHXlck
         DmmulFqBuElueQnM3orb6L6+Q3AUgov0KmW2edGUJoax8/Vw1K5cSOeUbLEXxnDcD91x
         DxjsD7njYS2beekHon5d4L1ObOE6dCJFXHy5Zi2KtV7FDcXDBoya4U1Z/RqnkkHMWPqE
         FJaNMdFJuP6r/VW7qo3et9CAxXZymhu0XEjdVVkJd7YZfAajN1Rws9gPrwBIEXnpgxq6
         B8GGeuDC4jJeRTLd07Gqlg4LNkQ/bbuI3OKX0bqVlegEQWgGt/s6QPovWgXKUcP8cOEp
         YP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916374; x=1783521174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/PMJfwXDmjutwz2ZqUdHqOQ1qGXDhEDRkGoA21ZDRuY=;
        b=HmmFJqm5L0LBuCoF/y2Y4zGuf9zPdeW5f2kIwY6/qw5n4dkUIeQSHBLWE83QO8aGPo
         rjVSMT9i+DkY7e382JNJlv8GyMa0h8JUVKCPOOCOXekZhKT8mXJAWRGSESqyXgTEGb2U
         tEX209+gR67eyOYmtaIg6zLD33iO3BGbFUao3p71d6xF5dSt2AodCLb5o4IMsZ5X3dYW
         pMg2+sXoKgX/OfHT9+nAMD10p638ctQquJVTiPflc6DPyI+UvkieLp5SnZSGAAsA314m
         E5a5OJz6qJSCtF/byoRXB6CR1vOjaExLV2gqS6KJxerYN2nlwZDNrYST7LVZ4VpK+nc2
         qqvA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+FQSUTpHc5IPElwA9H/b3E4oK5ZiVRcoGey6uB1wzetPXPdFn7bxeUD1Ke/l8NOjiuc3tWCbbJHF72A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxArqiCDn+BR3oYpOjn7jMRjdpbHeuLWbg3xx0i/cE5Ub0vgSss
	3w55tboAmaoqR7SIYvTrB5rn7lYJOj0MCnzL/sHEv9gVPWdQ6tWpCht2iQWnpR78bv8Anw0YWHZ
	iuCO2E9L/S0MdVTiKH6UUqiV3JCfO+5k=
X-Gm-Gg: AfdE7cksP1JlzaugqORladcxzOSJa50KHotNNKEQDTO6YrFgyzJFiqWcsCs1JEWcs2n
	zuf7v4waMoluKQer8SwgH5NtohfygeBM4y0ldbs8bk1rvqs0ppWdYaHP7GnrGX79iLfZ4kx4xjT
	jQb8eK71MpubIP0CKUf71JSaoXW/rXYu3xLA3JvnT2d13BfD0v/3vANO0r01XOWJ2/nwN5Sbyd8
	ZMyLiHzbMuLd6ohsoYn2wp1b6IIMwHzR0LTsFPknBDyhy2NRcDtgH/YA8KUOIw36E8Rrxv5Kezx
	eUq31qqtSEV3i72WSHsu6pXxj3fiO77ng25nB3j9nSGKgdg7ZM8oygHMKUuPBw==
X-Received: by 2002:a05:690e:bce:b0:660:a41d:d175 with SMTP id
 956f58d0204a3-66521b945c8mr1896345d50.55.1782916373989; Wed, 01 Jul 2026
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com> <05d39c4d-8405-4fe7-a798-c8a9c92699ed@cyberchaos.dev>
In-Reply-To: <05d39c4d-8405-4fe7-a798-c8a9c92699ed@cyberchaos.dev>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:32:42 +1000
X-Gm-Features: AVVi8Cf357Gij5feihuaNZJkJ4WRqS0nufoZDV_3Bt4D6iI9pAVwxlHJbwtr7a8
Message-ID: <CANpmGNs3s2yLw05jkpZ9mscQNZ9JvfbqEgyW8V=cMD29aU8c2A@mail.gmail.com>
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yureka,

Thank you for the review and the feedback.

On Tue, Jun 30, 2026 at 11:21=E2=80=AFPM Yureka Lilian <yureka@cyberchaos.d=
ev> wrote:
[...]
> > +     strscpy(hid->uniq, dchid->serial, sizeof(hid->uniq));
> If the keyboard appeared before stm, dchip->serial might be uninitialized=
.
Yes, true, thank you for picking this up!
[...]
> > +     /*
> > +      * Prefer to enable STM first, since it provides device IDs. Some
> > +      * firmware versions do not expose STM, so let the keyboard start
> > +      * without it.
> > +      */
> > +     if (iface->dchid->id_ready || !strcmp(iface->name, "stm") ||
> > +         !strcmp(iface->name, "keyboard"))
>
> I specifically asked for a mechanism to let the keyboard probe even on
> devices which do not expose/have stm. Thanks for adding that!
> However, I think this might need some more sophisticated mechanism to
> decide whether the stm is still going to appear after the keyboard, or
> not at all. I'm not sure if there is a way to tell this at this point,
> or we need to add a timeout for the stm to appearing, which needs to
> expire before we create the other interfaces with fake serials.
>
I do not think there is a way to tell at this point, unfortunately.

I think the best way to resolve this would be to implement a delayed work
item that is scheduled during probe. If STM appears and initalises before
the timer (I'm not sure how long it should be right now, I will prototype a=
nd
experiment) we cancel the delayed work, get the real serial, and spin up
the keyboard. If the timeout expires without seeing the STM interface, we
assume the platform does not have one, mark id_ready as true, and
proceed to init the keyboard.

I will work on this and experiment to see if it's the best solution or
if there's
any others as well as to find the ideal timeout, and submit as part of v2.
[...]

Thanks again,
Michael
