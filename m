Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17A3890ED
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543803; cv=pass; b=oqHjIlUFD8oKsHOoXqZUEa5wgAtkL0dG1qDs0lWKObQShrwImzmht5ss72YWQoN/Jv1EMXu7H98m1jrpu1vo9wvJbiXNP9NgJu9aH4lcfeZttKGEc7RB6Ptg4BQqBbFwwwQn8/hYb1sC+y5usbkNBGlLsVKzjAErNzvEKOokJHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543803; c=relaxed/simple;
	bh=0KTV1piEa67h9fbXdHytFQysMdXw0NexIEM8lAxKmHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKuwfGtHBJVu58DRJG2KJlUIBrtteZvFiYuZ57rZewn1NxhZA+R8fcfhMu4sO9x0eI2rOFMsisxbBXTwY5T5u20mgZ/HfdqF+DhdQdmfsd2icdtA5ZYyItCzQTiEUwj0zFLnsQ+j+cw3kjSykRloYtrX7bI5UazXotMe3Y6+EfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjtxcCQU; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjtxcCQU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e0aa4221fso9879761fa.2
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 23:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775543800; cv=none;
        d=google.com; s=arc-20240605;
        b=cGgGiPKaRAB/yQCvRnvom+M2HjN99wi1rq731p4tt3Dz/r0V3rwKlzzhQfUqeZfOl1
         xKhKl8bqeLqvq/pK+chVk8mByCwOeCl6QIBN/+i2t1cnf7sAIn6m0lBJNlVORWGZNu+Q
         KDpZAcns2X1fogOu664G59vXkzAjJLvk6i8y3JA+qtfxI8xbIwD3Qu2Ldcd75TI2BBAX
         MqJ8zJ6UdrWyXC2au6rVPQoYWBMY+zmmD6QiFgw5svxGYdKTzCWjApHDkFybW5LKN8Vf
         mAAs545byCEyFmBBHK2XvP3HXZzZAC10Sm6C3HEExGUFYlGL6+NFQ7mSri5RdBWXwJWR
         fwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KTV1piEa67h9fbXdHytFQysMdXw0NexIEM8lAxKmHA=;
        fh=W0ONg5d/Igb9IujJdyLQt4jDshvpFFmYJUloX2vSx/o=;
        b=f4MTwLHuesCbqPGZaRoG5IZ3fNonQJVR6BiZtGEl1T80URrrBpDtkRLtMOVw/9/iKh
         TCFVB5v9+TqYrVnzVs1uhDbsItQvBezOD/a6QFL7m/jSd3cnAoH5YVcJUkk1nM1Nck6n
         AQDIOvWgqIlRY/iSLB9Jh2mmL3Vfhu5RQQpnnfOYx9jC2StkV0JbPKPKTxUAC355VxkL
         t20heYJ7kgFEYuQ5Mhxi6mcRzFYebQvPhOvB/W9BtB1o+zLGBcV+9UELPVSdmXovkp29
         /NlF91PQnso5c3mWjYINRvWFuGlxMtIKh4c+fqYdRyvQ9J0SPrjb1hIRNZomtPg67ArS
         FTmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775543800; x=1776148600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KTV1piEa67h9fbXdHytFQysMdXw0NexIEM8lAxKmHA=;
        b=pjtxcCQUqqMaVGwZwpZjxCFZCIMz6YtykBF1r9MUH0scHuLTnm0F/T3aIGzfZM8ORE
         LxcacKgnC4/pY0Jm0ui8EGga1EruhqWiDoFBWd0CJhad7VqNKtK+k9TXHF85HcDm5/MA
         5BkjDZ5BvD2tpxh8X0yr1USA/GlYm9Lcr+Adek6+MXnzV/P6IOxjZUooGNRNvrpPsQJD
         Y4X4uJApeftOGyCQDxxA4rs4kLpaNcD0PSFuJmuSTyAsVSnGs6LRRzay7ST4piVCWk0Y
         HFQzq0bthaR7gPbndPIbNNoxFJ/+dB5cHH4DXnbcqDCKtQcfjhB4jVvNlEPLAQWEhAHu
         Mvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775543800; x=1776148600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KTV1piEa67h9fbXdHytFQysMdXw0NexIEM8lAxKmHA=;
        b=CB8nVQd897s/dVmDJq7NVp4JtIia2ttEbc1aDOZXHvH0X7zytqI+el1lbxe94EH3Es
         GByXMUEoWyPKVPXe7TfQ2B1SwrAymgeb0yAszbmR+yCwbbTFie6gnD/FpyIfQy0EcSre
         OH2PAPLMkb1rX6jVV8U6pwW083Hx5aYtFmAiA6Rc/Kv9lf1RkGcnksNoRdRMA0EtB3SS
         yT7/Ye6p5STR6St/fA7h88YHTV0xqHSBrM56ng/0ybCGbCZCzB+plr6aj2Xg+1Lf5JYD
         9hh3BNhKOC39HcaW2Vn5gWpwFIsb5I8kOZkndIntzav8LbcN5RkaFEu6DgaA3vV00dk9
         XAjg==
