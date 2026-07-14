Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0646AF05
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036364; cv=pass; b=DZJ2sJK6bOGMHcG8UPI5VyAgebLWgWI+XHxuprb/FlYE8GkLgtI/ybpx48ReLH/tUgsZSO1hJ1LnAFu12OsznUD+l8EIQkGbPfQTHqDfgQYSs84n6EqfVMYkzOWiczU/TXQX19bGN5Vh+9jwK9/mqr3IDval509ueIEJUQ96m9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036364; c=relaxed/simple;
	bh=DwIb33/MUbNJ6SXd61hMtjAJP3vWKRsR+k6fH0eQFvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTI2Ban5V3N4pGKhq8AjrcffniJ090T0+QBrdYrGLI7QQajAltglqPnOGC+5I6isrt0Zsr+fXT86En3AltnrNprTjS69oTInVx2jwJlpvPPI7rTeAa6yJ/KxfnQaH1IZoox03awgmma0nkHF6M8CeXT9hA+DUSE1fQjoeKCmSv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGR9jPXe; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGR9jPXe"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-74019ed06aeso3386980137.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 06:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036362; cv=none;
        d=google.com; s=arc-20260327;
        b=PscMpPvaim4fkfrTGPxjl92NwLQ+a4mAqcYLLvU8e9w+YX9GIfElt/R71J+SDieBzp
         4a9LkEjCmCTKYu7CVPaLhwOfsOhs4mdQgXSe5VFNFR5+hBazl86vtU428baAjwGOwNE/
         bOWnLj/u3sOPtkxEmUBjeyqp6gefGPPoqo9DN0PYw3iOw9KLMgGuanAYIuUIzIrpOtfk
         9qWaxmi7Yq4drbXHuZ7igapeCkwgv7IXZHhf34+4D+qK/H916gnTtsoeuH9aNT9eCzNu
         waCDgQRWkICQ7DTqyk2rNhUCzYnv+r+xK4EuLn0nvUsm40CHs0yj2lTljT/zGYtnVDEb
         +uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DwIb33/MUbNJ6SXd61hMtjAJP3vWKRsR+k6fH0eQFvQ=;
        fh=CcQ86f49oGl9srj5qqX+VrnKgviRK+XiAGNNzPzdATg=;
        b=Mfb3pOaacYTiPFFMkDirTKj6H9s0I+EYPWL0OVwrPZ+w854PXNGpUcr8RE1jCVXDm9
         4ge0BBChMYuQs1qk0jxBZ+vayoom1sCVv/GzPR3+r1NNgnhB5TInRKLDntJp0yM0YKkb
         0TN2ePqaLWsz2IzLkxfqzWq4OMDG8HY1jGNTfN3WD9NX81/GmlMNf0xfRzviAHmkK6/t
         YerubeeJulgGA//usTjTswTwCB4KNMJEMPtun7bZgidzRYXFyiviSZGO14a6YLbfkV/+
         bBiHLTPIANoRVgWnYeVhLw3Z1N/LKkbZN5ate6l1sBypfVgymntgBWb2OWwmIkO1ALwF
         ni1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784036362; x=1784641162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwIb33/MUbNJ6SXd61hMtjAJP3vWKRsR+k6fH0eQFvQ=;
        b=IGR9jPXeH7pCwyfO7LdiKzeEuf8W+oMvXZk2HXESeHtVEuExM6/j9Gl0m6I+EuL3pC
         QwOq8L0hmEIci0TnHs281UpxWabzMjA8pUAcAwe6kNjXVUoE2DvAAZO2CS6s8rg9GQR1
         xadRMvd3OjXz7FxDs56sQby3IoZMros7KFu2v91DiFhiaXFxmEO8UAa0sMht4obGBacD
         SEXkUTU5/BrVJ863yRqbFhLUzloh/gFsbHYvSffErCKEUfWzWcVcex6JaD0uHlxkVOGM
         8Q//Okk/glh+Vq+iDqFikibHop7MpJwaXkNFdm86yqcxqDPGTe8SpdIHQAh9T+IQenNn
         tFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036362; x=1784641162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwIb33/MUbNJ6SXd61hMtjAJP3vWKRsR+k6fH0eQFvQ=;
        b=qoV3sMws8MHpD0zI68kyR4BSJufNb/TI0dlR+SqT2sTV08qor0o9w8HEKc4VgdL0qc
         x/iMM8q1Ad2/3MN6uRt3B/3ykneZYj/OC6IvHeGAwPrl+LMJYmXPfgmqErygD3ZY10NQ
         w3m8Csc93KxFZChVPXpzlFRImqPsxS79/PsV4te6p0dbnjFFjcO32iljY2nhryOCjWJU
         XfJshE/I4cqmOSOqYA5d/buFYisI+4RQSTH40Jfx5LRkC0dsfSspCX7nY0u1cqzhkZwz
         rtogCL8sy1SkfJYRq/GDyrwrS6Pqjm9f8Qn24S/MuQR83s35tlB0TjllszOAm4UoyY2l
         3N3A==
