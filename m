Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432C17B50F
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777858042; cv=pass; b=KUtxS/PvQJyIPzZrk498RaZVqmw8tgBm/K8H16tw8HVXmIKWWXEYYpKv8vz3C+Mebyf5uqim0V44nbMA328nMXz4VCiupKxCVUQGZ4n4NyMMEyni9fV4cYRxAIuywf+baDiYUun0jz1n0fzk/qAedBqIzskMv3dfbtkj50BeLwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777858042; c=relaxed/simple;
	bh=l4g5Cnxwyg4GB/mKplMPUSrP+qwGfFb0vQX7A+4hzBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOOGZUSkYwWD68/r+Y6sa3Yli3cKklV9tzEu1NMiJrNRXDpyl3xgQdt34HGxeiTkgnxjvIn8i74sGN4zIYyChUxEoUeRTB3oOHXwhPlefJWYrO2PiAi8MSI781b9XX400mSROB65KJLstjViwhB54b1mNzuhVcKRIeK3iBw3u/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrlJO5CX; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrlJO5CX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a9f445cbso39074186d6.0
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 18:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777858040; cv=none;
        d=google.com; s=arc-20240605;
        b=gena1O2QrVgtlm2LDSUaXZtfvGXpDSyKoadHNbg/ACvPcV8h8kw+kivXHLFRpR3a+u
         iqVtaKhN/l3khXuI3AVILiMTIm1l8R6tj3pst6p1ppETnrd5Gt4ddvPnuUzHr3BNDduO
         UR1Sup3IHRZa2gv/lNlZymgiv2kcaIIqNmjIqQInMf+J+2T2Ck0DlLx4G0p/LiCQGjGz
         xeCaIjsSgCLTZosmVkEUzDaOm1aDfKv/7N0vgtAXZlw5t7Ofe9K+7xkE63l8V9IhiaxJ
         1EVEOeoZmBSIJUx/cM8x/PP7t66mpMlxm1xE+zqySdSpxRDqMjsEYt+SeiANNE2j09qj
         evnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l4g5Cnxwyg4GB/mKplMPUSrP+qwGfFb0vQX7A+4hzBw=;
        fh=VnX4c4MeEOQ0SRXlMUwd4rpFdcjlWExAR+BmAyo1xcs=;
        b=UryWJBEYpmY6Z+0QlhpZEMmDZN4S/7+eR37Ub7l7mZxS14xRW7F4SnEnx7XobZRCz3
         cgHHCplFPp++3GzyZCv8xIhrBYALSyibVFEmQiyiNg0Bti21kQ40PkwSKEoVufkp0AoE
         TbMr+WJPc7R6dDc/4Bqno5lXBDC4OGUgauSR57VOjaM7p4IA/J1uiHC6niqbTLiSsk0D
         iRydq4iWK4cVKDdcXyZ02uN/Fwwppjq9QyQGs/mk4JfVEAYQtzEjMJAuagu4V9aCg/lx
         bQSLd90rGdoZymsiuhrvpefZpKBh0UmOH40Z2GcQmvnEs0BvJaCWJLt0JBGTnZO0CSEw
         bOgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777858040; x=1778462840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4g5Cnxwyg4GB/mKplMPUSrP+qwGfFb0vQX7A+4hzBw=;
        b=XrlJO5CXaOkziiuRwTlDtkA2zp0FZ6YKZlOFOoce3oN82OIQcVc7aGHg6vduL+vnIS
         LxqGG1/CF5XVbTjSJDZ6dPOt/zZiRWNR4zx8RwLMg2Yn5QYwBXQw94GdPSiLQzsSn89+
         7X6ODesCH6h+yiy24XZA9hFkthVcHYSv+9o5UM4JhDooSkEwKhoSMLZbsKYf3tdaeVMC
         0aDIHNdqJvhabYOLjHzBOKNDfYYyvqSbx2DbcOfDIc/OvWVtsYdmscio+bYqQw/O8i69
         fwEyzibP21/h1BDhiW1vr62w/axi8qGB6sD+p0ZbR9DymPkk1hGHrA66rDXzgvW4ma+j
         oOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777858040; x=1778462840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4g5Cnxwyg4GB/mKplMPUSrP+qwGfFb0vQX7A+4hzBw=;
        b=XcdNWEyFUBbq1ck+/S4x250i8zDVu9hwixlSV3j8tVV4aaiPcEJcgfGk+cDsAS7XmH
         uGZSRGVRakZFYki9EqlbVeDcE7EDLvwJbtyFhk6E3+tnXIfCJPdu2A8xoULR8zPJGDOE
         +8VYVOPxc3bpb3XTe01i8usioVtFtNhCXf17ewNSdZt4oaOazAwMmsU+oUxlbLuh/TW3
         VjBIEIlD6yJTSMsu+o4i5bKAR2y8oevnmeMGfAIeq/etTzNcyXFS/mju3gaHx3HXpG3i
         E7ZY6CPQHaSSpAH8kbMXluc5W142+U14KACKGpofAoVSAsdh1UbJ0+OWUlZYjWWlkvUY
         KBQg==
