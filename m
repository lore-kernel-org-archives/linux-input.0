Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D553E959C
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219365; cv=pass; b=f/gi38mc0vjN+Oyzz2Og8MfmEgPuoksUEZi8hNnAX8JwH9jw81r8hA9xM9U0lBZmXl39qRTRDxW40jpUMsm7W1Rn/Oivi8jKl9TwlqMAaylGCFg/ZRc0yT/BPxu96BASqa+Ehd4XQoMhPYsHD8/U9xYKwaAS4JbErIONwgbSnhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219365; c=relaxed/simple;
	bh=iCehflJlGOz1mQo5cAWM6ZY/cFiKDMhIje2eKZy9xTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNcD62q2vyIDRWWC9pZPD7hrEhpKJE1Cm4usxs2k4gnWeaanQhzHnhzkYwJEXPglGQrhgGLajC9SrPxQFlQCBwjQLcTJ70LJ5FHkajCVrSTy51XIKBTa0BKF1Id59O+pjP8962IZjpGw6avI/J7YLfQMGJk14RQKtotydSHmSB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sy9ZBWds; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy9ZBWds"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e970f710cso306776d6.3
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 16:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788219363; cv=none;
        d=google.com; s=arc-20260327;
        b=TQYMpLpBuI03qQNnEIlqIv9fBuJswmQ9U4LBtQOwL6PZCuiD1AcibPhGbdyrPuMbHs
         V3a+iRKzFvUcTPpuIufn6XzUYPJICQ7sfA8fGdQTU8L72xSIPO2bhl6DRz9kB0TUe7ZY
         SCoeGO32zIe+WeoVLBsIQOC8jIoN/P7otpE5KEZb8zBryMhCB3Fbc+CjKJFwZDgqO5bY
         5p19jS1oui/sFvrJuh/afksA2J3GKVUAUeZaVlQmEwhv36a7bIO6USdFWdZ+X5YUAH8R
         378ygNnojQSUDwRpYjWsW6/kRLpgzUOl9ASRsMn7+hMTI9CMNITouH5fgK/WHVCwdS1x
         rkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNum+kgdZaAgFaBRWHJN3l688YcRNpqHNoOYWPD6JjM=;
        fh=XNdyQdOIEewVzXoBsfLNOs8q72EAPd1Ko1DqBeF6Kqc=;
        b=QSqNAkjQtRdoVxUha6lBZwrGA9QoF/+YTe0tYV8B12knxEv5zeo34Dl7gRfXIZuT0J
         dcZs5sBUpCzV3iRMBIe6TmoVrR9QTjrul7gJrlYfhatFd6kcleO8OkUnthKMjIXwilj3
         RG5+0ez9AiL99/GqA2Yq6q20n6TVpOuhu0He1B/0oh9x6hB4XFBElfUnATpOEEFSU+e+
         kyJY5z8CpHzGYRsWe5anbknxlBAi3VI9kd9qq3iyeUshPXGO25OII01qvwVACbDnchhL
         rcP2H7tLQkunZL3XU3eQTXlv6QQge1lVwJXV0DBsQ9UIse9mHIcSnfva9D70xd5R0oZf
         0l2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788219363; x=1788824163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNum+kgdZaAgFaBRWHJN3l688YcRNpqHNoOYWPD6JjM=;
        b=sy9ZBWds8knpcgMmii7VtF07pBW04Sb+DyKFt6w0TBnU3uef9orp+iEVCGhKXex58z
         SZUTlK/WfiRcEuzuI0dKPA7w5FEFVc130XYDRENj2L2OVEZWgAQPhGr3rp9vWxtwVSVf
         E1ycxuoROi67JKztXsnyDwQLa4DPIb+bdlOf9btOP9hOXvtaxxLYdnrYAstxrGBvBFkp
         zP2dwpFJ4a//xzPoJOlj23j3xF6uIfhhDrmGslFYRrt2/Grh3eJuzssQRkTHDIKwtWdQ
         OcyO8YT96XCUzKNTWbjiPuX/C2Lg59dM3IZ3Wru/eh+df48WQ7IwXCnC7pXykwOCj+zp
         XDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788219363; x=1788824163;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNum+kgdZaAgFaBRWHJN3l688YcRNpqHNoOYWPD6JjM=;
        b=WQN3xAx88mMowOPtWw0Et6rOfGDSPwI5Qfk2NaoB7FgbrE2L9LTVfgb52k0ttc4wuc
         YjbaEwnAY9dGAH7OlyRgbFQphWby/BuSxlLg0iuME763brsd6MPht2FuXOF5sA2Yx2gw
         JoDl6URP8ekjYaV9sZdxwWD+4JiYWVsOxCo6nJrKUEsFJGidoFb1HPW1INfJChV0uNBN
         N0wMb+c0DKUiYtBbTRA1MCzq7Pud0rDSneA80ZquPZsBH/KOzSs3qmmSojbHYz/pRJ4z
         el4/fHulUGEoStyR2DuvOuG6nXI4s+VE1ka+TpUOYu+OMdDGjTkLYqWdE8LVAobnAuC8
         vnhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUedjn8C1e/tsPKj2UHYNZN1UuejGhTX7ovmr4xl1te2vPIpOfgNNd2lHq9V6gOoooBEan02xn1DQJ5g==@vger.kernel.org
X-Gm-Message-State: AFuF++nTdwZgymCsJP4atChQ97euTQRMJ5jXLQtKpfsvLmJ9wdxMmCvP
	US0PzCAC/RUhCdWM30t9aD8fBjPWAzqDq6gXwASWb3OwUGjg578vm+adtU/COLpeP/iMRy9icyA
	g9pMP1+C9iF++GYAcpuso8c7LUquBLclYybcS