X-Gm-Message-State: AOJu0Yykxus90dKr6oLm1n9uHDWWdaDiJuR8SZxX1O6t97JKNBqEr60a
	59CWOG3NO5kRyiQPKBoyqPB2Q2EAfrAvMvf0jYEMrshqI/Q3dQ4AX3IaTa5hFgeY6HspidglpRg
	dg2y0xi40wLx5K2A9780zRoL51KqW3LQ=
X-Gm-Gg: AfdE7cnCxQ+3Y9bSVFQtK1ebQ2pmaQJe7sBGh/GVlPPZcYy9NEecmCSfb+/UfkpSGHb
	eZakM+L/kE4nwVh5AgNRIplSQynpF8NYYXSgKnMxGeEcAVVcnl2nbxjWm8h+6ggMiZGI8rt3+jB
	zSFMnOjKKUmsC7Z8h1Q985bhPKt3lXwwxmXIkTq1v0PXFYi2Wt149AYwOUR/qkDjNNxvL91Kdjc
	c5z2foiRrENJJmdd2+CC25V45UC33VovPLcsWYOulPH6ZjbOl94dCUvhY7Y/obESSv8k5m8ECk=
X-Received: by 2002:a05:6102:441d:b0:643:80f1:350a with SMTP id
 ada2fe7eead31-74533b42f88mr8627150137.2.1784036361731; Tue, 14 Jul 2026
 06:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120052.255085-1-chlgustn3171@gmail.com>
 <20260714121819.5FCC91F00A3A@smtp.kernel.org> <CAO2ma08Pap6PZKUV7iEpvu11zaKrzMK-cgBLBYKJEEfGH+0=1g@mail.gmail.com>
In-Reply-To: <CAO2ma08Pap6PZKUV7iEpvu11zaKrzMK-cgBLBYKJEEfGH+0=1g@mail.gmail.com>
From: chlgustn3171 <chlgustn3171@gmail.com>
Date: Tue, 14 Jul 2026 22:39:09 +0900
X-Gm-Features: AUfX_myYjaJA6AxmS1f1aMv-_YdelHEt1X3VS9D4jvlYoByEOFtdLcCWT5iVDmo
Message-ID: <CAO2ma095Hu1kOTMds9yHqTvwde8Gu+GWOLUst5U2eCnSffkm=g@mail.gmail.com>
Subject: Re: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid
 device devres
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding maintainers and mailing list to CC. Sorry for the omission.

On Tue, Jul 14, 2026 at 10:33=E2=80=AFPM chlgustn3171 <chlgustn3171@gmail.c=
om> wrote:
>
> On Tue, Jul 14, 2026 at 9:18=E2=80=AFPM sashiko-bot wrote:
> > [Severity: High]
> > If a userspace process holds an open file descriptor for the evdev node
> > (/dev/input/eventX), the input_dev will outlive the parent hid->dev.
> > When the HID device is unbound, devres will free these strings.
> >
> > Can this cause a use-after-free when userspace later queries the
> > name, phys, or uniq strings via ioctl (e.g., EVIOCGNAME)?
>
> Thanks for the review.
>
> Using &hid->dev here is intentional.
> Using the input device for devm-managed input_dev strings is
> problematic; see CVE-2023-53454, where the allocation was moved to the
> HID device because the input device unregister path may still use the
> name for uevents.
>
> > [Severity: Low]
> > If devm_kstrdup() fails for phys or uniq, the code jumps here to the
> > error path. The earlier successful devm_kstrdup() allocations remain
> > tied to &hid->dev.
> >
> > If the caller continues the device probe successfully after this failur=
e,
> > will these strings be leaked for the lifetime of the HID device?
>
> The name/phys/uniq copies are attached to &hid->dev, so the clean-up
> is handled by HID device devres.
> However, if it is better to explicitly unwind, I can add that in v2.
>
> Thanks,
> Hyeonsu
