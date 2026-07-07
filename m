Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFA41DECA
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431758; cv=pass; b=khKgAGIuFGf83Qjgd6CpSjF16VzG2Fo9H8Q5oh9ownPFsxx3jOsFUEupVBLPMatLisSf3hc9THBK0IQ4mBqKxZ0SSkAq/PxbVWqYgdWq7G7fdUOA7cz1C8mEgndA8Lmnl7uofaA78ucKjHa9bk+aYv2cc9QiPhQAWHFfbLpMuXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431758; c=relaxed/simple;
	bh=E1zAPP9belnBMx2I7CyLtNbspD4kzIfqj0U5PW0gNQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gglAtPG9mL+X+0CXeP92NUlUZFg6JvXWfdNLt2vWoDd4kxeszANslTQKLi5rdTXAA9ztG6vDl8BgaKF+ee70sF8203MruSW3mfeRP1SH1EQYa3mMZYC6BqWZdNlAubEZiP91bRI8kfsHN4wzZt7q60/jhagIVVtKV40w4r2L9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyqZgWzt; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyqZgWzt"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6649ffb1d01so6807565d50.1
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 06:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431756; cv=none;
        d=google.com; s=arc-20260327;
        b=Sb8OOXGH3oKc5a3iR2NwvQpFatH6qMByMvnbHUNvaWo0RGRUUdopB9lmaJXKY2HrqZ
         o8eiotyDZ7Fe8XmHiBpY/gNjYsh4q/7lO9b2TkUfvbSsrGmtNtRBAL0D44fZMelXhq6r
         D4bm8Wm7WsXuqJkyJulkrgjpbzdXnzOivegwZx/3/Mr2JDoQ01iS4iMR/2G1zJQE+0Yd
         NI3RQfoxRUTtsqvFItTj4wcnUwA0CuRoGVyruALVED9ZRiiE5KQMt4urXzHqyQi3YBU0
         CAIkRxjwpvZ08eWFirbX0czaOUpc8EiSCQxReUjiZGLv8NdjoRe9w176N0oNTb8sJSFy
         7nqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        fh=aG77gF6XAXX2NedIorYFi7Sm58s9I/hH4uDXr6niqo0=;
        b=QiIgUsiKJiDjQmp0eA8gIsRE0WMDxF+b77vC6LmRgcxF9+zd9htDR5oO2svZVqfbGb
         gvlZVTGt61y63kjYsNqB+jMTCiSHAN1On0yNceH9Hb4J3KVei5tVCHaqePQADmR7azd8
         gcX39DEY9Teu3QRYaVKCHBFhqiWLtSzjxFJP/tnB91M1nZiKOznywoFXNBsnyeXIHqy/
         h3pCiPdObPYv3LXSylqQHNtc5pt0EeVreKDEqjcApDJ15fyCM92i6E0OAsV49i91xQwH
         Bea61bSaBwti9UCPLOWZApMKTFVWPwlqvjCSSwqxFA7R+n2Vf63a5hMlwKAEqwH6eOza
         KrbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431756; x=1784036556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        b=AyqZgWztWnKRxEq8u0UE3xKIskNjUBNPGRKFEwrz+dYsU7qhRiQKbPqgiUOnVrZQgd
         G3Z9LL17CAUSThGwKUNGKZAKe4j+8mhBxCI61qxW1zDXAPYSNKX8Tf7XYUBNxvd8sCGw
         dQTomwvYanCFTIhTcrVyA4ES3pos5fp+fAsO9evshM70suc81EQ/+JZKd7k5wtsRizVH
         RfWMki1Wi4qQQpnOxO72PA+7LbZ7FbJJPto5EmeSqpYgTzLVu05a8cMgEQZnF8WXdxpD
         0eImHj0rFnQlz6a1M5bTp51TK54zS/MJQKGNU9GYmGJN/eRD9iqBsEgXBZb2EkHZVIAZ
         SC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431756; x=1784036556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        b=o4gIaxVqp3fVahbhA80wFtDyryLT9jiDT3uwmIlOA3EVb06QqWKZmVbkYDWyAlrFNJ
         m0onwh7ggJmwq2cIPDWgbn0o4jz259ej3FS+VLujh5M0NRv03AiOyLD71P5TEj8ltQu4
         /znRP/UntrTG+kga2GOsxCj5o2naLCYDHY5jg8+FQ7EAyMTw4zDv+CxnyDSfX86mW85P
         FV8HbuquVOLGs+yAem4+8wOHgdx5vgcTPi+/QpRb/fMqVe7oLQvwJCDZ2hmFlzvW//QP
         d7HqnNUimrND2xzmuF9KRNJfbiLgD2gsNzIAzzS7jjiUFzS9UVM4L8uBdUgyGSH+wLCF
         Gzcw==
