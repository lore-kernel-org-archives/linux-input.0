Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCB33C1A5
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208076; cv=pass; b=AorVQLZw4BG5b2H+dh/K3Wq3ljh5JOpKyPhg3TvCh/sBm426q8q8AI3vXAgxTE1N3QUmkK3b0HxyMMFbrV5fif9XyGylvkkkDhGXtFuXQOxPsQeKtG2lrC9hQV/Yk3zhbo1YEv3o7CT2M/ecto2gN2BcFNqChSnb4pAv7YPz/Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208076; c=relaxed/simple;
	bh=QbZBV8VMLjwSGIxvbVfUkXD7KE6qVEcTfgfwkxxhe6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxWPSTjeg4GTFtsGFNFpLo8sJzsgr8sVxJ4dxUzIXuDVqId8td08obceeBxF6SzNBIxHm2NH4z9ut0EpuGjX3HmltQ6FZq36IINWXcIlpVMBjpl6wC2IMB9uNG6PysNF3qyyC0DF12kvPFkuSvgnRGkerTcSKG37IZE9qrqALiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8KjchDa; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8KjchDa"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a1443780c4so684038e87.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 22:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773208073; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/beVKguf+StngfAYg7pZhuVkvgn1D4Y+yMccyccqCzE5GG/X/B7vHNzepUkvVRLAJ
         GjTu0SCdIiXz2rzMHtK7d8nMDV9DstAtXKC8hEUYAoVnKWuKXDWNX/BKy0x7x8q1yh0W
         HDQ2yBTwW4zDm//XzV2tvrS2NcdVLv50f7pe/jc5/YuMEnLH9lCa5c+lXNVnk2yqaFG6
         vFgffcDCvMtT3Q2VTTYmw0oB4xm4l6D4M7YulXZv3Qj4G2GINYxeqLMGF/Wd2RiHTMji
         tvF3UGhLxuCS4IjFGDzi4NBbEEFddZjv91w9GUko7iVQj1omTRqSVQH3u0e+0ObTt6bn
         +5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QbZBV8VMLjwSGIxvbVfUkXD7KE6qVEcTfgfwkxxhe6s=;
        fh=9/i/E+ZgWXutFG3zzAphBU4DsTnUSe7gnK8G9/8OoXg=;
        b=Ua+geKzLJoN6TKveR3LOADPaS+jsXRa8qcmcfRZqIiVTySlCITdrtHy+zGsomkxqXc
         39zd6V6gJCjU0cMyLTThSRZ7LxuisxLzZIqNRQx8NDRePozwc0zEJAWuN+jQXn2iOa5c
         nsgKEBJypg73o+wK0hmVk2v+pUay6xyQLF2XcC7sOllU4rSQQRSwENunk4TKGMWdD3+D
         sqmVsiB9BjnYJLyk5WGGKf2CAxII+5nNH1gsJGhWPIRbGTuJPDT4fmqxh0JatOZoaQZP
         K8DZhxORyZT2YlodNsCD4ZeE0lo5TEiCgKJBIeHyNlKu8yuSBp95WYnKXt3jA9PB0Ud7
         ZjaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773208073; x=1773812873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbZBV8VMLjwSGIxvbVfUkXD7KE6qVEcTfgfwkxxhe6s=;
        b=l8KjchDa4HgNOr2ys4xo4/+b03TVzU0KFVmmLyUZ+6tpy/y0oeCJS2Pe5tMHYc0kUx
         jQmS22Qa8cG1w4sngColw5MGOcJq+qU06LlPP2Epn/DR6W+saLUAdSxGCbEoler01Rtx
         +uEUJJ6V9jmuYLzLmXjIMxR0KRsKkOAKDods9lQnGsnzz4w5XVHSU5n06/6WbVCkyjdi
         jumiqRct1M3V4MpyLlTjLGOI6Ocsg7Cg7ojj73Ajlc7032210LcqzHhNV0zx30yeiXww
         tbJf0jabTwEcSr7x+rXU6SuYgUVofzjpgXE3bANL8ui8DTwLtOWbHraLwxfIstrAqfPe
         9/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773208073; x=1773812873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbZBV8VMLjwSGIxvbVfUkXD7KE6qVEcTfgfwkxxhe6s=;
        b=hZv4ugNk7WNB8LhcARkDJGbFwAZs6WnU70crUsv9Jgf6yePtaqkZr2tn3jRROVpWmH
         igDTxqZNI7Uw4+HFUYQG17DuU6IPx/6Pxb5WyKTGA9piq2tUwGlEId4Um0kthVK03xrh
         oyAb4fNITnj48h1xYxuJYSX6/CslL4cCHlnzJE27NxczgdFGR0Lh6kydwAcjvYB2jxlE
         1c2p1RmGygFr9TC3FXlYZfbYFc0jJ4q5J3oG1pCbgWndMqkBDBUazP3H+0wgbddbTXNi
         MfrGO0IjD7HcpaokWon+WhbQpvjz+89OvwNz7cGWCsaS64aMBA2D3FSGNfdBzUnT+Xyf
         r5ow==
