Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E4239567
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888091; cv=pass; b=c2K+WalpfzbG63rC4aDkPgXazN8u7UA5JZeZ2CTF7pvf38AgW7+R9nUJF/kICAuSuO7WBofYdJV9HKm78jRtSs8C2qXxY0rNErjpsIie8kwHy4/mJiKgRdKKXHv1GW80F4FX6xY832/Y0XmOTW8ePC9Ga2O/5/t7dDBZIl71Wqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888091; c=relaxed/simple;
	bh=86K8uKiLATgTxa9IrfTr8hurJOunk82qbscdkmiHoXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaTuXrkbqd7V1VvKp/r3vpqCRtWjSsGTg1CBvEJw0yfxrIoW0f8qBdoNazRJubIQ+DmKcY7Y5TbDcjXk7BzpThugazDHAsjkc7n0plk9CMN3RgJpSPj4j1jGGUoVFUfGhlIPpnOv9h57SXyBcmocHeJEWdJTtPWk+aQEqcuQ1T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovmpHnPm; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovmpHnPm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf50c6f235so5278335ad.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 17:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785888089; cv=none;
        d=google.com; s=arc-20260327;
        b=IhgQEPFqh1lCHMhb6YyJ3MwDiBwxn95LhWAehJMmyn3RkCnKAhIQNR4rrFHgux+SZL
         p7l+RbwxhuSFWjW4WLYbBRoosovJ2B40AWeB7nU+ksgi356IzEDUKpBKFBaSiL8L0BcC
         lJc9n3zXn3GhSRHQy2PPRKbRyQ+6UTbxE2mOZ2FvP8tM9ypbreUffQsd2TZn0aO68oeX
         2RIRMGUH5dMjM0sYCIZLNbDq/FTbTOVICybop0ELCv3UU0JFR2oY+hwpgQoV1IxkCqbh
         mffKRdYYr4IFUzrO/sdLGWCRgvNmw0LdNSPsFIUtOStqQSD/ndm3pCNfwwR3UlguOweY
         hr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NsdZbLvlXG2ntN+KudJSI+VASQm9D9JFdAQ63Uw/9rg=;
        fh=c/Q2TTkbkUv4fPqaAdKnzSyGMfjjc6Gy2H8TSUMX6lE=;
        b=lUQCLGdYCvawxq7YGRLwxLTKF6wVI54Ni/ko8GCjTI+iz0qKYw+WK6yZWDfx999F0i
         SghBLZGPUz0AO0D+V3AHOX6MjWLPQDBnAF2K56LXShzU+ieqmwc5jpVKKIHkKS1++nQk
         c5PfyL6fzLTTyUdMFptb+4Z5Wt7Z7OfHko2eJLwl9K4fiWPmahGDTJat8xgOxgvWrH0X
         5iXiKDL9fY4wRUynboGXN5XjgSdnpSeVYrrf1B+1mdT6/CsFIysy2xTd6dKCtXYtnG9n
         HtfF3F5+sNRzjuSygBuLRZlUJVPRmwgWCCmyQH38Qu8dnDa6f1PYqUWedDamSchzmNyB
         FvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785888089; x=1786492889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NsdZbLvlXG2ntN+KudJSI+VASQm9D9JFdAQ63Uw/9rg=;
        b=ovmpHnPmbvy/gEco8hNQig69eqxrNHocASB9se2gc6sq6vn2uAerEg0tsDpACb32Tu
         fPblp0b5WFwmfEatCb2eMUvBYl8fPvL36ePwxuuVsutzq2hcTq74F0dL8qQyzwTwX9vO
         HOTdWEMlbAI+95GkZ8wG/WKRYu5I8yAUXChaDf6G0BU3lnf0Jh0CBUcjQZdQpRlIb2J9
         9cpTBQ+gN1gjil1+nJC11KDLcB96D1ek4x4CrBHOc1rga6r82kvB/tS9fKBBMCIZnDoG
         h8gDB9t93uHwHFnILxQf/kG4aIz32andXvA1nXyBbxvQWdNJvRL62JP5ZEFbPTQK0w/P
         KJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785888089; x=1786492889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsdZbLvlXG2ntN+KudJSI+VASQm9D9JFdAQ63Uw/9rg=;
        b=RBzApdGUaPf6Hd6TcI1oKGnzjrwi07CeocMvGXGjhz6LqA7IgdxyHzX4Gaoc9UlpJJ
         PEexJwpHkJ6KraWyRWBUIng2EV20xv37MTH+H6DnS6FfrkxS53hy1Wcdcqwje4Mb1b1h
         fIPWF0gtfYYYvizQIDWNsQwYcUEEmbD9o+N5yIgmdK+lIFnC5JlVOc9oh6kw3yC6m2+i
         ai8kVCxyxt64BHS91U0srVAI8Pf7HTwtmfot03BwPfci3t/mi9z8LBxrYo2BXtynnioj
         ukCK7/4k4Yy9LdHsjhalL6ZWcz0a1MgPFNPmVYiR7EC8RNQN+JFGuASpyzcG0KDuiozK
         yU1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp8vYaWXq58ssoss7njJn49uT0F9SYPCWFxsi1iajDjAG9kIH0DGz+LwG9lyKFRP6fZc7FJtb7IBTxJkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YUcuU8e4yXX+RgXBA22+J/6U+SNODFTm5iEsJuUILZ2EvT6/
	JRcIgT4fQ6KEMrIleeXHUPsvlQXY86Y1ZoQiTrCTjXrfVCgivlzPGPkvaCYOvGIyXDeOdxpTr1r
	z7B4yjqcB7jsHbNsnsMZn6fl4bZyYwydOdJjR
