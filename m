Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424203E8C5B
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408637; cv=pass; b=YxMSEuP9AB/EEsTpG4SCOx4fOC+hCllZEgLA6kqvPuk4e3otDC2paRoXncK2Ex2jFQVR9CDVnCTCepEGZaucrwGBBkTlJDQVhhs0xgQ8MNkEKVcnkhFEkOnUoVnT32sTcG1tNXlIyVipQHj0u1+/4mnwc9K9X83W5wztNY5Nhhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408637; c=relaxed/simple;
	bh=D6T1+aWP7c4iSy7QS7Ri1LeFGDQSnemXj2qAHP30+Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFHb5Gkmo9GUaIF068JiFMuYTBRNDxzcqSNH5dtQ/GTWnYkxohTesHVB2e+X16Jr/qP26tAr45nSosD3b9FCCgX4454i7klPpeexkZeEZOtysNWeDSbl8J58tpL7k9zV2Scza9KOtNazCpUNQ6vxERdJpYdgKFVTSlatC+F6e3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Hk2EOjDI; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Hk2EOjDI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914bfa75911so1209723585a.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 06:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408635; cv=none;
        d=google.com; s=arc-20240605;
        b=hFK9i8zRQLzNhkj/4jK/rPA9DxsU/lxzo4bAd8HCTVgLHcUEcg4MMbt6BBiAR6Lx6F
         Zz8sveg5yrQaiv+UbhWmWReYM3YOiM/88xig2XkFXBQXzyAFo/Pk70b94Wukv1tMSw/i
         SW8P1I/Dc624Mr8M0ht7m1CVxO0HejRnAe7AbfBx3V5DRyUj1v3Ksl6AWkzYf+yrh3Pz
         0ZkczbO4qKwcevSncPx5ODIHJweycLinLjX2Fv0gwVdpCylZ+/5GbK2B5aOqHBoX9UPe
         YpwSBfCP63VKijUEmkLCwgMzcs54Fa4DVe6ADq56sdVCHZib+yfWVwi2xHzIEqV+8maR
         cYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D6T1+aWP7c4iSy7QS7Ri1LeFGDQSnemXj2qAHP30+Es=;
        fh=+F4Rr/AvEBIUrrXOhIzVWkhj9OQ5LAlZj7044BChDtM=;
        b=JV2DWNys/OlBLuDkARLevLNOPMIhQGWXBSNmmkcAIgPWcpfsjKTQhcM5PRyyARxwGm
         VkEpObgMLA8+4QnJG8cYlod+kcUDLw/gxjRBJfX7PSwKHaXUxAY6SDmnCQm+8sgNZuaB
         n6uPN+ovHYcYzhmqYWUgmvb2BVCwUW2WIEK84X4gXUl7wNVKIZwlyac9wqWqzkHhRxLI
         A5hYEbxuOYzkj+yf46XKa+KJW/PRo7HoctF9UEcWpukSR0LnrRQnbOJrh3FMRlUe1fA5
         Buzo2EI2w9kzxQVMqqJNKimBrsbxChCkWzFF+BXzavEtWfU5V92LLhk7ylmWyElOyUvB
         hWHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1780408635; x=1781013435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6T1+aWP7c4iSy7QS7Ri1LeFGDQSnemXj2qAHP30+Es=;
        b=Hk2EOjDI73H89ARBeJ1qUXYp3Y2J+mJMTnjF/nVrhpAlR/grN14mrJ/0D3R5AuPTXD
         EsDzxsTHmVcdbcrBq+RQXySi2gDB3elenOnYNnAQFse1uW8LfI0nPtaIBH7PV1YOOAOt
         D83Wm9tRHgedYC5yb/atImpiuLz58K3Rzy0Uh0ddS/yCGGryG+0SiPB5qKFZGIMg/n68
         vBqNtXRtGzeGEs/Jt+W2HfzhGq5as7h5fJClZC1U4nLEDDAeavIYbqOPmiVJMHdsB2Ia
         IbZT8DGjdjQh2UHvzJd9vyOrxEQITB0BXRH7Wzg+jnK+iTHTpS8U9nTcfLMrmUoqXkVR
         KESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408635; x=1781013435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6T1+aWP7c4iSy7QS7Ri1LeFGDQSnemXj2qAHP30+Es=;
        b=b4F5gnaRL7R39fTf0bMN7xyNP56nAmOeNms7zigw6S7HOGfUKIXC27yCXqe2BwmJvm
         AbZesLme7z/34VgzhDmvQMkLKLHulROzS0tdGa8fiPZtkoa9Z3NviLwRSGrdKua20bhU
         nkhaj/L3gNy5z0yuEVxoPgebfB5/sFOF2JOJZm1+Hu6UtcTs4MZMcRnIGSQCkp6JehLW
         4lAtTBOS4zS9DLQuBX/l6jx1eAA9Kx56DkHmtxMqc/4SOTQmkfO6fqLu8va88i/5fVlP
         GhOKJiD0zgn9jJsW0s2fW5BH/QD+PackwOMi+Tg8yF6rHJAoKv29ejo4x4dJWlF5evpT
         Y/Fw==
