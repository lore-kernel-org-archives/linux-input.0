Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610236164E
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052995; cv=pass; b=LTRb/2dDBQkuV/UP2REzhdbgjGNTlTbU3ch6PrAIsQhAsDYtiZerkAbPmoTYIKiDHoD4OcXc8eN/BkraU2UAxuCjc80PDDaeXLU2y207epz901U7Q548dlQsLvXxyPjGxNVVgQmG6lvx5fiSwH2881GFavADupND+BAsxs7rZMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052995; c=relaxed/simple;
	bh=xnFjURGcC9mwc5Q/a/TVmDEA+1HFKtEIWS9kmopnHqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsv24Mmm44VZY30LfsjMiLbmPksSJcnZqTfiIUuWNx6uDPrVenSJGvzODP+OiZ99Sad/Vv6GjdkmcWM11Jz1GKIMmXnJlWBDk1jFTCggTzcrU2vIx0HvQgQ9NLueh96EhGMRJkXFlnzKQ20tlcH8M9FcjOV8XXP4xwEIbA4eHE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTVpYeC3; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTVpYeC3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38cc8708d76so31350931fa.3
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 21:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776052992; cv=none;
        d=google.com; s=arc-20240605;
        b=D+r1dJBscwN7VCwqFBBDFl3Ootl73l5Wpb+XqWi9cHKWXBClOGaJ2SeblFwmcy5G05
         Xw+KHiXtnW+w2RVSeTdmrw2Fe8JuV0iT8leaXNSj06SSsEr74phng2VwwwmZfz5JCa4a
         fwIS/28OJZIbMkGC/ePyBaWfAfkyR0DLttr8OqwC+iuz3N6ND0/FGByELwE7Z3rFqk2K
         zJ9vsTuwATMJ149S7E8jn6hfn6PF+w17gxWr01AaYwcnEfCcB6pe3jswnHlhtTkTsX2t
         x3HP7xQK8w3YKOVa6DZzJ/P7+xyO9yDzxBhwWeAOGPg8gxl3quY4gLAuZ0wBB3b5DGwS
         H4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=95H/QlgBc5RQr/l2ccnGAxTUXjWqBmxAcOZN0vE6yyc=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=J7aQavacGKMIpv5hpxZNb7N+UsMsv4etnguOaaTI3aQsvDxIxuzOcLyxZ9J2s0sOD7
         9iad+9DHXSlI9wSNo4gll2NlmSdgCm2A3cUjAeTCx2vHPvWAHGOiQSsYyCf/TkLjaHpD
         m0yHKSnAVpQ6vAi6elZ1Q+772GEMm1rDIlBBCO8slrS/ac2mWCflo31CQyJ0GctVhFbR
         bRqgXCK9X9vA83aZeuS+nSR+SltlEkEtvl4a8/CAocvJ6TeXZtzqOlXyEjZ2J4/tig5j
         /ugzYDpGm7/rKD72Jt5PqieD1iEbXmYOl/lf06jrRPnnoEjdDkZ3FNxryWk+xVhVwdOb
         KhtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052992; x=1776657792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95H/QlgBc5RQr/l2ccnGAxTUXjWqBmxAcOZN0vE6yyc=;
        b=cTVpYeC3Oj/Hs9GwfAIh88YDmvvE0fHUY14PkjGxqTcjvQjKMSY5jwS3QLrzEVsC+S
         xNDuq59GP4PcxQa3+aXf0Nztl1erptvhEqvyY/9wdlqRvoFmvckL9AGrKA9RQamVukBF
         xM4MC+7tdof1yXEoLDPOiMVTPDLYb5o+U4MeatrNOAuFpjeWszpx2gBzoaGqrY2C5KcW
         VSuxtVJPUJk8b95Vhz5r7b49VWAHjLkVHUkNzXrd20yCg5M9lpNl7r7ybEl8rQFJB/aO
         LL3ZShd6hukBv4CY+mZKvRjV2x+S/ets655C6c4WL1AURWuivUJCHOXQav1XV0y1hQ0z
         n/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052992; x=1776657792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95H/QlgBc5RQr/l2ccnGAxTUXjWqBmxAcOZN0vE6yyc=;
        b=KeAD8ExVzH4Kpw1c4Ev4TMrC4gNpjQLN3Pgdn0IvHqTD5g/6gEUYDF3vp3CFnDd8fQ
         2CJtjEDYoiaytQMPDDS2tbKj7nWe//jY0fBRMAqYZ0w6X63dHR7ujsM03g4tNQnG7NZ6
         r9fnjGS1jfZ+pQjQq99SHySnqOM9NuPmG3u1QfdX6SJtpkYIzXLvrUTQjWWnrjp1EDSw
         jWBFLyn1tu+WSHp7+Djl7mUexktRTDPzGIyFt5RQEbJzJaeMZhNQ/VGP0pOcdJ9qgMZ9
         t9foe2F5P42ETve6NSitFTNXDpY1jTLYo0aND/ZcsWcI3V+FndZrKbIf6igWx2HsBLq9
         mE5Q==
