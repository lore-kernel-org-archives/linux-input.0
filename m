Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8546AED1
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036000; cv=pass; b=V7n9sYO9oug5bN78HmIiWHjkGxal7kuJ8DkOsJl/4m2f2Qx4YjqZ7MqusUcC05V0pIE+7VwPny+QB9yjXQyySGLu2xTLzKX2TafwI4J2LkYCgi5v+Mf+w6W74oHzw/3wl5ze/oY6XQi09EHK+xbOcOfvD307OKKziHue8Lzx1n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036000; c=relaxed/simple;
	bh=tFXARX4SHAk3PI59oKiV3+pkOUhhlBx2uKmJFHAo6l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1JHWSr1bXkj7ZeDOIpDJo+f6x3r110gF9iOCBi1P2TQFfDz9eRgegxA43tsj5GGTzitCSr9ZL4fu6yNzFfPla6YULDSqo+FTd272WRwzAXVJB+ngD7BPxG0ryG2VyHIXhwEZb+1Tq+HGVqrjwx4OeY7Ja/D56BkKrYTeqWL2zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qo9Rgy2T; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo9Rgy2T"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-736eec08c43so959353137.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 06:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035998; cv=none;
        d=google.com; s=arc-20260327;
        b=KyED7pCbhyRjDsbFWf5Zp+ioe7UT8XbqFTs3Ki7B8gdqOVPT2CAkidMgvA0RMH1/Ta
         myRFOF8hK3qw6SouZ/Xg7Q+Y/EE9+e02we2yuy84x8OpJHYliHACmLJ1Jy7Bm/JUZPbS
         FKjLZaHyOMntC6G8bOfol4mOIUfF0/gzm5pxFYP/NHA8Q2y5zahpJ3COdEmKAAevkSCP
         mucYVaMTePxABLW6kZCI33LfpElMEjFOGKlIDc9z8EGI0LeWYVWPV20aqRzC83lDDGBh
         LANjXc48XSMeEZF7FTdd1Y87lvzcArkYOumgg/S4HD9UwrSg8obOmUxyoAGCjez/93ip
         SW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tFXARX4SHAk3PI59oKiV3+pkOUhhlBx2uKmJFHAo6l8=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=kjSNzkpgbx1vauZQ1RT4FtXkKUdN9qGr/1fwi6SvicrZ9IjNe+qHw8kxq4Y1ovDN+q
         bSKzUgWC9Hkr7sq1E3UN00BP/NLCEfj1JVAZhc9+37Bzp8Hrl6ajfOgzFzM1/6SI5897
         VD41ilNM8qalwjgo2yKXvdvcEWE3OTBuzAnrqS/WhYc/AvO+6Kjnxppaa+iaUngnY3Hm
         HEXWJzPCZcmZSqcl4HnVNxcooIflfEEZqxiTQDL3X+UyllaNY8H/9hXZ8cNsWni/lmdL
         V4XQ3ZleOr5VMazM5jHF23SbFzlYQBVXVllU8UNsIfj4ldkrfYvfXkaSQhOXhdMoQR9L
         kqVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035998; x=1784640798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tFXARX4SHAk3PI59oKiV3+pkOUhhlBx2uKmJFHAo6l8=;
        b=qo9Rgy2TgLYAxz2TnZecUhr2sKTwvgLWcgnvcWMgmPXabMT0p7nYdFWGoNL3k39Nzv
         rbORQhzrOdgcbBJm6rflVQWGEXkkwHr6tXMOtatxBkS9SMxGcOWeUira3LaLNFUq1Ge6
         arxbE3zExvif3LHibiBua/kiVIMI0U9f1+t37VQQM0Kyf0IdxmK97gb23KFNz1xtE/ZE
         VlUvv3Vlq7Z81++EhVU+nrmjNPoGAEXi8iCXyocmSVh3sTagTVlaLTAR4lFwb1bnPiBf
         20EI5zk3XQyl4yhA+inMFB1NnAC+qGgd268+jupu6MVzUFcH53L3zUY5uc/xxraPkQoo
         0K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035998; x=1784640798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFXARX4SHAk3PI59oKiV3+pkOUhhlBx2uKmJFHAo6l8=;
        b=SJv7Lnr5MHjOkBZoxflTP/DHVBKvILQxFmXz29NduPY+mlkPehOUM6V9rhmLIoGaN4
         vkw+8J9nMRzmwEr0KEH9JqChFSf46lApLSGLn90E5rd+KbpKjFD2X52sMcoUBvE3w2rK
         0TFZNPlIPs6QaiQcV34fDb44xdMMwOipF71L6cIsyViSz4tN8IKjvSN/b0zVSpmKC6V0
         6/NDsuuA2kHjtg6unNJVncoy/NWfbptW+j/buuloULusXJaRZeyOsHGOlO0DiaoM9tqy
         g5CAIHD9nIfT/pbBOhDKpMx2Tbq+IgRavtYZXmY14AYemk6uHB24O+1UzuO6hSwh0JK/
         z6+g==