X-Forwarded-Encrypted: i=1; AFNElJ+J/wLYQcV7OCCG2H5VJbBVp7yoDD9vNyJFOUGbP9ToWZPES811G6NgIl+xBm8BauYJ8Xo+voWWRQFjaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6HcdvEUawcEF4uwEQVPv8IXJU77VcrRbaZPbR27/kKjbOMEI
	UyOlYRrIV13UBe2+OjuPl8H4PAt/Qugw0ogLB8O8ao1xW7NITCzXsqdg6G4AUhUUmRWr+FXFed1
	WIzb558O8V/0J7LtjchfHWkgCLcgUzE0=
X-Gm-Gg: AeBDievwvmXHXcg5TLi0NySpx++XYf7ZVBLEkWAs9+VTY1M8ztuYdJWUcgCose7UJWC
	tQPw3mrNBd7VtDGO58341TysmzR13mmCv3PPewAp0dgcR5vCjB8ri+/9cp90RHA2FLM/eT8nlV1
	36+eIonwlEQ2a/FahY93FQvxZHdm7iZqmKCOOkBh6Ep7a6k69iq3Y0m+vY6Tt55lxocNqfzEnGQ
	7uPkafrK9eP0ye/tbAzaDfQd/aL+Bx0Esy7FiXsknDbvUiNf8y2SI7afdcWUaXTRnRrFsJ3z7R2
	jMvByxh4VCBA8a+u
X-Received: by 2002:a05:6214:8014:b0:89c:e5f0:8f33 with SMTP id
 6a1803df08f44-8b665c16b14mr121335896d6.10.1777858039703; Sun, 03 May 2026
 18:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503072643.2774762-1-jye836@gmail.com> <20260503072643.2774762-6-jye836@gmail.com>
 <769ce05a-3148-408f-b012-74a85c1a2343@linux.dev>
In-Reply-To: <769ce05a-3148-408f-b012-74a85c1a2343@linux.dev>
From: James Ye <jye836@gmail.com>
Date: Mon, 4 May 2026 11:27:08 +1000
X-Gm-Features: AVHnY4KOOclnC_MZbxgLb-vdcjxHx60EFQt1kvDovJkmfkC6hle_r_NMWoYF9V0
Message-ID: <CAEV1_7FPDWxgSqtxCCVbgjXeOO+pBK4ki0Ac+WagVX1pRPrG6A@mail.gmail.com>
Subject: Re: [PATCH 5/6] HID: asus: add microphone mute LED support for T3304
To: Denis Benato <denis.benato@linux.dev>
Cc: jikos@kernel.org, bentiss@kernel.org, lee@kernel.org, pavel@kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 08:45, Denis Benato <denis.benato@linux.dev> wrote:
> Isn't QUIRK_T3304_KEYBOARD enough? Or are you saying you know there is more than one keyboard
> model that requires this?

I don't know for certain if there are any other such keyboards with
LEDs that need to be handled like this, but I can imagine that there
are.

I decided to introduce an additional quirk because:
- I don't know how to detect if a micmute LED is present.
- The quirk could be used to implement support in other devices.
- asus_kbd_register_leds is also gated by QUIRK_USE_KBD_BACKLIGHT,
adding a device-specific quirk didn't feel appropriate.

If there turns out to be a widely-supported detection method and T330
doesn't support this, then just QUIRK_T3304_KEYBOARD would be better.

If you would prefer then I shall remove QUIRK_HID_MICMUTE. This can be
revisited when more than one device uses this code.

>
> Do we really want to use strlen?
>
> Do we really want to use strlen on the result of a function without additional checks?

My understanding is that this is safe, as this name is set by the
kernel. Existing use of dev_name appears to not involve additional
checks.

> This doesn't look like a good idea to change this for all laptops under the sun...
>
>
> Perhaps might make sense to move this check before? Maybe not?

Returning an error from asus_kbd_register_leds is currently non-fatal,
so the only difference in behaviour is that devices with
QUIRK_USE_KBD_BACKLIGHT that do not report supporting a backlight will
no longer log a warning.

T3304 indeed lacks a backlight, so we can't proceed with the backlight
setup code, but asus_kbd_get_functions() is still a prerequisite for
the micmute LED.

I think the alternative is:
- Move the asus_kbd_get_functions() call site from
asus_kbd_register_leds() to asus_probe(), and
- Separate asus_kbd_register_leds() into two functions for backlight
and micmute LEDs respectively, keeping the current behaviour for
backlight registration.

Your thoughts?

Cheers,
James

>
> Denis
