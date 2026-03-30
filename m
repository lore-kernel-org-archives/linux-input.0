Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078B3A75A1
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907825; cv=none; b=blGUimuy9yp4HlAvYRTBiCUiifxhsy82A5syLmzx5qUMQkQ/MSBoTp+3MaiFHxQI+fh3NlL/HFaSxruxwJbPY4pUOSZN6RaLpIFXC/01zKtBdgYuf8xTAEi6ZSeQ6B9wVeNSY/ascz1iw8CeHKAFkORFMN9h8VURuN3e6/w8hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907825; c=relaxed/simple;
	bh=9woQ7/fKlrxTFeXRYDNkyTlKx3TV9a+ou2v1wOwQDog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFXv9+ra+6eGMcXG2BEd1D1iRICuzFuOf7La4DJu5OHuZIehtsLfSTm1oXFUnUOxF2lmCQQh0Vh/ZsjS3Kz9/MCTcm/7KnP7UpluxG+0U16rbYHfW+cwc6e+8yoUJF7tTApOjU3VGWLhPh3xUNH7KNx+ZlD10w3cPmkoW8sH1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seFMp8lr; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seFMp8lr"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so625723eec.1
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907822; x=1775512622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Bb0pi9FepnSALzc4+JxhpF660Vu7lbr+LdKjGQZik=;
        b=seFMp8lrtylW+pvH2BuFRSF0zK/F/cC0yqyd+EYJbhr2x1bo6Qlq5pjgkVabNju7tS
         K1BBJWLhGQDfoVSSoJJBINlc0+kHwtFL/CJN9N4/ioVIQzuPl+2+lXTnxIqItOWmz+Os
         pitUWQAuGt8a/B0BFMTePHNJkUfvRA6Y8WI/QpuhZoI/GfJlNvjqxjClOus/H4DPe+BA
         mpxa7JUxF6vb1FDV25fyPGkBQYwFy6wk9+YwvMx3DG1YPUkS3OJP8mE6BIhQtoAPlBWg
         qZ6ocSAVaNddnEtR13Y9jHp4kjPNlfQD/NDtTQD6a9ua1y14NTCtwszI7s0IJpeC97Og
         anhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907822; x=1775512622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+Bb0pi9FepnSALzc4+JxhpF660Vu7lbr+LdKjGQZik=;
        b=P7yDl4Vz96I+yOf0Q2aJflgmXrHBUTUUFU2dIfCB3X2FdcmlGgP4HWrNnTSEmU7/o7
         Ti+moOcTnFMkcWwJl9INU18n+pgL86KpehqHc0mKzXtesm0oEiDaJm3tLQ+QMkJPOjRq
         G1GjilpAA+rQoXErBVVr3MdUiF95ys+3aNs/hmX4Q/nmxuc2zockM9XTHgV8+ODqAKuy
         RQdbza5sfCi7CUGLaU9f6U+ArQQBciqWxIwpmlrKcvwvK+zboXpSR30V2qr4aFF1m/II
         PPAHWZnv8VRDSiNgSY6PcpDEqZ7eQoa9nqsprsd9s8WMs977fjfqVzV59pfivfWRiAYq
         KyRQ==
X-Gm-Message-State: AOJu0YzzpCCzZvpH+BDM/mky8Ny8gUVxAYcm344l7HUAWGiw+nDzEGOm
	yo+r1e2NLHobtt5vmp3agtuUhtzB71b7RiDNxcDTXix5uRAmp2bZkwYP
X-Gm-Gg: ATEYQzzXbM/1Ywei6rBMH8VmtMkzbRH4MjHgCqyvyYR9S/oT1b+tWla38vu9nfZGW+N
	g7ZUrrAl7eI/mqC3qywF3TksnKmsQcZAZCXFYGkioI8fF8Dv63UQapV0Ay7Hupd/qDQXTa6ljoS
	NodUPkBUQdafVIdphMTr5nh/u3RLYILkZZDEjt2IGGu0NASwZNCImOBEtpDg7iDykIbXXCeBmFE
	HRaLKUb/7kKSPkuqw+uiVjkuitZ9wkru/dVRrLmnLZJnurgVQh4eoI+Lrji6hGGxel7AW68Pizx
	TMaOQ9aIvXzaY+caJ6+h2rBNOkurzudtQYgLSsToHS1NXERP9gDNpyeFBouB15uhYjpYbLhqZta
	gB180h1q5s8xiNY8C4y/WxbqD7idqNk2Xu467km1WHGuqOQ/vhfHi+UbGsq6/lS5ejzQSfRv3gD
	q73lyP+1tshERwqwucmouFOICqxEJjr8RBki6l3mRBZ5OaDPFXMV5xeM6MEFS2iJq8
X-Received: by 2002:a05:7300:324c:b0:2c1:27c:75bd with SMTP id 5a478bee46e88-2c185a67c89mr8201566eec.0.1774907822346;
        Mon, 30 Mar 2026 14:57:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2721sm7776979eec.14.2026.03.30.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:57:01 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:56:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hbarnor@chromium.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: atkbd - skip cleanup when used as a wakeup
 source
Message-ID: <acrwy_Y6QMapp5fw@google.com>
References: <20260330-wakeup-v1-1-d269624fa519@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-wakeup-v1-1-d269624fa519@chromium.org>

Hi Henry,

On Mon, Mar 30, 2026 at 12:01:50PM -0700, Henry Barnor via B4 Relay wrote:
> From: Henry Barnor <hbarnor@chromium.org>
> 
> In systems using suspend-to-idle, the serio core calls atkbd_cleanup()
> during the suspend transition. Currently, this function unconditionally
> calls atkbd_disable(), setting atkbd->enabled to false.
> 
> This creates a race condition during wakeup: when a key is pressed to
> wake the system, atkbd_receive_byte() is triggered. It correctly signals
> a wakeup event to the PM core, but then checks atkbd->enabled. Because
> the driver was disabled during suspend, the scancode is discarded.
> The system wakes up, but the initial keystroke is lost.
> 
> This is particularly problematic for platforms like Android that rely on
> the input event itself to complete the wakeup transition and turn on the
> screen. On these systems, the device wakes up but remains in a dim state
> because the initial interaction was lost.

This is really for the Android system layer to solve.

> 
> This patch modifies atkbd_cleanup() to skip disabling and resetting
> the keyboard if the device is configured as a wakeup source. This
> preserves atkbd->enabled = true through the sleep duration, ensuring
> the wake-up scancode is reported to the input subsystem.
> 
> Note that this also affects the shutdown path. However, if a device is
> configured for wakeup, skipping the reset to "default" state is
> consistent with the goal of allowing the hardware to trigger a
> system-state transition. Modern BIOS/UEFI implementations perform their
> own keyboard initialization, so skipping the legacy reset on reboot
> for these devices poses minimal risk.

We unfortunately need to support devices much older than that, so we can
not be sure that this change is safe. Historically there we a lot of
instances where systems were unhappy if we attempted to enter shutdown
or suspend paths with devices in state other than freshly reset.

Thanks.

-- 
Dmitry
