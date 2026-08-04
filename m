Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AD4399E2
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869775; cv=none; b=IjNrm+5ssS4gVNoAfuwflrA0s1V9KiMMEtO547HzNOyxZdxJ3noc2rUkwvvvOEtMrkYsd/f+b0zlKu3cAiiveU35j8dm4h+Rt7wPfalbCUwiw62zLJPaRgM5uKgLPn0pPWveJiWI0uc0g327+PR82jMXcpWn1jbyNVQmCdJ/hF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869775; c=relaxed/simple;
	bh=r9cidioRLvGUYzfs4Zyd6EFYb30JbstKdtKisMEz5nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0o6Dap6C13C336hQNzOlHMP/TAiGQvJ4DFohxlx/COh/W1kL9Qb6YcSs745XnSmrS9UuL961FNT4w159VvBgzF18JRdLCzzsMp3EI96SzlkmFeCxVt8wyF2gzCkggjF9oE3gpKKAR+8Rrg9xxRm4/No605kWYvpBy+QTJAVIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA+6KCW8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA+6KCW8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d004f135b1so2642195ad.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785869773; x=1786474573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mTSTWCov6kNGaDYzEBELBFA8avyhvK+w+2YbcE7eTeI=;
        b=RA+6KCW8kbedqdUkR+qBiqCTeFbiu/KcXxKOCx70LfC7nGbV9Ssd/rHjkSW3MyBlwT
         SJ9a8mvVsaWKL2eTOIoHsTKXvYkcdI3GK4+AjnrGcIxzPeR2NFSFQQ5wMcc5ly7Pgwt2
         UPwgjTs0N4Hs3aWSrRgIfJaav3jzWUmZ8iQ6N6RDhmISAHh3la9Zyd3EwzYWr5dWfLWq
         PDp5SiRo5AEVpO5wC8Iv36uqsxvpWmVefKaPdPvUN/ufSzUtuJxHCh/1BC61x8jjkNV9
         vgek8F8J7P2YyxEJ9WXwWcqK/yjl49XqmE5TIrBHOEAtRHD4wcT6Z3tPLQqT2pGcFRJi
         NFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869773; x=1786474573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTSTWCov6kNGaDYzEBELBFA8avyhvK+w+2YbcE7eTeI=;
        b=N9jR2dpCaxSIDXA79nH+fIqLx/fCd41DG8YwRb7IggQYl0WMVFoPezz3HIJGNumEYS
         9U/G8orpoBQSl2QPjxSLLS3SziW9MfNZAH2VtzlQ0rK9SuA/GNtMqIIh98wtUmF7JR6f
         kYnvYmQF+n2msrklQ690VEHgZsMW1cWYFeRv8TGAJwWpQDZPcFYQv1GB3lR/pQw5wACR
         9XE8w9M6OiD25G42eoLBlOppnke65gIiF2bk1Ax8ag5V+bmukAtqcjoieyrHLEJVb8OT
         zRiMbhaByOMmsj4aqEu4lulP3sXTnOCLNfg3ZGICgEkPlkcCzTR/mTakZUBsa08worcK
         ActQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqdj+lur+qB8pYAGKalEKDnRPZTjTcyZm4hF/4BuMnarh88Dr6hQkP7O7lTE0X7rY3GF4OydvV3tPWKMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcqvBIqTtTj2yec4qxOVRcUgdp3FNx5z7Hpkr+sQRjYKniOOg
	Jw99BWH+0ykXkPYXScGjrUzec3KEEWA5M0/lKchJDnjzaCXrlt6ekOtf
X-Gm-Gg: AR+sD11vp6/kIlLSCq2VMZcoZEGH2WSZaxNHbaDMkXMq/Xoodgz2vbEHDO8nvDD7phl
	9v8HqnVytuCltLN3aBb4Qke72hyC1lgm4JXWgH3JIN3qDEyiFTNXlOTgqrCV6G/Z/NMoFBKtuxG
	huf0xjaDUtWP/a8Jbnzjou5ubE11Ad8xB9Rg2ILj/jew37InDCCcSRaIhtKb+4ujy2t9/vbolUF
	wZz59eaW/geHQFSadXXcsDoVJZOUin8pXdLClt76YynVUT3Sg6JyM/DYpMp62OSyDwmXYEaLGHU
	sQ5+GFpY+rWepm4N7k6hYbIFRnDJ5o/xp/hS06EdRzdsnfWMwlFgkZjDRJkCu57EM64XPJ/9WUe
	lNc2hajuheNLTd5ALiBGEpkwSk6G5xAlTDWmVDJz861O1dqPkEwXh4c0bwomRk1a/AJ+4CqQT6H
	bibfuH0RggzHP8SbRHN7Z0aIlgZiHJAo7QmUjYUffu7gu0apIl3UOEOGk5Ym3wc76xWnhIdL8La
	nawncj6lDBkLRNTBerhVocuvcqp5YbgFtdNVgWqvg==
X-Received: by 2002:a17:903:2392:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d0cc930281mr4087045ad.2.1785869773407;
        Tue, 04 Aug 2026 11:56:13 -0700 (PDT)
Received: from localhost ([2409:40c4:2007:21a9:9627:a686:aad0:561f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm11792932eec.1.2026.08.04.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:56:12 -0700 (PDT)
Date: Wed, 5 Aug 2026 00:26:07 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Jamie Stephens <jamie.stephens@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev, 
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
Message-ID: <anIhyHL4Kl-DX2G_@eggarch>
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="iutcx4g65ls3ovlf"
Content-Disposition: inline
In-Reply-To: <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>


--iutcx4g65ls3ovlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for the report,

On Thu, Jul 30, 2026 at 03:28:02PM -0400, Jamie Stephens wrote:
> sudo lsusb -v -d 0764:0501
> 
> reports:
> 
> wDescriptorLength     504
> 
> Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> 
> cannot read device status, Resource temporarily unavailable (11)
> 
> As a result, usbhid-ups is unable to reliably communicate with the
> device and NUT cannot reliably monitor UPS status.
The lsusb failure and NUT seem to be seperate, lsusb failure could
simply be device property.

Few possibilities I can think of worth testing:
1) It may be related to LPM, the device may be advertising this but may
not be handling it properly.
2) Commit 8020c41b39f5 (usb: core: allow ACPI-managed hard-wired ports to power off)
lets acpi managed ports be powered off even if hub does not advertise
power switching. The UPS may be sitting on such port and its power could
be cycled out and leave it in a stale state.

I'm attaching two patches to see if they have any effect, please apply
and test them seperatly and let us know the results.
And, as per Thorsten's advice above, run git bisection regardless.

Regards,
Lovekesh

--iutcx4g65ls3ovlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01-no-lpm.patch"

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87ee2d938bc0..2c07e1cb7e05 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -374,6 +374,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* CyberPower Systems UPS (LE1000DG / CP1500 AVR) */
+	{ USB_DEVICE(0x0764, 0x0501), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* SanDisk Ultra Fit and Ultra Flair */
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },


--iutcx4g65ls3ovlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02-resume-reset.patch"

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87ee2d938bc0..8ccc5fc6060c 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -374,6 +374,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* CyberPower Systems UPS (LE1000DG / CP1500 AVR) */
+	{ USB_DEVICE(0x0764, 0x0501), .driver_info = USB_QUIRK_RESET_RESUME},
+
 	/* SanDisk Ultra Fit and Ultra Flair */
 	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },


--iutcx4g65ls3ovlf--
