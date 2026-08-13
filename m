Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF835F162
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591811; cv=pass; b=XP4bvEBuNLwIKrDPegP6UeZrW13AkHlnbyH9XrelMRVjseLVjMQLMntwPFsCTQ5QNnuKxJjcILdUdaonqPDTIfZGL2WoGlsdXl+6C3Cdh6MEU9XflNIfcZIlUZUoNxepc5AMAvxPxLMzREnJsVZXkIwE0TBVZCjUzoaONvqDlV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591811; c=relaxed/simple;
	bh=vnxLhaj6tQ8Clxuh5zpbuIzE7N05yzLZnFlnrerBSX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXnA1R8qnv/OnQx0kIZ5ZHat8F53nz8XsiW93wGgvvXkyRMPMx7QBXFHze6L4tefA96n8vBX/C2VUqBUGw8kR3JuqWnDFg7U0wDuSnupUF+udeOSHyrZQVWPfzjRESw+1/IyVOYfYMRg0cJUdSNhz7qc+0GhBD0Ghk9S8d2h5n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OAx6Nlv8; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAx6Nlv8"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6689f36ae56so2423763d50.3
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 20:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786591807; cv=none;
        d=google.com; s=arc-20260327;
        b=Duka3sev8aKRVOVigTmi944YwMHnxuFxd3IZyyHKwN0MVhcUAuJbFbzecvNipa7yOj
         6iVpKrK7Z+SFkwZ000G7fa9G+s1Mx+9DnyIpdHwgF4Ly9E7+JX6Vqi3NY3xj8CQUSE6Y
         pVh4LKOlyDsR4u35c3JVGI20HctpHWOakQo4LrWx/usdeSokKN8qQyVwhiVBEttGU0GL
         FmpFCPd/56Y/7k0SclQ5N1FKfHRZqXqM0VEt5+FmqGIbDV2cajorIHP+if6dzWBCAUI+
         vpSP7zi/JD55mwXqhpc0kAYoaCv1bEYVHgFvTPpft48O6DMX6OWjq04XVH5r6lMOGZTf
         UFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        fh=vDlGjDreWjCU8VfZp/kzAbPp5IccsZJv73dElmJHcdw=;
        b=W/YgViOv+8ZHH0RuPBMb3n6Fvfg7zLyHiqg1RrPK0mtnpyTDO3tW+MmkQm03ZEqMnz
         tFHS73/4hHEdRtW1+7GEhbyZrHyNCkxrdR8x/jGOwImHCyyNx4p4ZWJwmGQE3LaNg9dE
         6z62zJVz7dvCzQriHwlh5/8B1UYzZzaH+6XM/LndWnZcQk7Ivl0kt+Rw5fFiB+HH12bc
         TmcWVDvrb+4yv2u2go58Z0P4CGAlgtp/K24F4/vx+0y6tfpnEfxzkF/xAjLLQ8mOvaI6
         OuIwD8k1WXDL+9XM+ueFwbE1wGVupA1AFmXbNpAA0fNdtvTNP1n62181GEcPURr5eo5i
         dHYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786591807; x=1787196607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        b=OAx6Nlv8Lp8VNM9MU/S2oPBY4HmKAsc1e5D0gwad75hx3KEb8J5Rgqr8Nw6SBtS6E2
         GVLLlhrAuR2/fd58PauycK1DITwy+BOUG6VJquh7ueOBsOTg+laEUF3x/3UR6c+FDF7u
         4dYkpKQBPHt3xiUuku9no1UguifURSfKH02p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786591807; x=1787196607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        b=e2+iUjlU3DQSCyV0cRbOgWMAF352jesRVBXp9zEAyI6E16Cli1uLBBDV4v2QIfcott
         xCo3U7HUrMMbKv1k5P8ufk0OJ87G5PN8nTOpv0yGeTBBFCeZrJqlxJrVr5rIqps+8rP9
         x3ZyxFqneE4L8J0VjHDLXuzE0w7vccFqir/qxDHFCb+9x0P0vFSGlG6Dc1SXJFR5g806
         OI2F5nsM6z5wZso//6UuBgRYU8iB1Qx9atxz2fpcqA+KGwrRqxVWXXMP56hRXfsECSEQ
         EfIFZQBsxinD+RtM2af0HyQ61k3XMOc6l85Aj4TYKFjJdZm0VHVMAiyhVc3t6/WwMdAC
         svqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqB72IB6w1p9WHqUeY80my0R5HIj4drc9rjKBHto3NmqJWj6pLZGUFW9MP4D6EA2eECh5yB8WL7hiFABA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgeKDkSxcqD5NT7D3+dko1mCcdQm9JFVmOOt6uTr1L4nD1lR7
	sez+nOq/f+5qKcljDbrZwEeHBwdKk1GSECHzDDqV/U/QrZsazlV5YX60V3sGE1v9A0mF7SB0TNI
	oGXrakWPhPfO0FbFSsg0Z7XjSdMhxQH/w63ey7sHG
