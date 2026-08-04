Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C541A6809
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811841; cv=none; b=EffvButyRShazPOWFIkOfpJxpbNTnSnmNESxFCu2Gpcl6cxQip9X/6BukrvYuWlDBxD/H62J4bwygRodQrURCfBQA9P7w96Nux4SwqqaPtwJaCjbUtpLX3yHHd8rKKTzWkVPZAtNa8MqtT+dVY3TXrnEZmAEmKlKRiAzIW1w1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811841; c=relaxed/simple;
	bh=HutMG7KAG/Bx9Rj8ElbrqT/jkccEafBBRKmOViSfxKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfhTw+o7JJXF9cr2Tra8l67YScMGP/Sthqr3cqhvOP+T5lDoQRjm3r9/OSI6khJe5V1EVNmgKNR258FyDe2UdRgHgHOJmVL3b+aEiTBlmEPOW9LABOal43qXCwA2endWjhsElhDsCB8oJ16H5knlq1cUiFli5wXM9zBwCyPXIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDaIAgjw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDaIAgjw"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ee50eb2db4so2886551a34.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 19:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785811839; x=1786416639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ek3HDMGwTzbO92vhRJd9hGiEBc7MF6sqhREDMAAlYbk=;
        b=NDaIAgjwopjiH4+Cbnun4g4Lwlm/AU5k/DrzNdue/i2EsOtQJlhLBaR2drAjqVq5UC
         9wwadZ2wBi/xCRYzKtTfuLduRV9xsmxxWZbiR2xel9b+cgQCQUmp14kgbVFDBdmcu06Z
         Ow9mnZYanK2C5opUxo2hJVDvdw4tvoAXYCz/WCfevwV7ii5XSJxj2RDZTXdcRdcwA0AZ
         O+6Ut9XD6HhOBbS0IRiPrFuROdWC1WL9y2hgaJ7dBKezdvxu+0tQgHbl1GiqohcMBszu
         HahSbyRy8BNDE15TyX85AT2ei/cg4kVfcp7d0j0RTtHuR6qztLp+jLZ1pYp6DxhI6WZj
         r9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811839; x=1786416639;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ek3HDMGwTzbO92vhRJd9hGiEBc7MF6sqhREDMAAlYbk=;
        b=IIQ8r9/inbLhp7AsA/kDg3eevYYIdNCR6N9VSkfs2uJVLA7DpjQDd0nDtQYu8EupAH
         uCd+BwRsGRw49OrVFeiYfL98ZVVvSEKCoQn2Fh4dKPUSsvWQO4ZaZkEgR2CaDyh0HwNu
         NPKgvy2s7kJiaZ74ElcMYzHMeGFbWoaA5QIYpXi0cJaCLka88AZJaE22ZSSdxQic6ObZ
         z0e8DU9cmgpU2khfbzpl2TLRixxeCpFS03MF4pjMg/fN1ndwLEKpaHNGBA0qZcw4AX36
         KFi5IQdGp05igMJIW+Dze4D+1UpM2nGTzgQK0vu3Bsa8677JfXkgzM2Hvt4/Xx/iYBto
         IfsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmwYum6Qs6ZhP08QTe96yQD1C2AKwdZ8DjRuwVk3KXcBenMv/1BNU9rlVkOU8TWvOWz+RifoFjfXpTKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE6RNQ9X3zRPYh8LgA1vtMyWAHBwKI6cgS3MqeRaVcm2wx0ep
	FOU0gXwSVJa77BRZjXTVR5FyRispHqNxZHveGm4nVRWA0ReyUp6v8K8/