X-Gm-Message-State: AOJu0Yyiy4Hog1as03rasO9E84oJzDQfe5D4nX9X2KhEwasvxEFBcq7r
	BQvtBru0Ji99fb6rK71CxokCe1Uo2RYXtaSaDhYLuPzZ5+o73TZ8AtzeLIqIcQg+UPFaPjMpSlh
	kguq/+ir41kKBXeN/L23wGx+BkQ67vuE=
X-Gm-Gg: AeBDiesNZlbce+IG77+mY4Qb4DupJ6+2CO86bx/Z8n/w7SM/m/OnvzqPWZnE+lgBjFF
	A+0igNJ4IIb/VhZyHZh0LF79gbw0qaRYTCZGkzTxdW+v1+Vb0kfYikl2eTqsoWc7GDfJRzt0XCg
	uw9yGuJpVoylsq5viyzjwcBGwSWeyVcMKJvJx01iyUq4fcQL0zfEFm21nttYAkbUgV+/5/TVj/A
	R6NQ23od771Vrtb95f4Ax1waMzUf0DxvLbd07rpCHjVgFCXvEI170jZxQyhHfB4UJyYynO5WmH5
	okTXJCcGmcob2KadD+04ybpe2ECAuR7rqkAi/bKZ9uOKzAItIa+hW3P2pM/8PwOjw2fs
X-Received: by 2002:a05:651c:f04:b0:38e:4b8:4644 with SMTP id
 38308e7fff4ca-38e4bfec6f7mr33021391fa.34.1776052991347; Sun, 12 Apr 2026
 21:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-ft5x06-label-v1-1-21e8a9ae9a60@gmail.com> <adxpdaSXYAa9dLPD@google.com>
In-Reply-To: <adxpdaSXYAa9dLPD@google.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 12 Apr 2026 23:02:59 -0500
X-Gm-Features: AQROBzD36ijtQLFWaIeZ5U1ctxOqnjHqMq4ws4BaFNLEqMBaNDO3T0_KJX4mfrA
Message-ID: <CALHNRZ_m-hWpmp5OgOjHEc-QHRAkmTGaJX=O_K-X6EwY-5ToFQ@mail.gmail.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - Support label device property for
 input name
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 10:58=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Aaron,
>
> On Thu, Apr 09, 2026 at 06:16:08PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The AYN Thor uses a ft5426 and a ft5452 for each screen respectively an=
d
> > these currently get the same input name, making them indistinguishable
> > from userspace. Support setting a label in kernel dt to make these
> > report uniquely.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/input/touchscreen/edt-ft5x06.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
> > index ba8ff65f7ea671..c36497571b1aa1 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -1285,7 +1285,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client)
> >               "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
> >               tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->=
num_y);
> >
> > -     input->name =3D tsdata->name;
> > +     if (device_property_read_string(&client->dev, "label", &input->na=
me))
> > +             input->name =3D tsdata->name;
> > +
>
> You should be able to differentiate them by their sysfs path.

My target use case is Android, which to my knowledge can only use
vid:pid or device name to differentiate input devices. The sysfs path
does not help this case.

Aaron
