Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A737AA9E
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702948; cv=none; b=doAN3wpVcF5rgxZlrtZS3gn7xiNAyn33xtLFiFZBowy0WVkhMj3FQVpIFQ6uFnogIUM3YvRHtmE6+/VAZ1qlH2NlqXM7A8xgq8OoWz+Tt6z4qWRZPmLJnDKrSRRY6TwY1xo777kAhJ8mNjwKlDEUDbBVtl32y2vZqoHQfK93oAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702948; c=relaxed/simple;
	bh=NCnkL09yq/ZbgV5OpIBuVnAcKZhxoffH1DwX/cYV/9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvxFGiZqvCQ503MRl5tYUcLuFPo3hKLnSnoaONaklamZsj0oP59aZ4/jsOE/gocWYN7t+ecdEPZiFTAVeMrnnGhSsklEAwcZ70y2QKqSPJyXEVhsQD1ozX2LVc6N4hywuCREXYVGRsOraB4dr/nLOXMxbmjA1lVi40ALM73sr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmkgiuf5; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmkgiuf5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso28248205e9.2
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790702945; x=1791307745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCnkL09yq/ZbgV5OpIBuVnAcKZhxoffH1DwX/cYV/9g=;
        b=kmkgiuf5e9WUQfSDfKmaYRbqLtjTFm+9n1wnTFWehnedCSoG2IlT2XCNURVSrtQFRd
         7HzmImYloA3ELsogTL+DYsA/prHXbwrOAEQZvVLzhedtiFjsXibyEVyWkMybeymKWRl1
         CHylpEzvNy2Tkoqw15lmedYSaRa+qRxYz+Nkb1E7b+Qqnc+is2URyfVqEve6gxzoE15b
         Q6bAXL01I2ltCcjnA/z4Q7TNoCbvWEG5NsqmMXcGaY9mvSppVnqxxWPG+gjfJQMIPnV9
         HXKl0nr1S3/sRwJsvg4PQtgWSxN0uWWQQJEN+KQJwv8IO4IKXShcL9RgwXIQG48jiqXq
         qCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702945; x=1791307745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCnkL09yq/ZbgV5OpIBuVnAcKZhxoffH1DwX/cYV/9g=;
        b=20S5Qq8PbdEu6BHTRPhA82Q7Eq7/pnRmL1zWt+eD+W7R8ddv4R3Kf8e39F/iWs0eXY
         a7k2tE6KoseBfy8/3eZxjj6la+daiiv8fitlhkoUJY8mCMwaotTVI8cGnp/L4MdLZ1xy
         rUQnoa7PupqJMRJj8QZf/gy4j6i4cDYD4cR5InfonwV9k6Hg3euhcbL3iiH0A6svUVRy
         RzMswj9PzRQ5tqC4UvUrDPv7kKbcqQTexsryyrXK8607R9OzSoRaRR25KlcxgwScd95U
         PEoxEm+H18gFamkI3G9C7ImQ54g/BU80f4O1aF1/IwvMNbIe0YJ6anJhpbznuxfKRN46
         AnsQ==
X-Forwarded-Encrypted: i=1; AKwUvByanpu3MkcNAda5WeG19zfaO2cv35wz5hifqh7s9Tj7Kpva6k6+8VHQzoFysgkyMFNV6QmkG/deGxjBgA==@vger.kernel.org
X-Gm-Message-State: AFuF++kKmv5l+vs3te3UaOfDYBXhP3aYtD8jWZGkmCl3o8CHRIooY+ru
	aTR6NuHNjryZwG+Aih42clB5uTMSUqJxRzfw+xy5otWbc5C0b7PoTncN
X-Gm-Gg: AYBFou2NQRDI5V3tV4waSccgPa7nqaHQbHQjtDSLEna6MiTFKFWNy1FT0EyJe83A5DO
	8Ch2Lx85lTW08HQWfW+LrHiWRD016wWLljG//e/DxZKK/vUBvBLpMG0C0A4L8eg095jZfLMRx15
	7aM65IHlOnOUNvXkQRURzlj+q9poutvpW1EpcJAPwobkP4c01w5f/8xk7Hpnf9C988Lzv2zQLne
	LYPfJwAZZ+IOBVjQvAhmY8gXeADcCka5Wpep/YLHZ2ixbRui5ST8zFdhVVunPnjOYOZR7i0ZHXx
	PcZMmZdDLn4qj7pdo8qBlZcZIHtKZo6EtY/qec8sbbI7pWJHVddVyD9Aqooyj09SRm6kIweSeZ5
	+I6OowpCnRAGKC9tcPDrGjMk5TtEV4KF8UnvMtKNCmbc0XzNvgaFry8sHhqY6hWo0C2ZR31lfvH
	7yUD6+T3f6MuiXqFcoVoh+9te+CwUaY9iRcBjlG9lytwq70KrRSxlVPUqhEbuFN7kZdSKvg00Tz
	5Cbt+l5veRUl3To8m75+dSwEbobt1xdgfpDSIL6ZVScaFOiOzipExDDHV9F01x9LFELbw8K4/AZ
	Q39O4Q==
X-Received: by 2002:a05:600d:6402:20b0:4a0:98c:596f with SMTP id 5b1f17b1804b1-4a0098c5c28mr65592195e9.12.1790702945279;
        Tue, 29 Sep 2026 10:29:05 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01489a590sm3572765e9.0.2026.09.29.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:29:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	mikhail.v.gavrilov@gmail.com,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/2] the Topping M62's vendor controls, on the component framework
Date: Tue, 29 Sep 2026 22:29:02 +0500
Message-ID: <20260929172902.210581-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
References: <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Takashi,

A gentle ping on this. The problem is unchanged: on Linux the M62's
preamp gains, output volumes and source selectors can only be set by
hand on the front panel. v6 is the component split you suggested; v8
stays posted as the alternative.

Since posting, v6 has run on the hardware as sent: all nine controls,
panel and ALSA following each other, fifty module unload/load cycles
and the cable pulled out mid-write three times, under KASAN and
lockdep. Nothing in the log.

The one wart in the cover letter is worse than it says. Reloading the
HID module takes the controls off a live card and puts them back, and
ALSA reports that correctly, but WirePlumber does not merely lose its
faders -- it segfaults. That is for WirePlumber to fix and an issue is
open there, but it is a cost of this road that v8 does not have.

One thing points the other way. The card also reports its battery
level unasked, and the natural home for that is a power_supply with
device scope, as hid-corsair-void does. In a HID driver that is a
small patch on top; on the v8 road it would have to be registered
from a snd-usb-audio mixer quirk, and I cannot find anything there
that does so. I have not written it and would like to know the road
first.

So the question is the one from the cover letter: this road or v8?

Jiri, Benjamin: the needs_remote_wakeup question is still open --
whether clearing it after hid_hw_open() is acceptable, or whether
usbhid should offer a way to take input reports without it.

Thanks,
Mikhail