X-Forwarded-Encrypted: i=1; AJvYcCU0KKlODW4cSJoZXyJZCx/MU1rN5t+TasqDgvXEBXvm6aP6c515C5/PcDEDqfJNXTiB/CM8iw21/LginA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/zmThgTKzr6ZvuPTrB1hWe4HL9tFN8ixNySYKLpgz+rNKv2G
	HPAbEt6QM8AxAUWOfpxKYK48+Uxn0cAzln4QCcZGJF6j1KIDUXWSBa9arEnvB5841Qtfl6HsUyV
	P3fVtAQAj+ZqJ0IrWTmNpgL1WdMCoMHc=
X-Gm-Gg: AeBDieum0SfI0AmEU/bTRaC8suhmcZ5LxBIoxmN1FGOHuh+HPaTLhMlbnWZrArlaM5j
	Y7p21xv/Vc/9AorYjqCTxUj9ujQ6bhXJ4QC9OCVbebBvVyP0QnYCUgcHwExs2nUCah/MtgZ58m6
	zsACUKywYBsuw3Ah1R84pERv775tzg937JjF2892HlicWi8TaiBfIcjUfptQ2JXJrANGwkTsnlw
	k8jB+wfKyb0WMnrw/95PD/QNCpxlo5T71Y39s9Q3Xm4GyftUBErYnDIbd02sORkJydhO3GMYjrZ
	fCokGIzhunJiv832w0M+Qfwv8oKb9YzkLf5PSI6rrFDlVRUhWbdaFmDP/DMZ08Dv1nfIafA4BtY
	BONbecFScKJo=
X-Received: by 2002:a05:6512:3096:b0:5a2:c6f2:c217 with SMTP id
 2adb3069b0e04-5a337558230mr4951342e87.14.1775543800007; Mon, 06 Apr 2026
 23:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404083928.489966-3-sanjay.govind9@gmail.com> <adSJp5U47g1JnImj@google.com>
In-Reply-To: <adSJp5U47g1JnImj@google.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Tue, 7 Apr 2026 18:36:28 +1200
X-Gm-Features: AQROBzDnKG9Vz7PSqTwsNBT9y413jgZH5hEGjacFPHk-FidaRHO09dS_JJlXocI
Message-ID: <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
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
> When will it be set to 1?
The link report itself sets it to 1 in some cases, but i think i will
just change this so that if we get a link report and the vid =3D=3D 1, we
set wireless_vid to 0, so we can rely on it being a non zero value
instead

> Maybe this should be disable_delayed_work() instead...
For simplicity I'll just get rid of that, and we can just always wait
for it to expire instead of trying to shortcut it if we get the
capabilities report faster than 500ms.

> Can this also read stale data for the same reason if the packet is too sh=
ort?
I'll add in length checks.