X-Gm-Gg: AYBFou34N8ZXyraMWNm2ny9vi80mcCurQpRLqtQWZd9FO7vbEp4TK00hU83xMGUea1p
	QKOFXvM+TlklHE9y5rnrk/dDNXiOZoBNMrqLYoHQ3WhVfKyq6+haN6e2pwKOfyNSIiFyILVioHD
	9IUjLwi87Un7mQ4DVTz7WHOHl8Kdq/5MLQhvBmLx8+1Rfd8xPJzY/IxuNUfCDbBUb6ppI+iQ/Qm
	qka9NbMSUIGGISqnFYBtlN1HAQlKzQIsVdx0GC0mZE+CqwilB1R09kdSnXyLEtUAzNNjhsADIHl
	PUGVtWmRhsCS0880MY+pnoVJUIvtkbFFjhAz51HgPOgGiQ==
X-Received: by 2002:ad4:5f49:0:b0:90e:963d:4c9a with SMTP id
 6a1803df08f44-90e963d4e35mr13013446d6.24.1788219362875; Mon, 31 Aug 2026
 16:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788096666.git.mradityadash@gmail.com>
In-Reply-To: <cover.1788096666.git.mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 31 Aug 2026 16:35:51 -0700
X-Gm-Features: AcwNN1VimrtqKaLKbT2p_0ZGoPZ0-TfAblpWoub3Lr8dw6kUn9FpJC6ZJFGhaq0
Message-ID: <CAFqHKTnQiTQc6joz-Y6tmjR=C5giF-MuHeBwu3rw+bmFVMQtqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] HID: hid-lenovo-go: fix controller configuration
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 7:57=E2=80=AFAM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> This series fixes several issues in the controller configuration and
> calibration paths in hid-lenovo-go.
>
> 1/6 fixes the calibration attributes, where the command and sub-command
> are swapped. 2/6 fixes two right-controller attributes: imu_enabled
> selects the bypass feature, and reset targets the left controller.
>
> Before 3/6, any decoded configuration reply completes the shared
> completion. The driver then ignores the result of the wait, so an
> unrelated reply, a firmware error, an interrupted wait, or a timeout can
> still be reported as success.
>
> 3/6 tracks one pending request in the driver data and matches replies by
> command ID, command, sub-command, and device. It also returns request
> errors to the caller.
>
> The firmware has no sequence number, so a late reply with the same tuple
> can still match a newer request.
>
> The remaining patches fix calibration status handling.
>
> The calibration status table defines 0x00 as unknown, 0x01 as success,
> and 0x02 as failure. A Legion Go 1 returned 0x08 after a Stop was sent
> while no calibration was active. The driver stores the raw value as a
> status-text index, so a later read returns -EINVAL.
>
> 4/6 preserves the defined values and maps larger status values to
> failure.
>
> 5/6 rejects 'unknown' as an action. The action table contains it at index
> zero, but the options attribute advertises only 'start' and 'stop'.
>
> A previous result can also hide a new calibration attempt:
>
> failure -> start -> failure
>
> The status appears unchanged for the whole operation. 6/6 clears the
> selected status to unknown before submitting a Start. Stop leaves the
> status unchanged.
>
> ---
> Changes in v2:
> - Drop the FPS DPI patch; the existing request is correct.
> - Drop the v1 Boolean calibration-result mapping. Preserve values 0x00
>   through 0x02 and map only larger failure values.
> - Move the existing pending command state into the driver data and
>   initialize it in cfg_probe().
> - Use scoped IRQ-save guards and validate the report size and ID together=
.
> - Drop the v1 no-wait calibration path. Correct requests receive their
>   matching SET replies within the existing 50 ms timeout.
> - Reject 'unknown' and clear only the selected status on Start.
>
> v1: https://lore.kernel.org/all/20260821214810.87826-1-mradityadash@gmail=
.com/
>
Hi Aditya,

I tested the series and have no complaints, everything seems to work
well. Thank you for working on these bugs. You can ignore the existing
issues that sashiko-bot identified for your contribution, I'll take
care of those separately.
There were 2 new issues that need to be fixed:
- [High] The newly added spinlock and completion are accessed by the
raw event handler before they are initialized, causing a potential
kernel crash.
- [Low] The patch leaves behind dead code (`if (!val) size =3D 0;`)
after explicitly rejecting `CAL_UNKNOWN`.

The first one is more pressing, and will require a reordering of probe
in an additional patch to ensure drvdata is init before hid_hw_start()
and hid_hw_open() are called. The bug is admittedly very unlikely to
occur, but it is the kind of bug that could cause spurious crashes
during boot that would be very difficult to trace.

The second should be trivial to fix

Once fixed I'll add by review and tested by for the series.

Thanks,
Derek

> Aditya Dash (6):
>   HID: hid-lenovo-go: use the correct calibration commands
>   HID: hid-lenovo-go: use the right controller selectors
>   HID: hid-lenovo-go: return configuration request errors
>   HID: hid-lenovo-go: normalize calibration failure status
>   HID: hid-lenovo-go: reject unknown calibration action
>   HID: hid-lenovo-go: clear calibration status on start
>
>  drivers/hid/hid-lenovo-go.c | 179 +++++++++++++++++++++++++++---------
>  1 file changed, 136 insertions(+), 43 deletions(-)
>
>
> base-commit: 1292bca0f8d835d2ad96d309595b2e97f3106d3d
> --
> 2.55.0
>