X-Gm-Message-State: AOJu0Yy6RcvpNzpOi9qtQXhg1JGosnmQzGR/KrGMns4qgxqrROirzUe8
	Ty/86/aZtPqDPFul1PZn68/SrIttPq9X50EYfEe1pDt8yb95vjtgPVLGsfivCuOhMcAU7Iv2IAn
	HTIIn3Yg+X2EpnxrlX+qkes/SiJhQAV0=
X-Gm-Gg: AfdE7ckQu6L6T+VIGQcaaMbV3ynDATrJZRGJIk23ckUYC5B47xrKRy30q5uL7mgTF2X
	WOwWSS4JMGeB/vImkU4s/PE8vP69tHTo6ZnT53Ur7AlVN7G8+PvnuLNeTMBoYE8i99HKINXgdc5
	mcW9K/3/pZ/St43leU75+aczIlEClwaz2tpekI4uwyYJpBGxVFhWmk/EacCGWnYDzjR+4QjPIEP
	YR/jtQg/tJ+c1VzCTFqG4na2hZSXSntNYJCSeGfmVEoYA59/AZwVWJUh2FuykR4r8DqDhhIi1Q=
X-Received: by 2002:a05:6102:620e:10b0:734:54fa:971d with SMTP id
 ada2fe7eead31-7450c7309f2mr7136897137.7.1784035998246; Tue, 14 Jul 2026
 06:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120052.255085-1-chlgustn3171@gmail.com> <20260714121819.5FCC91F00A3A@smtp.kernel.org>
In-Reply-To: <20260714121819.5FCC91F00A3A@smtp.kernel.org>
From: chlgustn3171 <chlgustn3171@gmail.com>
Date: Tue, 14 Jul 2026 22:33:06 +0900
X-Gm-Features: AUfX_mziL_YIWK1mOLB4Cx8A5jwVQaeVlfikn-kbN8oMPqwTpHlQFBBl6-mR7M0
Message-ID: <CAO2ma08Pap6PZKUV7iEpvu11zaKrzMK-cgBLBYKJEEfGH+0=1g@mail.gmail.com>
Subject: Re: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid
 device devres
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 9:18=E2=80=AFPM sashiko-bot wrote:
> [Severity: High]
> If a userspace process holds an open file descriptor for the evdev node
> (/dev/input/eventX), the input_dev will outlive the parent hid->dev.
> When the HID device is unbound, devres will free these strings.
>
> Can this cause a use-after-free when userspace later queries the
> name, phys, or uniq strings via ioctl (e.g., EVIOCGNAME)?

Thanks for the review.

Using &hid->dev here is intentional.
Using the input device for devm-managed input_dev strings is
problematic; see CVE-2023-53454, where the allocation was moved to the
HID device because the input device unregister path may still use the
name for uevents.

> [Severity: Low]
> If devm_kstrdup() fails for phys or uniq, the code jumps here to the
> error path. The earlier successful devm_kstrdup() allocations remain
> tied to &hid->dev.
>
> If the caller continues the device probe successfully after this failure,
> will these strings be leaked for the lifetime of the HID device?

The name/phys/uniq copies are attached to &hid->dev, so the clean-up
is handled by HID device devres.
However, if it is better to explicitly unwind, I can add that in v2.

Thanks,
Hyeonsu
