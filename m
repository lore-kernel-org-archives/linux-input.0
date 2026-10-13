Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50575549380
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924559; cv=pass; b=k/pa79WueanINn7zPBDZlKE44Sgb0QoXntjnM/vMxCztIhrTpTIE/dIQxybNtz6Kq51CL4Ey8hhX3GE0ZmeK4lg/WdNxi0nU37iweDQl//EJjOtFxwut0iOUZJ0tLHhesjjB/fsy978495Pnn0TAD4UHR8e68x27agTLrLSJ5bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924559; c=relaxed/simple;
	bh=N4S4WhX9y1egfYubZD+cGlmH0A5CORT1pqeSQxAxxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbjUeuHN717XgMyzxwn/mUIjKJ9WGWxZbUkzI7E9a8IX4mz7arFnisaaUFnFFFhpuuWYIoFVTPvj8bU/TN+4BsV7dh7nhgtVi2K7DtsXST/9PwTXNqsAe+HvBtbPOf2l6bP/Mwwz9AqZQFrXzlj5uFyvzGbMjuWTQiZvcnCtTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I1p9abS0; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1p9abS0"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b06c0794cfso3856947b3.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 13:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924556; cv=none;
        d=google.com; s=arc-20260327;
        b=DoOlmI3J42capQ1X9/BvCE+BT2jWfGYr8ecLJSNHNbQOmZOO+8DAC46DnV8nmV1gCF
         pUQRn6qiTpURw4/qmFfb4UB5MWfr4tOjJRYvcrWPeH5W2HBL7aiT32I/v8Qy7LWXty1T
         oC0WGqUojsTgLcs/IFTn21MIs2icSSIwFhKgPEiNoDlPc6Tsm6OdZTdGoiE0OG/ySOZH
         y6H/3fAzFX3OY0CPbCwf7+0uas/5wpMQyGFeiYu54sRASZclXoPsGKJTYlqqdrfaH0YF
         RQnXu1/mrPfkmkqAqyfzz7UwueGEpTmJPsMAl8yeSPcrqOkFaf0OqZOmLsenYoPf4Eqo
         6OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        fh=E7x4Y/MqLdWAwOZi4WQVdric5o8P7QcqBSCWl+JJldc=;
        b=lre4O1YIbQqaiKczmmR/nVe45nrN8GyodxqEUaHYoddNuxnWG7EGxrqa7lDMmUlPm2
         jkj4BlcKgCFhXkuV6mCQeDQ5Jcnhn2Nw5K6Qks+WTaZQPQYEl3Z522x4zWuvfDxbUSGj
         aHd0YXu560W2o7ck/ljVJDJdXEk9W62ixrwEDTsrxVVJqSl40hbcQGBXiIYbG5DA/eJQ
         OGgTYDa7UJAbfEWGDlY9PXOc0P9by+u9kvrd34lWtDQoqDqDMBT4VGzXNMVVcXM6UgPc
         xzQzA0gZK71ksooONwpHg9DHWp253MdYiw5xA0Ri2I3fe3y9l7jaPbsiXtatO9XHIHAN
         St7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791924556; x=1792529356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        b=I1p9abS0I03ydil5tw+1+oHm1ZRrXzApJ/AyHzRfe1fNjgAPynndgF9MlwKwcXtX2L
         mv22K4aWNMCfrPIvMq4w60WpmeecYq5YZpIubkwPRtTSUv/nBo0YaqkqQPdCbwChnmNh
         C6H0fVgHya/BqUURY0utSk+jRiTHujEtwkfBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924556; x=1792529356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        b=0eR+l1Z0iBlw57d6I7q9CKpDfhpq99LVfJe+HXBXXH3cvl1kEeC4oGKDZI9qX2WkxO
         Nzcowx3BQh5OmB1dJ+MUBnNMRWbvo1yA8123RxArXLg/KfKPX1Ty3od8H+hIlyEcv0it
         O9JHqNotb9Yb98pAVT1nsrBfsJyuwMHehyou1EJ7laUG6jGzOX9Xx7zIfAk3o/W2af9i
         ZCqmOlIhFoqjbWL/ZejcH+SjUVW4fGAjdpwD85lGscJAvkKSfRVGJYo/78sPRVOGVIF6
         ys93wve43lINKzDpJtU+jyepsFxqRH+3mK9HVlzDmTBeDvOqVXYTzCjEHLu057Jt/A+H
         k1jA==
