Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08D36D9FE
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785554; cv=none; b=JWbTh3XmxdVcScNG8quSTOmJ0eWWHp+fDtxGrl0dx/9njMoHsALCiE3QZD55u5BtjuoIH0GOiy3iWkRf2NfYI4yugX5SVjSkkg4z/Rdkb9JLduYvFC3EJy3wzWbVAI0N7rlv2JftYFMBM1jmc3s80Bod/VNMPUQVN2/NLZ7HEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785554; c=relaxed/simple;
	bh=zZXbfruO/r/RWqf/E75oLX6W4C4wA0wKXl1yDwwK0Zs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=ZWNJTMRsOwTJnqfk2xRdEADR24K/gaJbpdNBC1Jr+Un4x9xz5SpNHjjYeqqylXStjcNjDqbbcrfO5zgYk90qz220pDhAsDZA6ojcvo6nEfmGPuYIbCT2VF2uTrjbmCf6wAOHhA/YPgDtenFdrYhA3zNUD2Y05Gq7SJj+y8D3nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8tDgM4r; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8tDgM4r"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so2230508eec.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791785553; x=1792390353; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HdBEWpf0g+zfKwHgHUCZB4RLqnwmfHXY9y3S77eIlQ=;
        b=E8tDgM4rs8KdG7AE2DyALGcKo4Og5/xmtTe70lY2GEFzDh5te340MBIXXm1bpiRDP4
         +J/+8z9Fik6QpOlAPSnUZYwaGbfO0VjIjHTPQod8Jzy6UXybiUzCyN/Hz9rZlTP0HRb/
         ARuJICMmv/1/mbVnrrZQyYit7s3LpGHh4OBfWsUuGh+LVMLC+Bt1oW/laCRi8FvTEieA
         IEmW2aiW79CyArxqi/DTCtMt1689AYqaNI8AwqrAGbHlW11n4dg6CNxsOmmICvQ3Iu+U
         FkhPpmpq61LTBp6WyWP2yzpZCQylvNeYYRJcpGWLVkP9+VIF+YdHzUlbE+7WvFhlcHs3
         NuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791785553; x=1792390353;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4HdBEWpf0g+zfKwHgHUCZB4RLqnwmfHXY9y3S77eIlQ=;
        b=MpkI8BhClYOR43Q7cakXmwUIOq4rTsOGC7LlZuFFwS+3NyYsAEGa6iWZCnn3U6gM1t
         3yof+GYyFj+SBfzdhLy9vrRIzw1gIF/fMqO7CLec1Q3jPhtXR8W7TRISoMJQXBNYlw3n
         dOlqlSSOxUsh2a6FXrtujQywVmePK9hQ0Mxrk1O4Zsq6W4i3nxvj83X+Mh1mWc3McgGz
         f6F7OjhD4qoVUaqHiaAW8JkgZ3jJQnb794+xFjqVq+kevo/JZrZXSOHNI0JeWVopPckG
         KsA2IVMjST1eGemHSTlZyOw1i87Y/c3wfP3CkTisQNiQjjcszZ3G0iHhoL4AgwjqSSlo
         Ok1A==
X-Gm-Message-State: AFq9FYIpcRXG5Zh5apnR+gPIMFfYhZKQFiQdIJJlHkt1cqV4vzVp1KYj
	N2OOn8S++EENK/8/IYg/XQh0ekP2ZmE9IMu4tumW06vY84uwNoZknale
X-Gm-Gg: AYBFou2hQvdTp+4B2ArOaI/ovfUpl7RCmTKaG4d6UHkhRq4XZDYhvOVX+zb4wOr6Nh9
	9ZAt83JhxBCQ1jBa0CU47MGOKhyM5kpqbpRoQb/NpWg7vySsUcAi2DA2NOBJv+4gJcLr3wfymE4
	fBWnBoAsCwu0wdvHPW1q/f72XBXrQ6BHk+xhHHCz/vd6ah7/k7Gcr18sFnROdx6RC3oiS4zy8KD
	FBLOZkdbBXA/r/RLSi9auRe7gGk7JRBqhsPmwk3TNAhohbY8UH7o46K7uJAZ3VO3QHQMSWaSxYf
	YvNBWFoywbkvi2xsT9a5oP8OAemru4hk0cswmnpih1QF1SVM0gW2FSOlfeLtxHs3yrcrG/Es5H3
	r/77Tz+hirCjMmOotjMsdsl8leB4ThkaULDI4nqC+uNrKleVoZZ8ogTVx3eKntseBVem3p8noqJ
	K/GJdqM16FJeK+zS1knZ9ONutNM0v8fn24OORb2AkWZTqp+CSB/1sUo2Ro3W0jLSlvCUKC1/2tD
	T29hYT2FuHDwXU/hA0L/u0fQZxy0KAcHdv61nc=
X-Received: by 2002:a05:693c:42c9:b0:359:9e84:dc99 with SMTP id 5a478bee46e88-3599e84ea9bmr4362357eec.0.1791785552678;
        Sun, 11 Oct 2026 23:12:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:8999:e631:ed58:366a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm29420009eec.2.2026.10.11.23.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:12:31 -0700 (PDT)
Date: Sun, 11 Oct 2026 23:12:30 -0700
Message-ID: <98c68af25f9fc08500eb818a6d77d0d7@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karlos Abel <kabel@voidship.net>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: discard pre-registration events and test state seeding
In-Reply-To: <179175785190.2.15570576039664484922.input-plain-reply@voidship.net>
References: <20261010180031.7-1-kabel@voidship.net> <assT056aFmzMHmON@google.com> <179175785190.2.15570576039664484922.input-plain-reply@voidship.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Karlos,

On Sun, Oct 11, 2026 at 06:30:51PM -0400, Karlos Abel wrote:
> The observed problem is the initial switch event being delivered later and
> undoing a subsequent Bluetooth soft-block. It does not depend on the event
> timestamp.
>
> hotkey_init() seeds SW_RFKILL_ALL=1 before registering the input device,
> without calling input_sync(). That updates the switch state, but also
> leaves the event queued across registration.
>
> In the unpatched hardware trace:
>
> At 74.486 seconds, Bluetooth is explicitly soft-blocked.
> At 80.300 seconds, Xorg injects LED updates followed by SYN_REPORT. There
> is already one event queued.
> That flush delivers the old SW_RFKILL_ALL=1 to rfkill_event(), which
> schedules a global unblock and turns Bluetooth back on.
>
> rfkill_start() already reads the initial switch state when the handler
> attaches; this later delivery produces an additional action after userspace
> has changed the soft-block state.
>
> Regarding the missing input_sync(): from reading the initialization path,
> simply adding it alongside the seed would be ignored because EV_SYN is not
> enabled on this device until input_register_device().

Thank you for the trace - that makes the whole picture clear.

If input core handles EV_SYN properly from the start without requiring it
to be set in dev->evbit, calling input_sync() while seeding initial device
state will flush dev->vals right away. Then those seeded events will not
stay stuck in the queue and handlers attached later will never see them,
so there is no need to explicitly reset the queue in
input_register_device().

I will apply a patch to input core to always accept EV_SYN events. Could
you please send a patch for thinkpad_acpi adding the missing
input_sync(tpacpi_inputdev) after reporting the initial switch states in
hotkey_init()?

Thanks.

-- 
Dmitry
