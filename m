Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794124136;
	b=ckoNU6qpZivWQQPWpDsLiLisc8y91yZTr/epP9Z76VBmXCchwH/awBLBOqDtvmV7NF28
	 hwAJxsntupCVi7TpbUvoEM2fM107fLLqbdTIoFJTJXmv6ZjLy8Q9BjOnzX4+QJZANZaF6
	 RoImRou4y9pnRDJjaoSLlVb8eh5e0WJSSdCduRSMn8DUBIZbM2DpBmT6Hzm/2m1RCga6a
	 A9RG8aF3DZDeNUiyYYBHTu870bjqyejn/01WPIksqG8TGr8wHcBDu870XUhjT6KRBpvXn
	 iI7ouuICGFV0TmcDx6aiZm38Xboc6v1Mnb/rMajAw0PCJUztmyjTfU+Yf1G2zLJ8bFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q1Zvus5rC8hShMH7t8nxjox6t7ensKu+IzIvUVh4Gsw=;
	b=sPaBqKrdY4JJ8paicGAd9nteMxVMLiZQOwZ8C0egmLnYCdFvBurF0mEtLgkXhIoWKn28
	 eoICzltSly6kZ9YOLOA/+UofMDgLQZhG6oeRuxF6WG1vLYETJFpn7U5JGywR8Xr6WfRhs
	 x+aKNBwT2P95SvaBaZ47fjayv1m1R2IsEfpcoq27V9dI8FMNLzjdZ3wFauiygLPIkjpUz
	 BLL5wkWDJHX3q9D480r4sJSGohBYwVQdHOX8XOdlSenmGk0UrujGuvJFfjWUvsBdqzEAU
	 zN88WLkgZdtKE6e3IOPuzfPsh/MTCjjtlFTtbr77nGkAHnBZY6AtoYF+skOfvUlOhGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hq5Q0Zk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF57606A321
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 07:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF57606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hq5Q0Zk8
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b33de9d2b1so1003687b3.3
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 23:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794124135; cv=none;
        d=google.com; s=arc-20260327;
        b=dOW6GpOuIqqYXuvfXX7bwu3vaHNJoU3XQTBw+EvVOyDkPHxyjLYAs2OQT3dY8NhW0T
         xrTFC/htfzFUaMX6roDNEo3RdlL5mOXYcRCvQN0ZvYyt9uE66Q8IiK0yzAFDvxEQDkzH
         kzrSqZTcVV0qbjNnFKxI9JGDdU8yMdfgTbCBrFoQ6J7JQvM5WqF0xKGcv/9Shl10dxt1
         7DI8NxCP1txbbsRJE6lE8gcvpMUepZ95dXFqK/G0rulF1GRqFlrwHb8VrDaBkAptqEpq
         nSTBScuVv+9heuwmpiK1xEZdVhkCxHBKBmSLMCfm6YeedimMVffA8uBm+xo3fVd5FgSp
         6M4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1Zvus5rC8hShMH7t8nxjox6t7ensKu+IzIvUVh4Gsw=;
        fh=I5e57mbztHSGUtujDuTdMMpojEjP48NlwXw2YP9lJSQ=;
        b=bDcCDyuVjX8RYDm4yj4i9jaaaLQx4hNSyWnGYLDtJj5ks2NNp+3YSdQXqDaFBBnmPJ
         2kZLNmdjuW98OcI6b7a8qhX1BQKMSOZEKODrGdgAzIEanSbVIlEssrq9xZsUSTRIx93a
         pC5PgNKdtwmEN1rTaHaQjkMc6BtmnnGsFqRuEaX5S44djxNkeCeUYz6geJDxH81Tu4j6
         tOsNdX/vH091MCgrC6/qA9p1rZdtMxzVnoWbbQG1d74Y3naprgP9dWrV4B/vaCzjdb7s
         um6s1TQXLL4lO+Y0OVnbkX14Nd4SHMpR/N9OGhtqagU4+LeMvj4bRKg3m2R6t0HOZoBA
         bMLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124135; x=1794728935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1Zvus5rC8hShMH7t8nxjox6t7ensKu+IzIvUVh4Gsw=;
        b=Hq5Q0Zk8osL5u2wXfAxeQHwqUJyw+54EnYgiKD7/xrVPG/AZjhQ6zOnxaqwS1kbXvK
         ZpD3UpEtYUwcqMHBJkFby5fuLjZ4t9CYJlf0gFfjHG+OLcuahCBM8jbXoIEIwMpRRgEL
         v+0+jH+zV3bWzaLYR8Z0mR5j1DjuZCsDkW7DMNTqe6XA0dJx+X3YwEhCDDmtaJy8Yt2Y
         9WUCHjM7n+fq8Vs22zsVrt43gnI3QfmskUJywDkZc1RTsm4CwUIEt6lCgN/4/hlogxOe
         1uCxm3dmJCyLEzXzXIh6UIhme+S3NrHYCsT/e1Ni94y69P1GSu90woc/Daqco7CY+fNo
         +JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124135; x=1794728935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1Zvus5rC8hShMH7t8nxjox6t7ensKu+IzIvUVh4Gsw=;
        b=ez/SJJpWKkv5GnT9PO/1byUzg1AZQ9a1PGQLqzs5i6gnDeWikSNiroGoODSaEpQgT1
         XWTHFTxxCXDA/o/qNS4EFYY9i63o3JjbueoR77hhEwE/9d5HM2D36JQtbEEP7BOT+WxV
         K9Q4szAnscA3aSrL23YriMfGNjRvkm/YRFcujzIoer0rZZDf06pUM0M1nAWUAsX/6Q5v
         +qpaQjl4yu/0CMKRIPbB0lecBwZJnxR8uGAOIc452+2EyjtFfBk10WaZtxFkYpRrshC+
         +QwAKypgu+YPzuosP5ZvVfFrmFdWXbixbCAGatzUYe9+HVO75Upjq1ui+YcEkxjpCGtb
         4baQ==