X-Gm-Gg: AR+sD12l1upRW05szjtqAL9VEP6rfLADE5TXIdr2TpxD+9MW/dpyf2ElC9aQFI8Go1r
	egvzwig7b5niDQ5TH1xz1o0moNmN0Z0e4qZMLTlVDVFl37Ouit1rf3uDta72KrCt5Cel/WfEZ4E
	qzC1p14NqYcsRJNss8o+eBw7urbX+bX8D9qt+BwIv1q9l/vE+bubuj/zZ0XL8ZN9v6bYM9LV9Pu
	k36Hs/5SGd4IpEpU/WZyS4HW1E+Treqkr3nWyH40x/cGaqIoqw7VELSNaKOOpK51RuKS3S8CGCu
	WVgS4E4VPbQ6gAjRyAptnpCTLmomzG3gA3SNGbxaPxJZ2mDi4v0OfAHqvpKISrOcgW8q578CdBR
	pRKy95TOrYg==
X-Received: by 2002:a53:e5ce:0:b0:667:bae0:e565 with SMTP id
 956f58d0204a3-66c515b62fdmr981398d50.30.1786591807078; Wed, 12 Aug 2026
 20:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811122011.3539250-1-wenst@chromium.org> <20260811122011.3539250-8-wenst@chromium.org>
 <an02idvk4GtZIMfn@google.com>
In-Reply-To: <an02idvk4GtZIMfn@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 13 Aug 2026 11:29:55 +0800
X-Gm-Features: AUfX_myrCG3oNTwmlZwHDJSbsoCHFr7jcGIFmX0-QgCkqwSa3XLy1HbTAXteqh4
Message-ID: <CAGXv+5Gf0sYKvvd=JsdPsahvHCKr5rk+YiVu6SCY6ZQicJzd6g@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:14=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Tue, Aug 11, 2026 at 08:20:07PM +0800, Chen-Yu Tsai wrote:
> > Up until now, the MT8173 elm/hana device tree has set the dedicated
> > regulator supplying the trackpad as always-on, simply because the Elan
> > driver was missing proper delays. As a result the delay for the
> > Synaptics trackpad was also omitted, as it was not strictly required
> > under such a model and delayed the availability of the trackpad to the
> > user.
> >
> > The Elan driver recently gained proper delays after power-up, with
> > adaptive skipping of the delay if the regulator was originally
> > on. The I2C HID driver and I2C OF component prober library gained
> > similar adaptive delay skipping. The device tree will be fixed to have
> > the regulator not be always on, and proper post-power-on delay time
> > added to the I2C HID device.
> >
> > Also add the post-power-on delay to the ChromeOS OF component prober,
> > so that if the regulator is off at the time of probing, the prober know=
s
> > to wait for the hardware to initialize.
>
> > [...]
>
> This looks harmless even without the aforementioned patches.

As mentioned in the cover letter, it is harmless, but will delay the
probing and subsequent enablement of the trackpad.


> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux=
.git for-next
>
> [7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
>       commit: 81c1c0cb68a13d14dd1bbffcf4c49e26f9a6478c
>
> Thanks!

Thanks!

ChenYu