X-Forwarded-Encrypted: i=1; AKwUvByW1tKhmPiA9OZa3lP/DnpUpYhDE8crIhBrt3l5VaY7s/H3RLkwV0ueKANG0djSiDoMerSd+N23lfzgEA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJE6JFs85VrgqYPggdfZHOigpk/z88es+wojtVeV5/4OMDXWxP0
	OTx3XdhDGm6irSEASeDt3Y1ruJMvwbLR8J0fjplDwP4zIeLrQwNN9T8GCH/2BTyAdRmywtEudCR
	W7iDv/Y5p6clx/MIBfJsAIbE1taPwf18Ge3cF3lvAnhXkOUVE/DSGoQ==
X-Gm-Gg: AYBFou0FIiuOKdQE7XPDhKdw1oReGbWzKtzP6f6nhmEr0HWCstQ+f2ffYiL/yRkMmde
	YSB+AW4t2iZAOlnitwR8ZAr1/gyOuKvNJ+vukCl+SI8FZQxYJSrmdZEHsqIk/Q/StKtmUWmwhGN
	4t/MU4qMzivT8U2adO2BMinSPOjzfe2l6fbkR9xBdveiZCH2JHG+ANilcAhMPWkCM9XDHjrxp+g
	PZ/4U8jmqNmnuw/C62XWionlxNudas0+20lzTwV+zozX2Hz1a1CEHq4L/apDvD5PfeAabBClrP2
	ZCbiHEfY5IbM+0KN+fdH79IZn9pH66i4BR00B0jyugsQi5uWnabrP+vF2XZZfcTmOkqXN/q90ZR
	CJlxypxKI9A==
X-Received: by 2002:a05:690c:c513:b0:8b0:a8cf:f424 with SMTP id
 00721157ae682-8b0a8cff8d1mr29927657b3.41.1791924556355; Tue, 13 Oct 2026
 13:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org> <sashiko-outbox-166133@kernel.org>
In-Reply-To: <sashiko-outbox-166133@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 13:49:05 -0700
X-Gm-Features: AclHuK9FMbu9JZUnRnsoojppgwhlqyo5kwjgao5eIiFBqF9-3uTME2iK-puHtSM
Message-ID: <CAEe3GZGi02TbXmPzFKKdf_nU0qejx+xeRW_2xKQ0B7RTk-VqEQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:29=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] hid: documentation incorrectly relaxes asynchronous requiremen=
t for output_report
> --
>
> commit 6d8fa62fc058c7f5630a13cc92c85b7867bc9869
> Author: Jarrett Schultz <jaschultz@microsoft.com>
>
> Documentation: Correction in HID output_report callback description.
>
> This commit updates the documentation for the HID output_report callback.
> It changes the description to state that the callback might be asynchrono=
us
> rather than strictly requiring it, citing i2c-hid as an example.
>
> > diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hi=
d-transport.rst
> > index 6f1692da296cf..2008cf432af12 100644
> > --- a/Documentation/hid/hid-transport.rst
> > +++ b/Documentation/hid/hid-transport.rst
> > @@ -327,8 +327,8 @@ The available HID callbacks are:
> >
> >     Send raw output report via intr channel. Used by some HID device dr=
ivers
> >     which require high throughput for outgoing requests on the intr cha=
nnel. This
> > -   must not cause SET_REPORT calls! This must be implemented as asynch=
ronous
> > -   output report on the intr channel!
> > +   must not cause SET_REPORT calls! This call might be asynchronous, s=
o the
> > +   caller should not expect an immediate response!
>
> [Severity: Medium]
> Does this documentation change contradict the strict architectural guaran=
tees
> of the HID subsystem?
>
> The HID subsystem design rules mandate that the output_report callback mu=
st
> be asynchronous to prevent latency spikes, performance degradation, or
> deadlocks on the high-throughput interrupt channel.
>
> By stating that the call "might be asynchronous", could this inadvertentl=
y
> mislead future transport driver authors into implementing blocking,
> synchronous callbacks where they are not permitted?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D1

The "must be asynchronous" rule doesn't match the in-tree transports.
usbhid and i2c-hid both block in `output_report()`, and hid-input calls it
from a workqueue as a "synchronous output report". This patch only
brings the documentation in line with existing behavior; the actual
requirements don't change.