X-Forwarded-Encrypted: i=1; AL+hErFg04+sm8gS0pRUtLbdLKzgxGFTXllvV4SHkjlMUG7XX1X1RdNwpzGiGacY7JlXk1IvazFG/wgjfmVRsA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZRbEjbS/CC+8OO63le8fytaA2ok8m9breZxAGNjztcHDdTVYi
	cFecePA6BcFzoiOb0760d6jGoLvXz/TNA4S5LQuD2LojhwUbeQ0UpT8Ts0AYKt10ijpSck8cy70
	e4CPogkk2OfFu1xYgcc2W/QIqkUTff/k=
X-Gm-Gg: AYBFou1pBCIakBW0kbhC+ab+AdHqEcqrdLUSPE9wMUgVpxTYlSJZBS18lkadMrhxdHY
	xz5+aAssOAW4dTiuIyWKXCTso80EKwMU8BCranq6o0NIbhzmwrgoYMn3WRY62WfPu+D6cdTrs8G
	PU86pXgyKY4wt6pKsmDN8XxuibsX248z2QKst8ibKicCLpYr0EtnjUNUQh3lvEEJeTbLFSNrOf3
	WNY2sxANNQK9xD9zTxbJCS3rWf932NqfV8en3ta7YHAL/f9JMCfIxUNjt7gbxx3448TMF6zGM+M
	7kL7i8VTsC/nBml46K3WzNUJpuyws+UHMKgGH3OQnPMHHH1mpH3sbV9/Kl8qMo0eK8HZkjG6z/+
	etH9qR1DbejGk5McAAIx9/BhdBoK3WSNBvAHw3y8MhXgER6eSQUEiUxtVdEHikOzrfruSqLJqBa
	e71ilPobtfi7IjPs7Jelg/36ig
X-Received: by 2002:a05:690c:388:b0:8b3:2b8:854 with SMTP id
 00721157ae682-8b36caf6665mr5647857b3.89.1794124134911; Sat, 07 Nov 2026
 23:48:54 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-7-e2c97b82669a@gmail.com> <sashiko-outbox-203632@kernel.org>
In-Reply-To: <sashiko-outbox-203632@kernel.org>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Sun, 8 Nov 2026 18:48:44 +1100
X-Gm-Features: AclHuK80jFNSV0poXYzL--QRjzmnK-TW4SRDsdRWfR9wTFf83IZv331kn811FJs
Message-ID: <CANpmGNv2WHN_C+83FiNZHjKrdrPECCapDRuXL4Bn+0d=00pfLQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: apple: Add MTP DockChannel HID nodes
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> Are the M3-family compatible strings in mtp_mbox and mtp_dart documented
> in the binding schemas?
>
> Running make dtbs_check fails because apple,t6030-asc-mailbox,
> apple,t6031-asc-mailbox, and apple,t8122-asc-mailbox are not listed in
> Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml, and
> apple,t6030-dart, apple,t6031-dart, and apple,t8122-dart are not listed i=
n
> Documentation/devicetree/bindings/iommu/apple,dart.yaml (the same applies
> to t6031-die0.dtsi and t8122.dtsi below).
As stated in cover, documentation for these was intentionally dropped from =
v5,
because it was picked up into apple-soc/dt-7.5, so will be included
when this lands.

Sorry, I should have made that more clear.

Thanks,
Michael
