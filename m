Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2E258EF9
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344049; cv=none; b=pW+xQnrh1GS8XUnFeoAa3XLX/yVVD5L0OmYntcnR1kim1lPIaNE74d8Wg9nVucrS/ROaCqx7zP8z/BDtuiu7Wr/SKF7pg/Mc2XU9nQ+3Wi50tEfIs5pfJ2zLHBW+eAgd+qAe+8yOP0YRFCu/WAixibrft1Ou4PcB1MOD9xaq82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344049; c=relaxed/simple;
	bh=LOlm/F199Oz1jthnigxJQ/qoRWpSZhgpu4PEMQn4zG0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DaZv45ctr3Uh2DP6MR3/zR+gLkAgJz8Zzt5QQjNPfZygYUX8dyJ8YCp9hR9KIjvBsyusCJXqoEOWESKuRLDVRr7JybkDxng36gVYQnRH7PzU9Loakk4dflm+oSzoS0H6K45G/3QQonkB9hHJxncBFK/0kDzLH5X9ubdqgkOuFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7su7GFk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7su7GFk"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso1530565a12.2
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789344048; x=1789948848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FGToR7Z/2uqTTL1DA1oZsKRTfaaI3ZcUANMjrmqmGEY=;
        b=h7su7GFkKUkP4+5cVW/SbVYUpwtm/mOlFzVDrhn+NMlYqvUstPrynn7M2Eqwpi2Wdf
         izwXrscpvv+LLCz7cp+i86zeV+O7UTMg+qsu6+Yhvwd4w+bsOFg3qp7TLiI9l8F+wfIo
         4U7+WorsAJqQ48J8rgIWdXypK82nGbbousavyzVt7hOHhAnMQca/tkEDPOhju8in9rBJ
         +fJaTL7cVLxRebt+Gl5gInNBYsCWi0rv421WufM5ho5LjAz1vjq0lo8Slw/nhV/cafoe
         EfpSW88WVi/xsTohEyxtt4JnLBiS2st3DBEv6FfRwTfQ894d8MXF8S7Zmme2HmR8eI6o
         vDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344048; x=1789948848;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGToR7Z/2uqTTL1DA1oZsKRTfaaI3ZcUANMjrmqmGEY=;
        b=XsnorLBdxrAt0CTzutYdVEh8Kl67eY3nwMuvWIT6wgikxzGqAeTpV+Nzyc9wlq/UT/
         8rEvSYD3hXZZBUnEdxtCk8u1WFF/icULAiJ65DORrGSDwGTUE75TdRvk2aQK73iVVV22
         0GqsoCuhBlWud7tAhr+KSH+Y79Cfr3zn0cq2lhJJG2LNUppak7PBTpmJWYbKvb7f4ot8
         Y5Ia1gRde1IW4siBFJJmAEG7IweHRcG8cPehfU/WJcFJD9T7/jRxmlftqWWnGWvukcUg
         GFQxgr+7n3KYJvn/5NLP63+ul5LYORr0Ljg6WlSLLMWRcWlcDra8ixfWS2S4v8LoLvIA
         KKIA==
X-Forwarded-Encrypted: i=1; AKwUvBxFty6t2U4kjgI5G15tCCq8R94/45aJngyViXubLNjniJWeYKLsDIevD/yxIxwos3QiIInxjPJMp76Rug==@vger.kernel.org
X-Gm-Message-State: AFuF++nv+VpNhS3/J3GRCVVF1RSPJBytgO8D6X2ipnyrfmzM9haOr0wn
	FECiB7WvCuKKYRMZ2UNikmAvMayz+m1Ek10VrYND2hW3YxrHLWApLXvC
X-Gm-Gg: AYBFou3iBJPnT1iF3iEBMT3rOMjTDw2bqwtmYWyiM5Xa/B8rn8oZG9rswPWCDMqQtfI
	ZkyLF7NOVMCj5dw3h3xj5V/B847vNKtMjOVviIVRJLlxSHqCvFeROEFuBDvk8Y0dfisGTpr1nS1
	bFopoc+OmNaVPc0j57msa5Z8YCktN7962W+zpVyhsHAIdourKy7KMRY1urgCL6/nmTrnAR2uRP4
	SvOmZtbIj4MojYsFXWex6zFPg1SBBw67VhkmuX9bsv6zlUfZVvL8KhGXO8nNu2G3u9hUp+DkqnV
	hX1t0xXWsUh3y54aACIFVbH+AF5Dn8t4AFl6u26GZNxU1915EDlyP/AErBSXi3HXxf1iJgt28rc
	dlqu6Ns1xkSUXHQGyiXnaMQDc6jhD8aV0qUJirclUPBhzp0slPb23/AxoP6QyylGQpm5rQuehN8
	DP02Wvb1EzECaY+dBTkKq7ldgQRPid8BLcgP7EWFSvFbfNktQZRaFIxBYZYYE0LSxIc4APHlZIy
	s9hhYz86hBpoj6fZoe3gIbqn1NcAB6wnxVh9314oRiTeZNuECzaghtFiCuWAnZ2L7E3Pw==
X-Received: by 2002:a05:6a20:3ca7:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3daed16281bmr30856238637.7.1789344047641;
        Sun, 13 Sep 2026 17:00:47 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba729dsm34029696c88.14.2026.09.13.17.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 17:00:46 -0700 (PDT)
Date: Sun, 13 Sep 2026 17:00:45 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
CC: Jiri Kosina <jkosina@suse.com>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: correct typos in hid-lenovo-go-s ABI doc.
User-Agent: Thunderbird for Android
In-Reply-To: <20260913231004.1007869-1-rdunlap@infradead.org>
References: <20260913231004.1007869-1-rdunlap@infradead.org>
Message-ID: <1E3E61A6-F084-43BA-B9B0-D5F21063133C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 13, 2026 4:10:04 PM PDT, Randy Dunlap <rdunlap@infradead=2Eorg=
> wrote:
>Fix spellos/typos as reported by codespell:
>
>sysfs-driver-hid-lenovo-go-s:185: intertial =3D=3D> inertial
>sysfs-driver-hid-lenovo-go-s:185: measurment =3D=3D> measurement
>
>Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers=
")
>Signed-off-by: Randy Dunlap <rdunlap@infradead=2Eorg>
>---
>Cc: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>Cc: Jiri Kosina <jkosina@suse=2Ecom>
>Cc: Benjamin Tissoires <bentiss@kernel=2Eorg>
>Cc: linux-input@vger=2Ekernel=2Eorg
>
> Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- linux-next-20260911=2Eorig/Documentation/ABI/testing/sysfs-driver-hid=
-lenovo-go-s
>+++ linux-next-20260911/Documentation/ABI/testing/sysfs-driver-hid-lenovo=
-go-s
>@@ -182,7 +182,7 @@ Description:	This displays the available
> What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>=2E<interface =
num>/<hid-bus>:<vendor-id>:<product-id>=2E<num>/imu/manufacturer
> Date:		April 2026
> Contact:	linux-input@vger=2Ekernel=2Eorg
>-Description:	This displays the manufacturer of the intertial measurment =
unit=2E
>+Description:	This displays the manufacturer of the inertial measurement =
unit=2E
>=20
> 		Values are Bosch or ST=2E
>=20
Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