X-Gm-Gg: AR+sD12kE9pOLKDhFpFQ/WWjJxjYUEGnNZN4FoRFcJBr5jyozERC5IBy6SkOutggKCa
	afZnI+R+eNg2ierrvybK1saAMuW3/Av9mEu0YhQ4TDpnallvzKbb3v5pBZlBMVsW750BfK02ySQ
	wkCwqkpU8UadfNtNDHwpcSy9QsGcAA53g6TnbmXQsQH7C2dTLTNIjqjfsNdAZGSiQNq7MNtHiA3
	bFvyBTc3uCihoQj9bpKJgf5fu1jAVsWD5YTiaWyghbko5beytXKCNgxVYoD2nDZ9sKH2XEyCKGY
	Dzp5CWEmEaA/x2AjLjBSkZiI79iVpHoW26HwBF+2REDNfKiYDy1SzDd233AVdeO0yjxoF24fqzt
	n6tflRCUE+T4drQ32iBWI37XoVSCjVjm9eQlaPh/0J6KSYQdeMye+IosyJJACldRnUP5sz7Xjpf
	RN1DqKwgBmokvK8B2uSj4I4uQIqLntoufDRMXfI34lETBi82i8x5f0XLZwpWSr
X-Received: by 2002:a05:6830:6a8d:b0:7eb:d848:c867 with SMTP id 46e09a7af769-7f196be5f52mr20079979a34.6.1785811839172;
        Mon, 03 Aug 2026 19:50:39 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3e3d5sm8516343a34.3.2026.08.03.19.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:50:37 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Alec Hall <signshop.alec@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH v2] HID: magicmouse: avoid NULL pointer deref when there is no input device
Date: Mon,  3 Aug 2026 20:50:05 -0600
Message-ID: <20260804025005.2389635-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803033711.17170-1-signshop.alec@gmail.com>
References: <20260728184059.688513-1-pepemontfort@gmail.com> <20260803033711.17170-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Aug 02, 2026, Alec Hall wrote:
> Apologies for the near-week delay in getting back to you -- I was away on
> an anniversary trip and without physical access to the test machine for
> part of it, which this needed. Sorry to have left you waiting.

No apology needed -- you got to it faster than I did. Thank you for the
three reviews, and particularly for the fault injection on the stale
pointer one: reproducing that state at all took more effort than the
patch did, and being explicit about what it does not show (a real
input_register_device() failure, and no KASAN) is exactly the caveat I
would have wanted stated.

> Interfaces 2 and 3 bind with msc->input == NULL, as they always have, and
> there are no probe failures in dmesg -- the two "magicmouse input not
> registered" lines per plug that v1 produced are gone.

Good, that is the behaviour the v1 broke and the whole point of the
respin. Thanks for checking the Magic Keyboard on the same host too.

Jiri, this one now carries

  Reviewed-by: Alec Hall <signshop.alec@gmail.com>
  Tested-by: Alec Hall <signshop.alec@gmail.com>

from the message I am replying to. I mention it because you have already
applied its sibling, "HID: magicmouse: do not keep a stale msc->input if
no input is claimed", and the two are a pair: that one deliberately sets
msc->input to NULL when the core claimed no input, on the basis that the
NULL checks in ->raw_event and ->event -- which this patch adds -- make
NULL the safe state. Applied on its own it turns a dangling pointer into
a NULL one, which is an improvement but not the whole fix.

That is also the answer to the Sashiko review of the stale patch [1],
which asked whether clearing msc->input could leave a NULL dereference
reachable through the early return on the USB Magic Mouse 2 / Magic
Trackpad 2 path. It can, but that is not something the stale patch
introduces: as Alec's dmesg above shows, the input-less vendor interfaces
of a healthy trackpad have always reached ->raw_event and ->event with
msc->input == NULL. Closing that is what this patch is for.

> a device with a 16-bit or bit-packed capacity would read garbage
> silently. A guard that falls back rather than mis-reading might be
> worth it.

Agreed, and thanks for spelling out that it is not a regression. The
byte-aligned assumption is a real limit of what went in.

Worth flagging here, because it is exactly that and has had no replies
since it was posted: Mason Camara sent a series on Jul 12 that records
the field offset and size and reads the value with hid_field_extract(),
so a bit-packed or non-byte-aligned capacity is handled, and it comes
with a UHID selftest:

  https://lore.kernel.org/linux-input/20260712044702.893825-1-ping@masoncamara.com/

To be straight about where I stand on it: I only found it after sending
my v2, I have read it but have not built or tested it, and I have not
written in that thread yet. On a read it is the more general of the two
fixes. I will follow up with Mason there rather than prolong this thread.

[1] https://lore.kernel.org/linux-input/20260729043135.9D4A51F000E9@smtp.kernel.org/

Thanks,
Jose
