Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192E48383F
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531818; cv=none; b=YNfqwC5E+xrxxg8K98qVhJfSyi3FkdaNFbJfVPWotxVS17Xmts8JBW6HAB2BHtbgYsQA3xu4YhzHKROD3e7gwmR3VAMFtIZDE1oDZSc6126k7KERnWXZgTeKpAVxVFENE8YuTrCcnC07QbUE2jTMi8FXDV3BWPyFEOofAbO7WBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531818; c=relaxed/simple;
	bh=l5o0Kxh4QHmzyssrBdh7uVhR0p9YGe21u5DbK/NG40s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h6E0HHI3hfMeTHzcCuUbFcKXgaJAlRlvkdYtoeKR+IdijYAHhB5URR4j/eRkZB157cEEnAWe4mD5+fUU1AOmLDNQOQPlbu64UQHlTlVmJFdrnSIeZL5C/K+L0dxhILtajODl/W/ZCc4IOEwaw+yJ+u19pBjlmSFpX13pFf1iTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+PbgRrK; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+PbgRrK"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-495b27007d0so908179b6e.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531815; x=1789136615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OPLJDNKSQZ2RpNMuFTNGRTC/xRNgD/y0SY0GD8UQRl0=;
        b=n+PbgRrKUYff2XKoDG0RMPlt+S4R8DjRRFqoAG87cbG1V6hwTN//ZZBjJDq5X7A+2+
         h5W0lgLNzDAb8n2aiVRBpJpSNuGECEejyXwldMnq4+ZerUgTLbkzi0kOSeJC+pte+Qcc
         Lx1rZi5GVtRhmfRZTHRIiX1rgOUKImfJQ9rORNM0jMP0vckKWM2dmi7te/DWfi+fvd+S
         uWbNoty1JRJkmNjoHOXMMwtQPtlNi6vng/y/cnrlFN8HtYADClG46V0g5ZN57B8e9JVv
         8ApPhZj7+HWIqWFKFwI8JG3iCnlhivEGoqz3/3J5JXmHOZ1Zr+IoHSviIfzn9qfP5jx1
         AAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531815; x=1789136615;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPLJDNKSQZ2RpNMuFTNGRTC/xRNgD/y0SY0GD8UQRl0=;
        b=V+9Rpw1rNRBRubFjLVw2/XnhvE/BYStaawGR38RMAxKGOzp/Ke7a6Jp6rOCnvDEQ8V
         xCJmseq6tTedIaMy+M6uoAQd/aFD5aXxwIbigVbEn3nxJte3BwwKFYQFQXI9V/iE8RLu
         N1M9WCBR5DXoSwX/JM2JJqWsGJzJvYayHbfF5hOTOz4SYUNeF31vUCsuGwWdIiO+kMhy
         YF3+xSVMEPhIfRrh+FJSvkUCXWFJkMe5YayRCqnpGcM98BhsWUH3esoXpB03gv3DE4Ka
         fmN0UP9VLFFjGAk6QFunEmgd1ecErYAwEJOllLaS7gHzqMm87fjCaaPaX2lxgYIAbX0t
         eYCQ==
X-Gm-Message-State: AFuF++mUILJKM5URYtZbGuaqVkUm6xmYnn5OFKRW+eHe9YzluEWVOm4a
	I5hkqMFXAwKI+Bksm5oxu2FB62q3VbOM3RVsUczM02BT4rfk5PSIEqvl/5ZXnA==
X-Gm-Gg: AYBFou3SpadNaPalWculAvaQ+fp0yfCA0lKEJhbsu0oVeUX2YSuGk/yapj6+lCrMTtw
	62bEuNI/ZDNZbrbwT8mEEQtNLCR1R2DCjKLBB8r8J7EwVEbt0CJPT4WLULHPsU4q2DqmtL8lrY4
	hAju05PstWvSw1xcQXt8TvxgxOYHNLy7xyekiWQKX/imY30Z1i2uYzj9s6Lm9/ZuDck9JQyE6VI
	/BWjxKDbR5XHn74WXGxwBOEPLuR3pEuiixGySlLXx/uVvjX/jOMlctJkQh84b2kQcWX7gzk9ddX
	272qchXIkjiLQ3N4c2NaXaZIsIbm2VpC0RZn8ZPZnnX16c7S0OpACZh2Uuw4MAwjlm1Xaw8T/7Z
	AdCwIHu5Zo8jNCYGqZ8XeiNGOXJfLAJ0Hr65cnzrAakuJ4mvPZ9ejy7TKUN9dcPxwSmWgmrjs//
	JAxx78vYZI2OPimwxuWvZlqBhQ62lg79Cb7gI9PcXoMXw+dswVxZoDvt55d1Y8GZrXjdS9xEnVV
	ZoaCeGpiwJ3qmkyRO8+mJIKwagoUoe+7ra1Arm73e2jjoue33S/YouReQA=
X-Received: by 2002:a05:6820:1f07:b0:6b1:c181:9386 with SMTP id 006d021491bc7-6b6fd5d0472mr4653800eaf.29.1788531814720;
        Fri, 04 Sep 2026 07:23:34 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b6036fcsm7789074eec.20.2026.09.04.07.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:23:34 -0700 (PDT)
Date: Fri, 04 Sep 2026 07:23:20 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
CC: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
User-Agent: Thunderbird for Android
In-Reply-To: <20260904105800.3923987-1-tristmd@gmail.com>
References: <20260904105800.3923987-1-tristmd@gmail.com>
Message-ID: <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 4, 2026 3:58:00 AM PDT, Tristan Madani <tristmd@gmail=2Ecom> w=
rote:
>From: Tristan Madani <tristan@talencesecurity=2Ecom>
>
>oxp_hid_remove() uses cancel_delayed_work() for all three delayed work
>items=2E  cancel_delayed_work() only dequeues a pending work item without
>waiting for a currently executing callback to finish=2E  If any of the
>work callbacks (oxp_rgb_queue_fn, oxp_btn_queue_fn, oxp_mcu_init_fn) is
>running at the time of removal, the callback continues executing
>concurrently with hid_hw_close() and hid_hw_stop(), accessing the HID
>device after it has been closed and stopped=2E
>
>Use cancel_delayed_work_sync() instead to ensure that any in-progress
>work callback completes before device teardown proceeds=2E
>
>Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Tristan Madani <tristan@talencesecurity=2Ecom>


Hi Tristan,

LGTM, thanks=2E

Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>---
> drivers/hid/hid-oxp=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/hid/hid-oxp=2Ec b/drivers/hid/hid-oxp=2Ec
>index d2ded6b08ce9e=2E=2E1e691ebc1199e 100644
>--- a/drivers/hid/hid-oxp=2Ec
>+++ b/drivers/hid/hid-oxp=2Ec
>@@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
>=20
> static void oxp_hid_remove(struct hid_device *hdev)
> {
>-	cancel_delayed_work(&drvdata=2Eoxp_rgb_queue);
>-	cancel_delayed_work(&drvdata=2Eoxp_btn_queue);
>-	cancel_delayed_work(&drvdata=2Eoxp_mcu_init);
>+	cancel_delayed_work_sync(&drvdata=2Eoxp_rgb_queue);
>+	cancel_delayed_work_sync(&drvdata=2Eoxp_btn_queue);
>+	cancel_delayed_work_sync(&drvdata=2Eoxp_mcu_init);
> 	hid_hw_close(hdev);
> 	hid_hw_stop(hdev);
> }

