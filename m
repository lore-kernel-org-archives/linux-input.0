Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CB2BEFEF
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785731115; cv=none; b=Y9ZfSlO7kHL+0PNd4QJf7WHtDAtUWQ+JxQCViNbaHBSPklFc591Tf2cxwDedHqglZgHlbHCqNmBOWXn6rNetskddTTpYN5Z6e/VDylXSmcgRUH2FPcTSfDzUiXf2joz6itMHjhpqE/7mBw2D5aBR2pqSK+xJ7EF/K52hju3IdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785731115; c=relaxed/simple;
	bh=861FPllXTcOfUAezLdD2jUddgv/7Z06MOJFMG7Jmb/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYKq82d8o0BN7u72y5GzeHV6SI9WTNpK9v1hj7k8GuZBBffJsPs7oalEOd6fP9DEj4CdfwZ3MdgGvEy+e6NRFM3T44LDMiMizXuOQ6LceDOsVLwL1F60KVIcigtvejROv/qw2cdMDUNinXwK+r4quxSkE/HkevUfnKW6tNTujJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlMkdfUq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlMkdfUq"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e99ef0902so143226885a.2
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 21:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785731113; x=1786335913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TVEbE0nQ/U9vzp/HmZTzQ2YBEq1v0J1eWZOaU+k7PjE=;
        b=FlMkdfUqYk+LBFs4sYprTFDHy2KB+x4LCx+ZRXgsJ9QHcODoz3Xlcd0NEDCq2GtzuY
         rvkiDmwW/9HJaTLKn36SzEWUORdaSPs5Nya5o4FhRiYpgE3aVE2yfQzntgubz2iPHIBb
         sLsR9iFT5emUGvKKP9A3EcIYRSDPjB6U0KqjO982yt2Uiw4sFYhzxoL35vM0iTQUiczn
         79nx5VBdNoa5Z3j8V7CDjFbVzxUiIhqSrSNMpGHvxTguxleJsHGre//I8Xkq1I5H5PuR
         HMeC8f6p2sI7OA+bkEuUTcQnSL7wCVvERa1EujNIi17CMLXsoXo1FJf/rzRs6v6qbVwM
         HADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785731113; x=1786335913;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVEbE0nQ/U9vzp/HmZTzQ2YBEq1v0J1eWZOaU+k7PjE=;
        b=LqRbJGzRBqwcBYSG4oeXs+3cz1ZXVQna7AzzPcEvgqDA6rihrSFYg+fjgQYBAplJCF
         GOdGE+1yMp7SLxp19KhNXM2iUlAUd93JvDr2JNESlW7h5X9dDZJeyyBrlP3jdPczL/NN
         ltFOFLyZHEObToYVC11GQ8zKE6JweWYUyJJT6dX7L8bsWf8gHlwkSfzG8j8+Cyijyj5X
         Hcx39VOCc2Tk/umZP5BQ0AZmSQhUzKk4n24QMUWbGfcmDGWNFPT0WKRZru7sraUhIVDg
         PGLWGxVie8bHNbuSL/clITsZK72nspW43FSAVc+v5TtY2rZZD3+CmEjKGFSlUO3JG5pt
         7NQg==
X-Forwarded-Encrypted: i=1; AHgh+RqRw62BU/l8fQ21BI6X2HZHkBlNc5kpkqk/wHyRffaenmWSh80Ltbl5OEZLrMw8SmglUwHY+BUVcUn+pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztlds0/2xoGrFgJrERdPGP8KmntF/pXsRP5qBBUHuzN7RFswB5
	zfkGteqRQWPFzCIs4prk914nHYvPiwYFkvmb8ZbWXcR2DCtGf8NsUB7T
X-Gm-Gg: AR+sD12reKrBINaxxwoInnAAGVtRWEHYuq7XMR6iutd4WnMWMyNBVuZ5qSsL37dEsFm
	QAIAngkD2Wv0faLMwqPV1ceawk79qunPIpet5cNVxAww7qMsB+Cb514hP5we3RJHOcssAI/5fBt
	dOSgQhL4IBoGAmmP4Z/XR5LA7kxF7VnnQxN6kfEOY0sQiIsvB7fyhWkKO5GHQVSw4lfKFEi6qlD
	3nm1C7iV2rP2xll7Zf7Pw8iqJUTCSl8mOBqdHJ8KhGwDdt/8uIDGOnSJ2X8nFCnvxJ5+V0KcLrW
	6R3Zr1u47SoBASM7u4sqMJUZLJOHK1hy2r8F7XgW42GIHkYVdalqJ6t6xdaSxy7utoZsmGlFyXh
	8jAEgM9u3mfF5SX9lQ2YXsKlOuOL72Qce6zXllN9YnZUMuU2rwBUDVXWgNiYQ9M5ngI1FgKodpd
	rTpE4pSHyBu3gc3eVdrJwvS86DDOnB7kLgPchkujPxjHCP4D8I6h3hkiTc9HYZmN8DqUEKcvrWL
	cDiSSDiLn2I53by4h6t
