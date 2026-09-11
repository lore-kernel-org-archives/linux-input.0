Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392154A3F21
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144631; cv=none; b=SlauQG/hbczO0dvM1QzDmA99LDMZYaRGRep8w2TiSaU9iYS6S35cXHHq6p1KEiC8a5XmgvEsc0Ygn6OFfncCwABhHd8y3o344w6oVZQKX09JLXw4XiqiKRxeVvb/eYKcfv7zdgM6PbsgAojyYmHG9l78y+eZCO2aKsJL2eCKO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144631; c=relaxed/simple;
	bh=4mfLk97WGWUYO0LzVc/bd26XHKUDdtW1nlfPHmu3EKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op0qQKxeIAK9rrZ0/L9BCeFm0ocwgnjAB2DE2M89VjsMp0VUL1RVB9g4VTfUNh37yGPNivanZaB+uFUnoNFcjqpBgDQK5gal6lFB+0dbXUgjRG/t282NCL0G7wU9mWqYcy5mWZMhHXv5aJYiB+YrFEObvrD3L3pUPSCGSCTKNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsnlUFUB; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsnlUFUB"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so432235ad.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144624; x=1789749424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Z3nbbb1FAl9xLQpw8Rh7y5TS4mkzVFghEZ+69cMYSA=;
        b=FsnlUFUBuMlYjlrSnyqWYviUKVY0u+jcU6HD9lAFaKkbJzEKgC4qAYpwnNvjh8dMFY
         N5Kj8C0GVXBjmtYp02jgc/t96ZZGErkMGI6C5quG9FMp16gGBTOThaT9UspyR17AWjR/
         0ibAkMgRrsHv4FxrDIIdIV6yhA7Xs8MDtNqvpNTL9ZywG/4E5HLhXg8t0EkTalmLXGBU
         SwvZuu49OoqWlievrMOFp7rqkYSxDanTgep0AUEV+0XIHXTqg7cePeksolbY6JH6rFJp
         Zg9b/Z32yt5Wzq69gNgV6PsldK3PMIsQFDBCQFLHqoqBouqkE/y7NKQrf8XAzQYtBKzD
         v1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144624; x=1789749424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Z3nbbb1FAl9xLQpw8Rh7y5TS4mkzVFghEZ+69cMYSA=;
        b=tXqBOCvTAt2s3tJ3lK+kOQL7N+nDVoFywQiAYu9dm5Ojeltp1yh+N9624rUPiIG/ZM
         i6YxfNtuy3jFNEkchVNz+A9jrSFcZwQovxfwP73UulNCBsotpCxIF+BfG4fIfkvY4Cey
         OAE3dejnHyWOiiwRiu4WicfYiWWeN94m6tMMabys/gZiqqkfdMLQ2vbxw/jHR/AymKrV
         vco0f/yibBZJfuT+ULKnGBI7ZkNniHqDEM3VM0PzCRD9tgtQ1LO8jdr/9B9iWHlNuVBw
         Nb0XnpivbrIOq/H8cht44RoL0KeBzKig2eTFOT+1F7Ri+AtEmHaU3nKUeU29jPKyszZ6
         StPQ==
X-Forwarded-Encrypted: i=1; AKwUvByul/ww/DlwvC5/fOsVTUA5AAHoSEUEukNEbD/KTtFaFM4l9yfKPx5HVLpKbEU2deND7TtawRnixwDqWA==@vger.kernel.org
X-Gm-Message-State: AFuF++nm7S5k8S15NwyhvEaUfhX7ldbvFAvTb+FkMDVUDfOAoCEfxHt+
	TVerruO0KMlt8fHId1ekAITAQfSMyIfC3P9lArW4HF65sVKJSyQk9KlS