X-Forwarded-Encrypted: i=1; AJvYcCVCGeRqq4P8g2kDWPrFWbKTtYeA5rXWL9T67Iu/omv+aj7n0F3IEf5wQXQ6LboUPoOlaQhvs+KWOkTpcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI1GJQQKj7aTpeRq7DqmpC1xkRrpKC9W9SzI0KlNSE9VbqF4O
	NRV1JITk2wP1AUHpspEPF5ai1a4d+ONvyVhWu9YJDyAXtJBx+M4NvOnqZxPC6HADbboQ7U0y+t9
	4DXorJqBnaP5YYEgPyzTOrtgivh1K+Cw=
X-Gm-Gg: ATEYQzwDuTQWvx1lhH4wcHkSG0AgqDuGYO5+X/yw+SEDlcZXxOHaPs06XfDLrBU2ULz
	gwc1yraqe1bUA+NKXlrKJYA21ibRclxVUcR3uMhfpEYEbeYvOhP3BgnWOXLvvCSEWxYazVkWKI4
	6cmyOtAmFwYwwl0Sl39u18BU94oG4r1TwDdRt2BSPGpt0OUszHGpqUN7cJcEYU5DAyGwqjZWlYh
	afPCCLibtXxplK7uCBxgyXDEAGYWgxrhBAmJGIZnADn/rhN9AW/fu5Wu1It4NgxlBA0rfu59nqT
	HXOp7MRJhEBq7SBvg+dc+yLyN2hh3XuYG3t2FpIRT+ElLyAGHlGgYcZ4nIWoKK1q9BvYsZF5yel
	/CkKz+vTDjq7H
X-Received: by 2002:a05:6512:a92:b0:5a1:2efb:7d49 with SMTP id
 2adb3069b0e04-5a14e46ea38mr1928516e87.10.1773208072688; Tue, 10 Mar 2026
 22:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304010345.1355896-2-sanjay.govind9@gmail.com>
 <aaeI1p_Zd0v31-p1@google.com> <CALQgdA0PL82yLxWbjcqchWzsf+bA7_Egq9hZFzz7toL4kByAvw@mail.gmail.com>
 <aaeLgPyFDeA6dxq1@google.com> <CALQgdA0q=+6L2mQBqNPUBzo+HE6=AjhSPv5G_dK9g=V2npSsWA@mail.gmail.com>
 <CALQgdA1jJUzpSvva-YM3UOvK2Cwtyb3sK7uQO8T5NxZ-OB4Y_Q@mail.gmail.com>
In-Reply-To: <CALQgdA1jJUzpSvva-YM3UOvK2Cwtyb3sK7uQO8T5NxZ-OB4Y_Q@mail.gmail.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Wed, 11 Mar 2026 18:47:41 +1300
X-Gm-Features: AaiRm518F7oTzWkoTdxiWmbwLte4uGS9K-I8gWpv6fFCkhB_hQ6Z9jTy72g3ULk
Message-ID: <CALQgdA2tnASPKLaAnK_fuXNtoWcK_nn5PDY2vX22NhdVf44Wkg@mail.gmail.com>
Subject: Re: [PATCH] xpad: expose xinput capabilities via sysattr
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 2:34=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> You need to start with enumerating what data is currently not available
> through other means and why it is needed. Is this something that other
> gamepad-like devices also lack?

Thinking about this some more, I think what I'm really after is just a
generic way for an app to request a vendor-defined report from a
controller, so that libraries like SDL can better request the
capabilities of a device when trying to handle devices properly. As it
stands, PS4, PS5, OG Xbox, Xbox 360 and Xbox One all have vendor
defined reports that can be fetched for describing controller
information, but only PS4 and PS5 actually even give something like
SDL the ability to fetch that data right now because they can just do
hid feature report reads to get it, while the Xbox controllers don't
use HID and thus we need to expose that from the input layer.
