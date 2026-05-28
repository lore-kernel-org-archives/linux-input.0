Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBE319847
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946704; cv=pass; b=lzZP1Ahr0/9f9vBz/ihe6QwaJ+6FVoMDBq3Xdd/HCJcn+4bdXsCJLLQghquYK6P33+udk29ZcIoXBUHUy7DYBGykkOHrFTViX2MvP3Wuvx6K19yQVFh1Lab23y4HfVqMp1X01c6BM/L/RNwVD5PFCrOai0USR9mBFmPO8uAejms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946704; c=relaxed/simple;
	bh=YVO1LwzPOtQIX4YZQXs4E3LGR3UUOpoiicYRV41ZkB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9uetzDEqCIbiZHg2c506hE+jADoaSM+/q0FMb2E7apRFQASnZNJMeam3e0GV+U3vZoqShtqr2zAJOCm22syeq4j45wVfGUXi1kZgMcNv7o4/lYqQH7fJpiYbq0b2UVNdoKJgWpa+sVGSqdby0iNmPsCvU61sWpbD6Vqtjqgbek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rINBV+jq; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rINBV+jq"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso6916507eec.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946702; cv=none;
        d=google.com; s=arc-20240605;
        b=Je5Y18AfyjlXmS/YvFSOH+cxMXrqLhylL/M4y/E4JMPEvr9hdjVG5l48SOX/WhD0JK
         XDII1MZhZcDulf57re+MvKYoavuL7f2jA7I31Oh+d6YsUGCYeRvVBJJjh5hzCMqpsmSN
         USwy4reUaWQjtoFKHEWy57wSCAggAGli5OmGGXwG0FoE7C2CEDUOJ4RRJCK/nYR6c5Y3
         4qZyN032nXV6zGY49OCARHurjYOIL5aGwRIAQj5r9cr4aC8BubNUPpgUzeS5HGzqrQun
         52aWzm1X5hCZIFrvod+zGNmPH/s7tFLSl0MBgp7OWKSA9zGsD/LXgO5MoSRsRWY3GxvO
         izgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xs4P9mYfgBvC9txKI+9u4GTWI2u+8bZrY6Ruqk3WsmE=;
        fh=V4m7GdJIe6iJzuzwQFk5XW/EtLVsymif/L1e9H/GSiA=;
        b=bxSP7ABmFogsaM7sSaWL9GePnoyIscTYdrzK0GhHJ9bD5Bh+Rj89pa0rrkIWYCUGsL
         3MrgRdoqMBh8ULPUTWj1+OmTwF8XV7CXZIb9l8hEZtbnhHxxYSNrH3iq9zPFKXwOhDW8
         LU9r0qnXNndV7qjfxOdcvZ7tl8kbx808kQ3/EyMMp7fGuySmCYCaXwWgF/58dO765YKf
         aOvihKDg5IGJhMR93Gns3zp2OyuqvJDbf6MRHWaf4cAZXpV634uYtYLlucTV7qlNm7zH
         mLdSy9O1GsGr30B9O4wEOhhZPEQD20jzc6VfCYJZOBzxX+JbN6BEz608KrUnfZZJxsAN
         E5cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946702; x=1780551502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs4P9mYfgBvC9txKI+9u4GTWI2u+8bZrY6Ruqk3WsmE=;
        b=rINBV+jqY7+jDWhN4y0V/9cFuoHEOKt66QvMExmr2C8SAq31MugcJEePpWyBTcHBFf
         HcvjhWxecbGM/cJQ3xuf7jTLc9nJ/FzTzevlIjKt3Brcl42nFHlKJTvcM7rbdLl5VYLD
         Ji43pOly+CA0JdmM+ae7gyppyd7nZVNsbaTh68p5mN1TD4x77k3xvztFUdKGBUyjMGOU
         UPgghEenYm143XeQUWihk0vAz70dcCnvQ8nF4gRi1cwwEBkZ0vELc83ldm2XYbl1m5wq
         dxMuaj7kqpL7P4/9A/2mkidEYfc7Vaa9RqeL1obn2b3EZE2LJsB0rse8pxNoIOTYtHud
         bRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946702; x=1780551502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xs4P9mYfgBvC9txKI+9u4GTWI2u+8bZrY6Ruqk3WsmE=;
        b=n4JpPrmo3xcLipMAARwDTVLsztY0DqlfYhImee0WxgfRy/d2zvFwO0eD4CpgWKHkjO
         vt7WKvjVdIKPaLGQws+Nur7nGtVzw2Xn1cCKNwO6OWsxoNS5c3U9te7GISjb00CLvQ3h
         yDIY3aPJhbkZ4pg7nUuaW8aj2nyLksVrjgmqC5Sb+00djGT/VYuio4ufjpEfSbyfodPJ
         zEeue75c0kcmR7NVZuObtS+qqpeHenbDzwq8CapAM2NxlyYxQ82t92MTb9YdL/ME2wA+
         HRZhvalOLKi+hiJmLJ0bL15qlI6AwQjFN2IcScYaDQx+fV+8/xfjTkUeSUEJNY+o6XHg
         Dlmg==
X-Gm-Message-State: AOJu0Ywv3tfppjQBz0vO+HgbLpIhOOtiAslsSXAMp/TJx4uLstIKmw0Q
	a0PBCnlK2pG9eMve8UzPFWe4ug+VOfNFS1QITSvDqYgRPLoGosgxigb0YakQqf75qK0aZhrZs7Y
	fbSmvQXtIF7Pa6lXY9dAECu1GD+D2npv0Eg==
X-Gm-Gg: Acq92OFP6M93zdXaJQbeNp6HdmHAzddiY7Cve/hHIW+tl/qpilPu3DnQUlOVXJw5mgc
	CrKV5UcuMVLpf9ZV1VPbikQ/6Hy/2EXLzPujCuEKbNQmXXzco1rvRNpCP/806sjVQ0YQOzFLn+S
	KSkSnDlqffYO133tiMNphehYlujquxp5xVXGMNEj99rXRVU9jsovF+wSx9tVMIdqLPf99rPSObO
	/o+Nmzbu8EkJsAHH8eAacZ/RyAEcdiEpK/J6IqQAgx0x0+TciEox0ruMaomOiOmK8jr3Lf/pJFZ
	fi3hBhoonf4eMIX6v/4=
X-Received: by 2002:a05:7300:6c22:b0:304:dddb:f8 with SMTP id
 5a478bee46e88-304dddb05cbmr11677eec.35.1779946702054; Wed, 27 May 2026
 22:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512102445.55372-1-clamor95@gmail.com> <20260512102445.55372-3-clamor95@gmail.com>
In-Reply-To: <20260512102445.55372-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 08:38:09 +0300
X-Gm-Features: AVHnY4KDA3MQRv2k4QbPRNCxfSxaYHOG3DufLVKw-4prvw0-HyXDKTXUET4eBH0
Message-ID: <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:2=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Linus Walleij <linusw@kernel.org>
>
> The ISA1200 is a haptic feedback unit from Imagis Technology using two
> motors for haptic feedback in mobile phones. Used in many mobile devices
> c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
> GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
>
> The exact datasheet for the ISA1200 is not available; all data was modele=
d
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.
>
> Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/misc/Kconfig   |  12 +
>  drivers/input/misc/Makefile  |   1 +
>  drivers/input/misc/isa1200.c | 524 +++++++++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 drivers/input/misc/isa1200.c
>

Hello Dmitry! Do I need to make any further adjustments to this driver?