X-Gm-Gg: AYBFou0Iz0ZpoaUnk+JMma9C/363IPpH0I59CDpDTCC0KusN1YMocUXHrlgsf1Z8azT
	i1RgdmkvfBgMtECa+lDM0ftVGRz8YIGJbxRfcTl1Z56lX5MNovIbm6Eob9Z8SSpQPeMb1N4lneV
	3z5lbpo8Nuo3PWZkbB9llR15U4u2q3GnQllEm3N83JrJW9fmy47Owoy41DF4BklU1YFTUiAJXI3
	61kR9gzQvDXfqoQI8/KiwIjO+VLUfma+aRUFR1kEDJ7IOii39SF7FKz4ZDbeRfxj2QMzGXSHfFw
	Icj21YZnibs7/m+AMaHGrP2xhEiSq2NWejVbmE4jbBEuh3bUktbuLP9UCnGZIlYb4heqLsq8q8G
	J3WtogzaWOzc1qrJVBfNP4k2muCFni+nyhIa+CTIzhegBDUISoYQFs1Yw3Tf2PqNCD69GNH3GOq
	HHjRPo/AwoQe75d6J7K6OVVcjnYLhmTl/rd/Gvkr6vbNLohyiFc97Bt0zd23LdZ6re1lx0wTUg7
	yi3r0N+KetwqpBmomZ1SDu3bUklDG9yDjQNh7CB
X-Received: by 2002:a17:903:1ac5:b0:2db:539c:b7c7 with SMTP id d9443c01a7336-2dd2a46d478mr99060775ad.20.1789144623880;
        Fri, 11 Sep 2026 09:37:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7e36:d696:74c7:8be3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm8349902eec.24.2026.09.11.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:37:02 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:36:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Jansen <jonathanjansen@ait.place>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bentiss@kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] HID: input: map System Microphone Mute LED
Message-ID: <aqQs_lxGOREamXiO@google.com>
References: <20260904022903.607880-1-ait@ait.place>
 <20260904044705.1060507-1-jonathanjansen@ait.place>
 <soq55ro6-n7o4-26n6-6o52-24n4sq513nq3@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <soq55ro6-n7o4-26n6-6o52-24n4sq513nq3@xreary.bet>

On Fri, Sep 11, 2026 at 05:58:24PM +0200, Jiri Kosina wrote:
> On Fri, 4 Sep 2026, Jonathan Jansen wrote:
> 
> > HUTRR110 defines LED page usage 0x57 as System Microphone Mute.
> > 
> > The usage is currently ignored, so the indicator stays dark and
> > userspace falls back to per-vendor code in hid-lenovo,
> > hid-playstation, hid-plantronics.
> > 
> > Map it to a new LED_MICMUTE. It appears as
> > /sys/class/leds/inputN::micmute and uses the "audio-micmute"
> > trigger from snd-ctl-led, so the LED follows the system-wide
> > mic mute state the same way LED_MUTE (page 0x09) already does
> > for speaker mute.
> > 
> > LED_MICMUTE takes the next free code (0x0b).
> > 
> > Link: https://www.usb.org/sites/default/files/hutrr110-systemmicrophonemute.pdf
> > 
> > Signed-off-by: Jonathan Jansen <jonathanjansen@ait.place>
> > ---
> > 
> > Notes:
> >     Changes since v1: rewrote the commit message; no functional changes.
> > 
> >  drivers/hid/hid-debug.c                | 2 +-
> >  drivers/hid/hid-input.c                | 1 +
> 
> Acked-by: Jiri Kosina <jkosina@suse.com>
> 
> for the drivers/hid changes.
> 
> Dmitry, will you take this through your tree, please?

Hi Jiri, Jonathan,

Sorry but we should not add any new LED definitions to input since we
have proper LED subsystem now. The existing LED definitions are strictly
legacy now and input core has a bridge to LEDs (in input-leds.c).

I see we had similar submissions in '23 and '24 at the very least. I
should add a comment to that effect to input-event-codes.h.

Thanks.

-- 
Dmitry
