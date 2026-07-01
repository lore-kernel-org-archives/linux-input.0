Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447225A2BB
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914493; cv=pass; b=SwojTYkQJrJI111Sy/84z0icDCYoocyViaw4YBznk7lBDDWHjCtPuFhG1beB6pCAAh2rpHn8sLA44CxyOeWwLMk1yYp+GVEE+bamiD8XFyttJPz+xAuuD39hiCQIwpxHbDkuoC5+nsVS9B8jGli3HRITHe1ni7uac2RKZLFn/9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914493; c=relaxed/simple;
	bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEaQPK0BAi0+8PPGLVMdbetBL2bjMVJV9mHRPS61mCZMr28mSkv7PMpdx0M8Yr/miDfuFPmw191T9NWgPo88NvdH5bPRodd66XNgmKxIwi+wiAa3F9Mwx1/PtFGL1k/zvPjx1wk9fA70JPvZrNyECW+tt3S1OY8zgcxFTIgXKQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExSKeb8j; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExSKeb8j"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6611669cd16so938202d50.0
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 07:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782914491; cv=none;
        d=google.com; s=arc-20260327;
        b=nex0vfDKczZPd/UI5ttcj0x+Sl1uwcBv102yxDslYU1I7P/Htik/X14iCNOzeswDBn
         qoLG9i8GV7CYVDZn/IQeIkYHbnIpX6TrXQnjWQcFDq5Qr/79WAxvcTzA5A9kU5bXKJ5P
         ZlJxXCWbWUcTx3/8mG8za3m94XlfbJ4L708Q1gN+GmB+vJobu2spdfcnik5T02KBSLVY
         GmYjDTxRPxzegX4xGU18Q8TFsUGbpgU5fb/AK0fR+eBLTul5Uup0mIJ7eFMPVHnWlYQg
         Gp9z0eGFCNlNZ7MyC+CADDnHf/8G6EGuAMYSni65yjFGpUabYcM2f2tJPmJ4OJR3J2Yo
         z1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        fh=GgtHVnFkxSURJ+TJ1eoXN1fMlA+M7awlcjWiC6Ozf8o=;
        b=mWdI+P/8ztWLrfRnxis1COc1f97fKL5X7XH/56lrx1HyWGIUfbRi7VjKWqrLtJonZO
         nfI1VXHJT8SSHCwEEt+MgFEFILbB1lP54fCQTWIK9QBztgedpsb8xrNxhVufUjb5GNVd
         QbHhEqfxvA3qOq4dY7GYjgAoouvW6f2m+V/Y0GjDBG5vkZ+Ng8TXPyIr1XiL0f3eU4Wp
         4r7sUBPxcJIc3gJf70hEx4ZjKyNgMxMuWir2xj/Pg5Uqa4E61lsEALwScS7awyF8iSPV
         FD4DuP6V2irlKyK0heiCL0VIa5WxtUc2QoyxsQQQ+gEgMFo3dunYp4XgET2+d2WNseye
         IwBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782914491; x=1783519291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        b=ExSKeb8jnnGY4Cx2tEnwQy84vb0UbEDvK3CJ2L1sjC+bx1DfZ1gw2exY3Qe+G+fvLy
         7sw4EsOk4tpqAj1ZaLye9UItBIaDnqA4ZTfBW8ZAT1yZSfoALWkGNvCIhRXDvfZgqxVD
         QEgvHRH6vbOxON8RLjPq6Y2MBVuME35vDxgrorJxy2QhBi/0hOjvwzoBD26G+pYsxjh3
         QkERTl5sVaGMxLmLiv7KQqY9sbV9P5SWILL8O6fXG3Hm/l6GHvhDGWMvRL6CVBgdDDDU
         HqsKFAcAf0tATFyZmUZ4NCmml8mqXJek+eHf3T7YmsIWk6DUt8p5OyDzaNNnVRMCoT1U
         P5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914491; x=1783519291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        b=Ci4yMvfM4aOnExKOyUaOfScSP8CaWFgCrAoRLvFpmgTLfsyu5jj9K60pQvhQDShsiV
         XHD7glhUY39JUQUiYJsfNNaFDYVFHWqGrMbNeLE2prwb7C91YAmjPANpYRMkN2Z9yaW/
         UJbuzIlxnoK/y7WfoGzxOrjGummcdS/PihUVQ3Igo2ejIKn88t7YgfOOPyycDBgjO1HF
         +THEpgz0UAv+Sma2RF4i3UpzZeMqC+GQ/vjxtCoL3QWiG0YPNA69lfZwW12AebFDAw3C
         6FiBAHWlj05LY4SzkmY995gr2RrJ1gzn3qTOyKbYb08p0JLFsMWFw4raZOq8tC96zm5P
         nqoA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnbs+kkaihU3dGTXYFD0tGsex1gJj0LTuDK+JoPYWzDW5VmZ0XzURm54yOkQu469w6/aBLSPA7proWew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVWKlUPI+CuHshtB1Exr9c33vgaSZiDY1j++XqgguBk6CxHGy
	B55NOHJeA7uCbG0o7KkPTR54WoSRGDeWpK6YF1IWI8HBG1eyK002MVVTFRmgIgZRh7ShxFaaO8y
	VWTpYD/YwAV4dsRi2dPXN1P6ph27kpJw=
X-Gm-Gg: AfdE7cnf8jKv7dBHFzURwQV3xuTSxm0EaAUhxo13V3tMcFYvHrtGD9z+KilrkFUWNZH
	/7Eq0yw7+m5WDFSXwY7izLxijIgqCrcQBlTdrnqVNHvDqRAo7fqNXqBCfj+w7waHGHNfLWh2YUb
	gTF34xoscGGunbsHGNMKwXHTuOBiPpBRoU06Qyq+ITiHkKKsfGjwgZRDne1J+tWPAgDFEV1UGGH
	Zap3YaVH4PtaMykEjG1RKYybqjrBd+fgLG2xKiga250WDoS/sjT6MLdJqynLd+5xAIxfCA0NGaI
	u3KYOc3ZU0UH3hS11VmGM3/VykVov9iUyIamMBridSAh8SOo9i44utiCCzbeSw==
X-Received: by 2002:a05:690e:b88:b0:664:ae03:5251 with SMTP id
 956f58d0204a3-66591634413mr801390d50.2.1782914491125; Wed, 01 Jul 2026
 07:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com> <B22C8EFD-DEDE-49C1-AD8E-BAEB5C91B6A6@chaosmail.tech>
In-Reply-To: <B22C8EFD-DEDE-49C1-AD8E-BAEB5C91B6A6@chaosmail.tech>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:01:19 +1000
X-Gm-Features: AVVi8CdUm7TRIKQUnleOwtMjaxBDCbjz3iJPuSJcM6iQODX-JToqKlxvunuUfag
Message-ID: <CANpmGNuoS+AK6yOo-S8Z7M9LbOqZXUN8Sgv46L_y=OYnU_orXA@mail.gmail.com>
Subject: Re: [PATCH 07/10] HID: apple: Add support for DockChannel HID keyboards
To: Sasha Finkelstein <k@chaosmail.tech>
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

On Tue, Jun 30, 2026 at 11:41=E2=80=AFPM Sasha Finkelstein <k@chaosmail.tec=
h> wrote:
[...]
> It looks like this section is duplicated in the following commit (8).
> Is that correct?
>
Yes, it is duplicated, thank you for the pick up. I moved the fixup to
the transport layer driver (in the following commit 8), which works
better, but must have forgotten to delete it here.

I will correct this in v2.

Thank you again!