X-Forwarded-Encrypted: i=1; AHgh+RqB66HhK19hIm4oz4lJaN6JMVKBH6PafKmaDxWGNiShH8WgK3AEo65HPAylRh+697qlc0Cl1dzBrPa4AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfF1D/hwEObKSN+0OscVbldLbIBq6rxqbVq5cRigvMuUydHH2
	y+R4W3PmPjMRFmR8v7ufsCCwsmJP4UrCO2+GJolzNqQD1MAi69uxMxeln+VPVGuJYlNoa8sYaeV
	tcvhwSS2NSLmgs3qaTtw1BDXlaxJFTw4=
X-Gm-Gg: AfdE7cnNLqliBvPGECKKncnFgLPvS17D7/s3pH3qyqjaJr91t/QjnIttmVdgpdU8MOq
	kpdBP/m4mFh0XU5uirplUqDEtBpppDD9jP8/3F7NEGhnY2W3oIwsUB20FMHL7P05e+TYUnKec3H
	p93vnGQWUxiMSwEXMaMoxl5RgdL/E5EgBVCsq8cg4QoxTso24bhSY/KomIxQkVNv/JAGbsHEATB
	T662fzFiVrAbTuq0uRA/DS+JjO7SbvL8IJPYTYlSj3Q1LmOwsuf1uENhUK/yaKPqcdYTht/lhkY
	Jwb+s+jkal3IwYC7oQY2EcLYTtb95lmvPcoRuxidLESTn5l/aASWZydBvaSoV28YWj3zYyOw
X-Received: by 2002:a05:690e:488c:20b0:664:d231:2f73 with SMTP id
 956f58d0204a3-6677fbd4331mr2922458d50.50.1783431755730; Tue, 07 Jul 2026
 06:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-5-506d936a1707@gmail.com> <e23e4581-7eee-4f4e-aa82-6b6bb6177678@cyberchaos.dev>
In-Reply-To: <e23e4581-7eee-4f4e-aa82-6b6bb6177678@cyberchaos.dev>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Tue, 7 Jul 2026 23:42:24 +1000
X-Gm-Features: AVVi8Cepx_g_efgo_16NLDYw5eSOtcfEnI_otyB3OoPCUn9_yzRFa4EgaystrR0
Message-ID: <CANpmGNtnZo20nPyM4qB7Jcty=bRFsxsDWnAOk9Md6Y+Rd9n7ZA@mail.gmail.com>
Subject: Re: [PATCH 05/10] mailbox: apple: Add DockChannel FIFO controller
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

On Sun, Jul 5, 2026 at 6:14=E2=80=AFAM Yureka Lilian <yureka@cyberchaos.dev=
> wrote:
[...]
> > +             while (block) {
> > +                     writeb_relaxed(*p++, dc->data_base + DATA_TX8);
>
> This must be writel_relaxed, as writeb_relaxed in this mmio region will
> cause an SError. This is why we have separate addresses putting 8-bits
> and 32-bits into the FIFO I guess.
Ah, thanks for the pickup. Sorry for the silly typo from me, must have miss=
ed
it because all the HID writes are 4-byte aligned. Will correct in v2
which I should
be able to send out by the weekend unless I get busy.

Thanks again,
Michael
