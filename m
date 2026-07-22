Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EA364029
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733279; cv=none; b=aELdEq2KmSv8n2o/4EJP//ff8h5DYpnGRYEkavKqIKo6KFT1K0ipMN566FbW2NP+X4J1r2OgF6pnJf2F/rSk9Qwyiat/gL+l2Gplui631QudBnUMlLASu9DR5O6bQW0yuld91w5erg5XEBooyKoCGvfjVgU77yBPnxadVRIF2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733279; c=relaxed/simple;
	bh=y6CwtABwlRf6er3op/nlFXFjNOXQ8OUUKAXPRveav+Y=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id; b=icRCMzbV68MoQ7muRT2qxoXx+Qxhn7MJAUFjwB+rnmLV/U+PexmF5REytw3ZnbYQVQp4W5K3uitZ9hl5wN/d3eLEVjZStdtX6dvzfungXXJrEiIyiuGuFlkaCkEqiSR0F3vapmt5kIXOga9I4f0w9yL1YMS7wphYGACFJsf6AWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP2xQNGU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP2xQNGU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f707e5d75so2587691f8f.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784733276; x=1785338076; darn=vger.kernel.org;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eti9zpJvSNPAmX/EHNuYvxRKMiHJTkMYPD6nJX/I9JQ=;
        b=NP2xQNGU7uzXN7NKpt29aNsWbEKxgTRMseMGSRki9TWRPEH00h5vW4xdjJtKHvS3b/
         2PwgG173sEvYf8VKIDsOoEyYAbHszC3muvu9xbfH6o0laapFVR4kmYL0yofr5ZJ1qBUf
         vHgGJgaRLm3NbRKTvrhKSHEWg2lEpVjBCNAeoN4W4DSfcXGExICeVEaW26UyqqGHIfCp
         HAbVPuUIlges2xww0N9zNObJKPvP6P2I3wv+H8N0yJXzwMf0+7KSAEen+mCpt7lSYoBt
         M4iahcDuESoQI7WFp4ewh2p+XYEuXs5kqoa1UFFPZiVk4efg+MyZRsqnvnxEkqxJmi+f
         YXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733276; x=1785338076;
        h=user-agent:message-id:in-reply-to:references:from:subject:cc:to
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eti9zpJvSNPAmX/EHNuYvxRKMiHJTkMYPD6nJX/I9JQ=;
        b=R7gOYVA0rKGVBAofUJqpU0GC/S5GFV+0vL/XnB5UqElBfkZpHYI/NwGmMidAG2MD/u
         nJEcZn9lO1QY2DzQLaskcnqVBJvQGAitPK4dx41Www323ek9H0aw+GMIKV/yZBzuPcgr
         pPtALTy604MlhCn9d5ol8yjoVMZRY3Cr+c3KaVQdVAlQp5hDUuXKqBJ36iblQP2dtz1e
         tyaz3WG5AIMtkj4DogCj9BQJmbOkWNZGrGEFebMFT8tvwCM5D8aS22zHDeNh1wIrTHch
         Q8hxnBxdp01CEdRbQ2teqtfxev8umqZCgoa19xxtUKQ+Fi/5lWPoPzBxr6zm7q5UzPdM
         Qbaw==
X-Forwarded-Encrypted: i=1; AHgh+RqG+VE/H1lLbyxOLWIB7ibWNVWU7VaGw3O0KqpHJXzHnS4//NtJ81UiFEjmmutaysX8t2rR8VHdMRlj2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtwAX5tzLxnpeoY3pdzJyM4EFGgoCYTMUb1loBvw9cjys47KO
	X/Kx911bf/rjCRhXEylZlT6gFcoE45craTQ8ZQVGvv2epIRtfd2YwUyJ
X-Gm-Gg: AR+sD11SyJ7iPn06Q/AsJ/32YNoyAYIBpkKe0UpwsT+/M8Xbh59QhP9DHGTjL2IAug5
	A3LfwVh3odoGxOsrtD0nyUnkxrMlIJj/BVkHAbIlRcvEaAyJKMoxotXakoUVLmTScKIdmm17Sx7
	7JTuMEZHF9TbjYCiK/DTxuKPuIH8CwtENAR68CjAy7+NrCGLUV6at6G0woRoJS23TYHLJQJcXww
	jaj61JoK+HxHqIZ0hdJpF5OnoEJXAyKEGCh6beE3ROLBv3dK3VEEUTpLJ7zwKB6U7LLc2cLn1Am
	CHXh0gFI44CqUhWNpt/EidCuaWHEBCfkbCbRfKS/Hu05ov1Vauadm2ViGMzY9rUIQo20PXRUAot
	s4VQDSMlFNklyySF1T3uaxBu6XefuQW/6vWkx2iI/0CsDF3/pcIg3lToqy6WmqQj+ewOYUA==
X-Received: by 2002:a05:6000:2c12:b0:45d:4a00:b927 with SMTP id ffacd0b85a97d-47f6232c65dmr27014644f8f.31.1784733276192;
        Wed, 22 Jul 2026 08:14:36 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd77a9sm6473489f8f.14.2026.07.22.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:14:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:14:35 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v12 0/3] HID: nintendo: Add preliminary Switch 2 controller
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260715033409.3599913-1-vi@endrift.com>
In-Reply-To: <20260715033409.3599913-1-vi@endrift.com>
Message-Id: <1YVJPOHZLFLND.33IJ7VSXBKWRA@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Heyhey!

Vicki Pfau <vi@endrift.com> wrote:
> This series adds preliminary support for Switch 2 controllers using the
> same split-driver model as previous versions. This is a minor iteration on
> v11, fixing some nitpicks. It should be fully ready now, pending review
> from Dmitry and a HID tree maintainer.
> 
> Vicki Pfau (3):
>   HID: nintendo: Add preliminary Switch 2 controller driver
>   HID: nintendo: Add rumble support for Switch 2 controllers
>   HID: nintendo: Add unified report format support
> 
>  MAINTAINERS                                   |    1 +
>  drivers/hid/Kconfig                           |   19 +-
>  drivers/hid/hid-ids.h                         |    4 +
>  drivers/hid/hid-nintendo.c                    | 1682 ++++++++++++++++-
>  drivers/hid/hid-nintendo.h                    |   72 +
>  drivers/input/joystick/Kconfig                |   11 +
>  drivers/input/joystick/Makefile               |    1 +
>  drivers/input/joystick/nintendo-switch2-usb.c |  475 +++++
>  8 files changed, 2224 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/hid/hid-nintendo.h
>  create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c

I had another look at the changes compared to v11 and everything looks
good to me!

The whole series is

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

I have also tested the Nintendo Switch 2 Pro Controller with evtest
again so that part is

Tested-by: Silvan Jegen <s.jegen@gmail.com>

Cheers,
Silvan