X-Gm-Gg: AR+sD13X9WXsbc4RzhrJsIsn1XCGm3nxfXgvv3a+dxyZDWw5+dEMLiUx26hQskfks3d
	ysvbAZjlUWbwS5C+Tgtf9xM5okm7bTj1Xn9uBgfKVfePkPsnBBBzhy+xkKtvYgtdsLL5kjHqMPo
	H81GgrD3Ha3myeqwg9YVUVHA3ifwla4bK/eKXGFloWYN+gbz38OsfZ8qXhmKN6eABFrwFJYfXbP
	d1Io6z9xtmd/0KFz33p1RuRBxWJTtz7VsGpCwt62v5W91iQD9k0+RWFxe+yeYSLnzHI5RasGinV
	USUXq9tqvLTcKLw/fdBEcQFD/pkcvHxs6Me+IbuabXdtWEEWLAXQcUWTYqtAV474iGzKJZok51z
	uU6UsVHXUGu2CSFxKN2MW6gAN13H+B/x/dLzvhUtczpy4yWT0pvC31wA04Uog
X-Received: by 2002:a17:902:e84b:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d0ca7b5490mr23513245ad.3.1785888088568; Tue, 04 Aug 2026
 17:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com> <anIhyHL4Kl-DX2G_@eggarch>
In-Reply-To: <anIhyHL4Kl-DX2G_@eggarch>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Tue, 4 Aug 2026 20:01:16 -0400
X-Gm-Features: AUfX_mxwyh_MML33tokD_7o_JuJogH0BhSC8wEjmWkVQTWtJhzWv662Egc00qSY
Message-ID: <CABWMpWQEfycicrctrW3RD1yNf0rv1ZrioY9FcjoZZGEz4GAm_Q@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev, 
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lovekesh,

I have now tested 02-resume-reset.patch separately on Linux 7.1.5 with
the CyberPower device 0764:0501.

The patched kernel was active:

  7.1.5-ups-reset-resume

The device was detected by lsusb, but USB initialization still failed:

  usb 1-3: new full-speed USB device number 4 using xhci_hcd
  usb 1-3: New USB device found, idVendor=3D0764, idProduct=3D0501
  usb 1-3: New USB device strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
  usb 1-3: can't set config #1, error -71

The UPS therefore never attached to hid-generic and NUT could not use it.

I then returned the same USB cable and UPS to the PiAware NUT server,
where it immediately resumed working normally:

  ups.status: OL
  battery.charge: 100
  input.voltage: 122.0
  output.voltage: 122.0
  ups.load: 23
  driver.version.data: CyberPower HID 0.8

Results so far:

  01-no-lpm.patch: did not resolve the regression
  02-resume-reset.patch: did not resolve the regression

I will proceed with the requested git bisection unless you would like
any additional targeted logs or tests first.

Regards,
Jamie Stephens

On Tue, Aug 4, 2026 at 2:56=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> Thanks for the report,
>
> On Thu, Jul 30, 2026 at 03:28:02PM -0400, Jamie Stephens wrote:
> > sudo lsusb -v -d 0764:0501
> >
> > reports:
> >
> > wDescriptorLength     504
> >
> > Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> >
> > cannot read device status, Resource temporarily unavailable (11)
> >
> > As a result, usbhid-ups is unable to reliably communicate with the
> > device and NUT cannot reliably monitor UPS status.
> The lsusb failure and NUT seem to be seperate, lsusb failure could
> simply be device property.
>
> Few possibilities I can think of worth testing:
> 1) It may be related to LPM, the device may be advertising this but may
> not be handling it properly.
> 2) Commit 8020c41b39f5 (usb: core: allow ACPI-managed hard-wired ports to=
 power off)
> lets acpi managed ports be powered off even if hub does not advertise
> power switching. The UPS may be sitting on such port and its power could
> be cycled out and leave it in a stale state.
>
> I'm attaching two patches to see if they have any effect, please apply
> and test them seperatly and let us know the results.
> And, as per Thorsten's advice above, run git bisection regardless.
>
> Regards,
> Lovekesh
