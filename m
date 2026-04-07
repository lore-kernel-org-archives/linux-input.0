Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278333CEA9
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589743; cv=pass; b=FuYTKoXIArKG7YfTvItRXw1dQ92baHt4k4Sm+v1PZGPTXMhLoPozjvx+KwpmX+oW4jOlQFy1h8BaKkcVTVS+5aC9mLNsyfoNz/sU5BUGcJV/B+t0wbOxDIIiKR4hNy24zJqyxOn0N9jY82MCNiIgB45O2QocRVUKyLCdZ32FP/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589743; c=relaxed/simple;
	bh=t4BYjIt5/o4cPQvge9Mj/A8gcO61XhkZs6dtkTR0sWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P56ochSxQqpOBNTZBvx69kYySX7E3c0v75WyjbDoJ0l5I30RtYlhzOEGxRaeJBwBAvBuj32b9ztP1sXRwdzNXWikCofo/l9Q6vvX7XPw7LOsLZUoJCBo2mYIh/JDuBciC/ND/0P4TYnPgVyZzjA8sbNcA/xjolGhM7OD5ebgnaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2wo4MO7; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2wo4MO7"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a08fa355a1so81813506d6.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 12:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589741; cv=none;
        d=google.com; s=arc-20240605;
        b=FrUnqGYtYHpv9ZLd+yqHW68aPnYOFXXijstJJftIATP12Wwl9uKQNRBOzCUYLAh3M1
         w5kr8xVTyGDXnhzk5Vu2KTc+CRD9q0ekYiPl0DMn8+cw4m7J4AquDdapMN5+FnmwQ+QG
         m/KRAHwAOt4GcTErjV3vq7Jzvtof9hX+JLpys0yiUBoa6xF8qPLONcdBxKUPDIkygFn7
         Qy2yNT+WS3HS4XeCSF5tUBu+itdmvICbTbI6xSMLtc/Bc28n8lCCufT/+TphndYQuW5d
         U/zvbnRxY1zPQoSGwv7OKSsaK8/iRqOTxc2ycyEJs4J/A7HRy2uUYWhEZLMHWJGjD8YG
         8aBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4BYjIt5/o4cPQvge9Mj/A8gcO61XhkZs6dtkTR0sWM=;
        fh=DaoHJLi56YItowKGaHjtQPB0Nk5GSmqerIjzslKoUsM=;
        b=b6U3BI6zXPgfqK1kBwzBGL4Z8ukN+NzwdHMVnEK3bFbyj3SO5qGjIW372JFBrWimYH
         eSDlMGme3q+RrKM9ncaWjU2WYAdd0U58x59rWNjZt0Hyf3ppH8cV2e0kkBkT3VrauQRx
         GosjOsp97XEYkCGjjQmnNn26/yML9hOipreZAfLMhXNRnJHFkvcSjzR4h+Yfhpe3+rOj
         5VKKLQ/WKthZRtk756MKZs8aT+VbZHi+McFr78KCK21Bhw4FjNnFL7iVK9XOQ2FVK8ZG
         D9buxDmK25FF3QlNV9QzDF9fI/4c5EgpswDcuS66gOSrnBeW9kmSIieigMssyo2OaEEK
         dvjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589741; x=1776194541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4BYjIt5/o4cPQvge9Mj/A8gcO61XhkZs6dtkTR0sWM=;
        b=B2wo4MO7Z1+dJUO5m89QDUPtSmfoXiYyu+H4B3EvJqB4d+IPdHJ5W3IQw3MZZZ/S3t
         iV0f6t2fFPScQh3X/s+Vx7YUQWbFhufCo7Rsl3QT8baTEe/0qdd33CLaXZEEQT9zKkot
         39e3ooTHMZFlz0os14ycKcVWTtTxxUODvCSgeKjnsTDbFVki9PWtWkSSeh5O24TbEimW
         on70q2sa1vZHn7Y1/23s0KgKnCmruyDjSuT9LJUcnENUHz9K4ELBotrRQBhZWLnYuSA1
         XtP3DEbMW3kU/Gj+ddPByaCshHs62yV6nRKH2G4rguZex3axJhY20ohzN5FH32Sv8uwX
         Rn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589741; x=1776194541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4BYjIt5/o4cPQvge9Mj/A8gcO61XhkZs6dtkTR0sWM=;
        b=lKZUIuKelixX6D+vQR4Lxn4z3e1goVM0sXE1/7ja7m2t2BAzAaFTmujd8e3xGmkUjP
         3C8+meDzcN984KazJ8xBidliQCvBCtASSDameK94/A5JNcKbbAJ2jjnvdRfD7I3ejInB
         eLj93oJQZ4gKxZwzrcjkQAIqVYweE/raa6pr1hN2pt2q1qk6pwAG4rT7aLnWICui0VIb
         ZLz6Y92JadC0fnEMwaI4eC57f89amBZNrJw2XnjCmAaWu8QtZXh8v5hQnBai8L7VrgTa
         o4J0z9FCoU6zpa3txpXKMRLozun5mc1BcH1N4pyZT7QfP9LF3P+D+UUNFEAWqalioDKe
         OvxA==
X-Forwarded-Encrypted: i=1; AJvYcCWQWC/DIToH/GsRoYFFBgvyv8jklFtppipwwyd42XEKPp+eD5OACDo5upxWMDf0ag+UqJ/rqHB5ZINRlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dc1xpVsV+i0Kvvj5+9zJ7oCUt4Q7BcmdgQNCJajSDRabbhlr
	EiQpUe5aDlpiZNBWn8HRtL3gQymBDuJZxOgGr6AkWBv/lD04kEa5/FG59txZMgXa3IXCGiqEQ65
	JYr8Ic2Zm3R+sF4vTzmNXEkXbX0Aj+7E=
X-Gm-Gg: AeBDietjL23aAnAQ0+oQZfL85b8hHOLL8qJFlS3NR1N6wr2Az+eAEgHgEDT07c/EBVs
	+sLyzgELq8H7bIrBTvLVqBWl1mQm1UH4+8QZBetL+PhR/pk0r1Rm0jOqX8NG+H6bS/0aLAeXlgb
	xrHtbX7PZ02l68Ne/cUK+70H5fLeXRFrZ3kJ7js0vpYB1y9bSA62aMLMka09cbhH9SNKTPPixCP
	FcSoA1rjg5tcxZRf8/EgZDFU84k6aEFrxwGQsBEPAf20h8r2hgZUWL1WgAJbAl3WuKNpu2mnhPA
	gR7wjk1aHqLNm9IW+RgFvCuYYz2TPe4Cx3VorjUpaYqEnDS2giKrdCOv2AgIT+SlricnjO1LLiO
	JAeZ7NDwCKho=
X-Received: by 2002:a05:6214:2dc5:b0:89c:ab8b:8440 with SMTP id
 6a1803df08f44-8a704abfb6amr331742716d6.39.1775589741456; Tue, 07 Apr 2026
 12:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
 <adSJp5U47g1JnImj@google.com> <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
In-Reply-To: <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Wed, 8 Apr 2026 07:22:08 +1200
X-Gm-Features: AQROBzBAh_G5ii7B8aFn4CaNIm5P80rs2_RFont4vpuZr1yPcxdv9ea7NlPatKQ
Message-ID: <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com>
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:46=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Sashuko correctly identified issues areoud re-scheduling work that
already completed, please see:

Is there a way to test a patch against sashiko without submitting it
to the mailing list?