X-Received: by 2002:a05:620a:47de:b0:934:9d7e:988a with SMTP id af79cd13be357-934a078e713mr1240198885a.12.1785731113020;
        Sun, 02 Aug 2026 21:25:13 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1df399sm579698385a.42.2026.08.02.21.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:25:12 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: pepemontfort@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: do not keep a stale msc->input if no input is claimed
Date: Mon,  3 Aug 2026 00:25:07 -0400
Message-ID: <20260803042508.34896-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729041557.1185819-1-pepemontfort@gmail.com>
References: <20260729041557.1185819-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026, Jose Villaseñor Montfort wrote:
> Clear msc->input when the HID core did not claim an input device, so the
> existing NULL checks cover this case as well.

Reviewed the path and agree with the analysis. Trusting hdev->claimed
rather than the cached pointer is the right signal: it is set by the core
from the outcome of hidinput_connect(), whereas msc->input is set from
->input_mapping while the descriptor is parsed, long before anyone knows
whether the registration will succeed.

One data point in support of the "hid_hw_start() still returns 0" step,
from instrumenting the earlier v1 report on a USB Magic Trackpad 2: the
input-less vendor interfaces reach magicmouse_probe() with
hdev->claimed == 0x6 (HIDRAW|HIDDEV, no HID_CLAIMED_INPUT) and probe
carries on normally. That is the same "core claimed no input, probe
continues" state your patch keys off, just arrived at without an error.

Note the driver already clears msc->input in magicmouse_input_configured()
when its own setup fails, so this closes the remaining door: hid-input
unwinding for a reason the driver never sees.

Tested on a Magic Trackpad 2 [Lightning] (05ac:0265) on 7.1.5, with your sibling
guards patch [1] also applied. Since input_register_device() does not fail
on real hardware, I reproduced the state with a test-only fault injection:
a module parameter making magicmouse_input_configured() return -EINVAL
*without* clearing msc->input. hid-input then unwinds and frees the
input_dev that ->input_mapping had already cached, and hid_hw_start()
returns 0 -- the same dangling msc->input your patch describes, reached
from a failure the driver did not cause itself.

Without your patch (fix disabled at runtime, injection armed), plugging in
over USB:

  magicmouse 0003:05AC:0265.0022: hiddev109,hidraw16: USB HID v1.10 Mouse
      [Apple Inc. Magic Trackpad 2] on usb-0000:00:14.0-8/input1

The boot-protocol interface binds. No "magicmouse input not registered",
because the freed-but-non-NULL pointer passes that check exactly as you
said it would, and the driver goes on to arm the device.

With your patch, the same plug:

  magicmouse 0003:05AC:0265.0014: magicmouse input not registered
  magicmouse 0003:05AC:0265.0014: probe with driver magicmouse failed with error -12

The pointer is cleared, the existing check fires, and that interface
refuses to bind instead of running with freed memory. The interfaces that
take the early return bind inert with hiddev/hidraw only, and over
Bluetooth the device fails probe the same way. No oops or corruption in
either configuration, and disarming the injection restores normal
operation on both transports (touch, gestures, battery 76% Discharging
over BT, 74% Charging over USB).

Caveat on the above: this reproduces the dangling-pointer state, not an
actual input_register_device() failure, and the kernel here has no KASAN,
so I deliberately did not drive input reports through the unpatched case
-- the evidence is that the check passes when it should not, at probe
time.

On your open questions: f1a9a149abc8 reads right to me for the Fixes: tag,
since that is where probe() began treating a non-NULL msc->input as proof
of registration, and the commit message is clear that the dangling pointer
predates it. I would keep the stable Cc -- it is a use-after-free, and
"hard to trigger" is about allocation failure rather than anything a
device can or cannot do -- but that is a maintainer call.

Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Tested-by: Alec Hall <signshop.alec@gmail.com>

[1] https://lore.kernel.org/linux-input/20260728184059.688513-1-pepemontfort@gmail.com/
