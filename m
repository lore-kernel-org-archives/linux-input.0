Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDC3FD134
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378136; cv=none; b=a+p6vp9y1qzZ3LAw6fw291CaIQXuu+EWRFHTHbgAFH+Yghbpf74c5uSqqmyBJeZvqX0cLpmr3DgJgLN50P41ZiYurinPRza7Mg65KPclV/gUkDVItJqnenKG6qR64KJqRvMEfP07nUJ2GLXi3fh/VHQmq5Cv1Pr1drZpTdgBmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378136; c=relaxed/simple;
	bh=xOhWPcwO2wN6l/nn57ba9S9CEWCXh7DmXlEixifjiQk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I6PL2ib40nu7ZtGtpHKzJiQ/oWTr83I0rYcMiAhqZtVuKaW1wyvcMDxKHM8CCLmWNZhyy5zOJzKGxI0t7aQNMsYFzbCb/dbgEc0fx2yl0Ux1DNOaWAUjlw+T3dNOGlv96QJfBEDGOhgNqTBSd6QXvkEXvitQfViqIGN2m/M3vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbvFR3IU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbvFR3IU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-834da62e52dso469033b3a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777378130; x=1777982930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ECW+0bs502uiqVG6Y4a6wbsseWKAdQ8DxJiILAPJZI=;
        b=AbvFR3IUAnzA2YRKFMDcbJp/CKpaWpLkUljltjn7FjYgXatlyqhrw14VoYIpNUQxSv
         bfjazvX8V3FT9huI7Pz+FxlI8hfDg/uDMHFy8eeKC7gUA4NE4itxmuyZyvpTgMeiZMJE
         X2AUOI/5zgtUTUmhfzhEG5sKpAxgg95GX9nBze11r8ZLSEJSXWoXQ8wPi8yVn8KCn1Oc
         foACTs1PGBSgncNrAsN/yKxtoVxo0/nWpEjrjntwN6MnmcOIuzrp+pn61dg+z83X3kmi
         uo1TCfuDADO6jFIHYI1Rkg3eYrH3MtqMeeJqVGU5ne/DTop0za4tlti+EIt//XQwliqK
         U7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378130; x=1777982930;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ECW+0bs502uiqVG6Y4a6wbsseWKAdQ8DxJiILAPJZI=;
        b=QcYSSqB1XKMplvtyfKhG/OGSyOrShxcsKagHkh8ZxMiGcrL4tWmgGxxeCnasC/Z27y
         ErZCcNGehevdv+8auclku0RbYIR0A7KtpkGWoix9tCm1wgSEvJgaZDQdO7im0cEyGes1
         se7QLuN0vRrk1vH4c0zewc7BZXefsRsSGhoGxGWf1GaIeUtbcseO6VZGrNZIT3hWteAX
         GU1xOmJc1VsvdSRvA1cXw/fLsTRgDBSJhAXNcG3ikrmx2YAcKICydnLcMzNz2Bp1IwxZ
         9ZQJquDQx3+atLcFCvZCDMSvGfyCuV8kylzrAZ8TvnqZDij5Y1+0fV/8RmWbD9v0jr0C
         utqg==
X-Forwarded-Encrypted: i=1; AFNElJ/4SAvh04eawJ14XY0BZYqBuBH2jEIkXQYAYbP9eQBULiIKJFboG/iS3Z+KFDLCA48C1zaMcLQab29tqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrKaRmo9w4/HodUnNzhuWJhAr+1WFl8X+DN7Sc71SXjnYYx27
	vWTEAHOpZCSqSVG4O0h8iyQjqnSLIlmD4Jcj7brtzBNQD++xA+oi/vws
X-Gm-Gg: AeBDiesACt0FNDRJzfZuxawclMNt+X2GzMzz5iUCskst29ofNqn+E6RFFoGh0iu4W1A
	RdkCcUU5FrUJjVzgRIoCTldsiw2X/mWTn+R4XM1XQMLQO0O+Z/Lwmewl7u+3Z/UQFhyh85XV1UM
	G456qToTX9oLs97NpIFi7b8mMvzsCcENGEu5ZrR3BEZokBjZFD15sorQ3dDBI96ImcaSretWXs4
	FpCp50VOeGn3f77KPjIETtIqFOExiqtqFhCSuLB8i4zN044YDQrQiZzwFdL7Yn6EJTU+J70K31S
	rlIqjal/VNGj0rdAmdgSKD7B3Tgj3OraXeOumUJ1iT9z//L7Ej6SvfRmcHOZMemeeVCOjPK+PbR
	BcSGezbpHrtesrEH85Q2o5UMILINFTCJjANzmtzCssgttgq12VeWbQgZIyJMFNSpcSz8VDPDeNo
	gV8tYPptTA9BuR3v6YS9+/aKX5U+rNH3Xf1BzpBsqkQvPz
X-Received: by 2002:a05:6a00:4c85:b0:82f:74b2:7fba with SMTP id d2e1a72fcca58-834dda8c794mr3045617b3a.4.1777378130380;
        Tue, 28 Apr 2026 05:08:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:5760:4f51::e34:334f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae0091asm2749844b3a.10.2026.04.28.05.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 05:08:49 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:36:46 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_02/10=5D_iio=3A_orientation=3A_adapt?=
 =?US-ASCII?Q?_to_hid=5Fsensor=5Fremove=5Ftrigger=28=29_API_change?=
User-Agent: Thunderbird for Android
In-Reply-To: <afBuWAElmx7t7FcB@ashevche-desk.local>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com> <20260428071613.1134053-3-sanjayembedded@gmail.com> <afBuWAElmx7t7FcB@ashevche-desk.local>
Message-ID: <1AD74A89-246F-4ABE-8088-E7A45DC3A4C0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28 April 2026 1:52:48=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Tue, Apr 28, 2026 at 12:46:05PM +0530, Sanjay Chitroda wrote:
>
>> Update the driver to match the updated hid_sensor_remove_trigger()
>> prototype, which no longer requires struct iio_dev=2E
>
>You haven't compiled the previous patch, right?
>This is not the way how all this should be done=2E
>
>Also NAK to the patch 1 as even unused parameter is there for the sake of
>consistency=2E The prototype to allocate and other in the similar group a=
ll
>have it=2E
Hi Andy,

Thank for the review comment=2E
I agree your point for consistency=2E

However primary object of this pre-series is to prepare the drivers for de=
vm_ conversation=2E

I would prepare devm_ wrapper for the hid_sensor_setup_trigger() and respe=
ctive resource release hid_sensor_remove_trigger()=2E

=2E=2E=2E  devm_hid_sensor_setup_trigger( =2E=2E=2E )=20
{
       =2E=2E=2E
       =2E=2E hid_sensor_setup_trigger();
       =2E=2E=2E=2E
       devm_add_action_or_release(dev, hid_sensor_remove_trigger, attrb)
       =2E=2E=2E=2E=2E=2E
}

I observed that many HID IIO drivers are not covered fully with managed AP=
I=2E

This devm_* sensor setup trigger would use across multiple HID IIO sensors=
 and will go step forward for managed API support=2E


>
