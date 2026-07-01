Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C55349CE2
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916626; cv=pass; b=IKJ/9/jZBE9o4MKoZeXnD7HkemDiHXnPmEty46mhB9OPL9O9HzIBHo6sgKUtWLuitaJLPya96c06EpFWmFxhMtoJ6y7Z+Wv/kg4OK2Fgc+ze7NAnAVftLd0zBEzxQ/RuuSbQ6TvUQib6TDQQTVuoVpvSGjbV9hcSctoWgStxu/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916626; c=relaxed/simple;
	bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2wf6Orm2qOyox9kKnfAoALUBhSwbPF6BbsilhDmNvbA3bJq3zXR06COBUsQZvlQ+bqcjZ3WgICW1LX9prrOkukN+d2D4vKgmyFu9BCj400eQAnS0EClwA+nbDjveVLQcCGzhpc4ZKlcqYSr1z9kgOq4gE8BmU2Ri5RYuunHU4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcLIFROv; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcLIFROv"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66493875766so917334d50.0
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 07:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916624; cv=none;
        d=google.com; s=arc-20260327;
        b=UxnuJIvzOBsmnD6Amgor2BtHqKSGFZNBuHsZChEul/6sANUbo9UEzMN5f2cLolxbqT
         NPxspzTBjsvR/7d1R26xMTyxHb6rUIobTYuna/ZTcUdLIED2d8ipu3tfOYtZc0/RNIrH
         vdNTdHdclJjQ2nm0iJ2Gn5z+GB+3v8GYgB0BLkPdnu6iluq98qQHLHqGfuFtU7eoghg8
         MfqYmHrfdJZLM7OBaPv+XZKyVFSrzSDu/uaCH4hXEdDyD7G7W2vv7bnih/xDpKgwXp/B
         inu3ZPEQTc2DmkPkRZrThC72C4od1eSu9SeDowiP3Hzsv/HhfCpDwjnlmsjgF7COb3Bq
         PcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        fh=5R5+W68lpRnSQxiT84Iu14lreXcHxuVw4L+OW+v7xoQ=;
        b=N+XA83Liepyy+TV+lCBj2T+XoXXqEe6VMynshj2zVw6CqSQCdraByls1I+R1dj10e7
         ilGtsMb7IIy05pT2nHbYLNxaGuNOOuwlTi8+Vi3ReI1y/rOHVX4rU3zpzu44x2KSgfK/
         irLsokQNcHH9lpPCzpPPIB6mAIaVPL6DqDj5qe/U6La9Zn0emJb+PSSQIvjhTmMYIrCW
         FubQfA7ezIBbFYZ8WvtYKStseMYb+gJ3/gpQ58HHhazjNxmaekUEfIwHTLoUxmbd9vv/
         MQ7gK6rrv6cv3/x46eDbBraL9tVhu6KltLaXjVEKURtzzDoEqMT1zj7aVgv07tNBWalx
         y+fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916624; x=1783521424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        b=KcLIFROvJOuzpWsxD3ti13L4keeANGdVaWBLTeTr8HcrrPCGnA7hEYXnYHsfmC0UCT
         4qe/nkVaFEoiIftiwmCPHaBqpwxB1zt8++SWv38/OW/OkmDhknmRj6vwiCFDNt6T7XhC
         RwkbTfREvitX+8MgL3YCwQ2GRe92P7XVm5m/cv83JhH1UeU1g33at7fSeDN60z6Arneg
         8GcmQmB/YjmXh4JtNPQ6VBTr+Vl0GC+vLisyr2oPtnrtlZ9xjQJ6RKe27l5RKZkF1GXR
         bCqc7FHJC53wBVdmAIt7xe6GTO9B1prI46HvGBLMxN6B6LfXX1Hm815rTv8wk6Ij/TGs
         sYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916624; x=1783521424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxK3787kwBaK3XoNUtICKMe+9KxBA8wczg+LhmRdR0w=;
        b=AXYcNM7mOjJ3tZCOeg1bNbDEY2B585iqm6p9NURHVcFT6C+xYC5XXeEorlk8PBrVIm
         Sa7nzbXM1XBPA8ZPzB7ipuUK7Ph5B1nZUgTNEWd20bBq37xQQ+vsgcWXs0livxQaY8fG
         x1ULeJk41aGF0djhKJsm1LSKXj3SurzstWF6y/0WCLFeTPQ/FiGKGoQboSNhR4lqrYe/
         zimEhz8kx7g/DRIPliJQVQSfoaTAyaeb+j8AFIoO+wNFwKnx2pPY5p9KbqHCN4HqM27v
         gcq3sgMH3xtC+nSgTNiT93C9J7EkMDHsskkYX7Rd32DbOfoxM4XrP05gi2PcQUJIB7U+
         SNiQ==
X-Forwarded-Encrypted: i=1; AHgh+Roqnq2YpeWVE+I0DoM8Rgd1CV++VUl9xd4OHMX70Trg2+my5Y5ssDvsXYK/LjHHAZ4nKzpiVUHo5UC50A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzzIX8jLj7XzhqI5WO8QM3QZd5vMfS+hLjp3U2SbzYsrbNSBR
	zfxrT0+nmrssaela4hQCGRIameFM3QZjG8jR2rxPmZI9C71JPVcaees6Q+PZKZuMfaWFovD4m1j
	E5aDlurbSXsaL+jOomb+wiiFKdUv0Xcw=
X-Gm-Gg: AfdE7clhS5t3oJBnBN2BUClMz5Jsa67jxOy5+NTudrfij7bjYGdxEzZBDPyK0fjB5kD
	6FdmpL4+C5avKq5QMzpq0iufXTD9YKu5RrVATFCwXwQRycD+ic12vFa88OVXpEsuF3U/GKmfduU
	APi/dI+L+FJfEeKz4wU8CNH/WL85GbrfmOH9Hbc+Dfd8WJbpK+E/Scb7g/WC9CbOOA3oZfRW1p0
	XE8UISMLqVjAZx6YkgV6yVyUJwGcemElT7t36ibYucbmywC6Mbl2EI0sOUCu1WokedOPCEfshe/
	T3Fayjyv5SZ86q8LT5fvjR0iz5h9sG3WyoieZvVrYovQOuKLroTWyc6YrluL8A==
X-Received: by 2002:a05:690e:b8d:b0:664:ae68:33b0 with SMTP id
 956f58d0204a3-66521d75bb2mr1788278d50.81.1782916624248; Wed, 01 Jul 2026
 07:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-4-506d936a1707@gmail.com> <20260630-halves-magnesium-856f9c7d60b2@spud>
In-Reply-To: <20260630-halves-magnesium-856f9c7d60b2@spud>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:36:52 +1000
X-Gm-Features: AVVi8Cc_Z2Ec3ueDKeRbjSSEO7FpMbGiHoLBEK8cPVlZ9DBrXWtcjp1MzslxPtM
Message-ID: <CANpmGNs9PuH52ngbZq6jGHuJkoZ=Jz+PRk8Bq7Rn21g9KsotEQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] dt-bindings: input: apple: Add DockChannel HID transport
To: Conor Dooley <conor@kernel.org>
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

On Wed, Jul 1, 2026 at 3:08=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
[...]
> > +++ b/Documentation/devicetree/bindings/input/apple,dockchannel-hid.yam=
l
>
> Same thing here about the filename. Looks good otherwise, so please
> change that.
> pw-bot: changes-requested
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
Thanks again, will also adjust this name in v2.