X-Forwarded-Encrypted: i=1; AFNElJ8jWU7y5/9tFSMCqErUizbrBDjPjX5YtKWCCXkDkLAOiduxfV+T5C5W5I3zfxncNJOFmDUCLJWiuQA/DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsct9h5+uTpI+tD3kAiVVcsdR681xq0pDgT1vUg9c7LQ8qszeV
	/TPwplNqhI097yNtn50hASuMl3p/n5zK7LjknX/hQPT1QMPEVb5MmiJa03K6fPV5atTS9lB49N4
	AiKIcE/ObYyeASEWnSn7F5BkcwTORx033gyR8oMMOhQ==
X-Gm-Gg: Acq92OEvw4GAkxqBlOaVUqGB6dlCDqtifdMwUr1t37iYYyLvcqMg3XzU/T+jLmMKD5e
	KGt6ZKLNC7SuST1WbquJ5BHPH3Uh+P6x0TDgnS9VT8nb6imUBfIvpUkC/o7SFfeZKtjzbFDMEaQ
	Td5TUzhXhpXdHML+kXfZD3pJ5m7hv9C5fzaIJXvlfrGnNTwj89AzRAoqr2h9fU7URJuOKqwW2zH
	q73b5dQnz5zHDMDatRQ+vXNkZoiD8tsrl+3sMU95Mc/sETiDOBckeAJ2pESqHT+r1myexCfPPrv
	bL5vjReQl1oyuf9KGeIdAhvwexgLpxWgOhOrUDYuH0J2uocK04I=
X-Received: by 2002:a05:622a:4c1b:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-5176628dbbdmr43293331cf.20.1780408635149; Tue, 02 Jun 2026
 06:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
 <ag8bARsGNVqA8xbQ@beelink> <ahBgYbMWR4VwFAy3@commodore64> <ahhjTbG0Ye-mP9WY@beelink>
In-Reply-To: <ahhjTbG0Ye-mP9WY@beelink>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 2 Jun 2026 14:57:04 +0100
X-Gm-Features: AVHnY4IyodIr2Tk_Y2chfBkDxaWZG7M4baxWmr9DXPM7pJRtp3UZf9XatGddwfg
Message-ID: <CAA6zWZL8dx+59JLatcHo2kffcXc-SYbaQwS05S04z5WZ8jnasA@mail.gmail.com>
Subject: Re: [PATCH 00/11] HID: storing pointers in 'hid_device_id::driver_data'
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"

> Agree, we need both.
Great, I will implement this in v2.

> I'd drop patches 1-4. I don't see the point of just rewriting the list
> of hid_device_id if we ensure we have just one type.
These patches really just enforce the use of a named initializer for
the `driver_data` field
in the lists and do not change the actual compiled binary. So, the
change applied is purely
cosmetic, and the modules touched there don't use `driver_data` as a
pointer anyway.
I do think that making the code more readable has merit (if it comes
with no risk).

> I need to have a closer look at 5-8 TBH.
Thanks.
