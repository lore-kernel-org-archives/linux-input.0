Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8921F5423
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797743; cv=pass; b=iCv5A+Eb6ZkBrMXJijIDPhwCks6Vc5fgWTgsT7uYdcHWjlV35o2br1FJGC+ggjVw64xECAspbL4wtyAiwGHJbybqG0onZMn1IyzZKpZcKkpndoOygbRDUpsqbAqmZER24kFobF3KqGXbDZwTMT43kNTrZ3/DfHb1QSfAOjfMD4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797743; c=relaxed/simple;
	bh=r9hsKb9PfTufYzjHiq0hMbGcpfgxzO52s1Vpsdo+xGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWoL2V9xQ+0LEPh3Ka/oVO9A0oly4Xrw5mdL7kV7o5QY+y+vrNpwcsspStIYD95P3oFfyjikCaeWHzsGArFNcZzUiJp+1cC5Fi4DLvNXAp8zZ7Fw26JU1B8VD9Xid8u7nQdXL5EfuwrQAytj/CbhOK1kyisjfOkajN0QLtUG7zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJb/EnfM; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJb/EnfM"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de8155501so248793e87.3
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 18:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773797740; cv=none;
        d=google.com; s=arc-20240605;
        b=K6mRu8Z62qvoAPUkYJu2NQq0bB3B//vtXH51K5TS2rPr4G8dr9UEtp6y0xS3uLT56e
         Y3HnOqABf3ocXRjEKtvLKBa6rswYcbj58pCtqM5Ee3/0Bk3zN3gho1MQ2otJdMRNtlNU
         Di/dTT8ZgjXXwpEJwHPklkLAPCGBqFWlxZWNkPA5RKeZ2I6OQ8gm7drLJjxA3eiT/DsT
         Lkz/RWhkbfapr5CPQS89CChCM8lVpbQj6GJO46MWiWUeu/qKqeIulrw9JqTARcYi1fi+
         y16/2umUcyDw3Dls1HDwDpOeuE0wGU2sForzEjrVivuGE3wtfavtpxXIe6qrN0T4Sb1H
         zM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnHRGZux9J8/Uki/jwcTCNraQa2a1iivTN3+HD+7Wu4=;
        fh=WgBcimFdOAyaKgehlcCrMscGC4bVaIqY6bqUWRKfJVY=;
        b=JSCzdnco36TwL+RPFUFdnYUZtkJU6/k4aiNuVvEwBRa4nqz1oHKJahw3yl1VCkYCbC
         dgEVjCq5z6IK6yZyURkqlsKIJt9oPENl/X0Qu7D//jzvA7dl5po0Ury4dPoXHaFHu9nz
         HW7DcIU/75aYgtv9qlFFkIDZC/W8WJ4HhBjiGCUbIN/GAeMMY+pXvUyxeYYf8Q3U7tYC
         l51JDYoTp0tbVPDWYna+3WpgNpaLuX0tTtCVFu8sO0Q+dJFlWvtifocHB7k5Vhd2UU1y
         xArd/Xmjw3M0OzRUABIklWIJcJBmwBhY7WPQrUgmUtFVhH4AI7wi1cR4Hkj2PnwWJdZn
         VBpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773797740; x=1774402540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnHRGZux9J8/Uki/jwcTCNraQa2a1iivTN3+HD+7Wu4=;
        b=MJb/EnfMuI8mxqMYieH9cSSAYbkj1/9JrXHzCirnzWKMiNdOd+NHuD6KqvuFBjtNmY
         vqLqqIH6NS00QytxnujFiXf/tgxFtvPQvCHvLsIXJnJN569g0cM6ZnJPn4VdmJBDpZQE
         hLKiA2CLtIrPhWEK/u8MPCwIGW5Oh9Q5dUAMD5E1wjg4aDxUdQPukqf/jrJmVFXc+dwS
         hTqYsUkZLFWaJlZrSYmH4/vQ6n3S/rPodYMMR3dc3cPLb8ldk1Tnfq+K7BHjeaSpeVYY
         bYo8ebgNfQxjDrV1wN1PvvfNWnQ3DWfz+0reXYT82J8bDzZoZFxw1YrhNX+8USWsuxFE
         O5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797740; x=1774402540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bnHRGZux9J8/Uki/jwcTCNraQa2a1iivTN3+HD+7Wu4=;
        b=deo9wBxY0BxLyrC+BoG+UZAz/22voyHvxt6V8XCIPwoa4cVXzH65+zNyoZ1Qmhgmzs
         NFGM1OvJXnxd973U2yPU7AizD5gkGT55R7CapXVeIhow2gaYTXVTjk+z9ULUIRayZ+CB
         zPznHVCOkqCWdKZyKChn+TrakR69LzyLyrEStiWlQbdmb1IiMYgLq22pvHae6p0bIqCJ
         fgoYb60v8vUYwv6VbL3bHpf25DrYWvGdxwU4MiRSfPF/dzdALmrd2WlejzqYPEq1ktf1
         2Tu4UtSBFH5/rYN9k3bnvIqXO4QgqIOxTbk4i6M2JMFYOmyShFWqMZnwhen4MRdb2LWD
         NHuw==
X-Forwarded-Encrypted: i=1; AJvYcCX8qou6nPBI2U6q+8qj4qK6q0ho+zIFQlrUzm1prypV/we/vxE64j0ZqB2Mp3jFtRl51vUJKhcLYjAjLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7D7dLrtSb6NKOGhiDeIfbmNL2hLaa2eWT5LZv+z5sbjLGrvZK
	XsRJkcKUvdTnM8yDqBeQwF9M32YABB/gxs+LjAqtP6ypJDbojBzj39S7yatIUkqT0v0jnm/4OBn
	IxvEx9wHhjL5qMBPlNiClMggyR8w8YBw=
X-Gm-Gg: ATEYQzxR2/K3lxDz49VTZ1lNxI4Ugzj05M0h+h+NY2zI5AT/TMsHHU7nzZ6zp5qTkFM
	hJQbFPZl08gsPlH3JJsWm8zPMwvi1hynalKuiM6MZSW9grmXhoIXDepAWjLIUQg7MAOs1vVPpft
	YIDf4Ylk0KqzOzTu59OUoY7EHJ82RmEsemXRNHbRTNeO6itzEiWdQHCgRoDOYAVwoE7bNStC4a7
	QXF2ttYx3H5PCqTBjFKOiVGsPbg/KP7FX2/dVNeMqZm+O1NVWXLnjIBTx30Uwdg8PEhFy+m9LbO
	nd2xh9E=
X-Received: by 2002:a05:6512:3258:b0:5a1:1914:2bac with SMTP id
 2adb3069b0e04-5a2796b0670mr475858e87.25.1773797740151; Tue, 17 Mar 2026
 18:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311143144.482145-1-vishnuocv@gmail.com> <177376698425.15640.5695107795590543274.b4-ty@linux.intel.com>
In-Reply-To: <177376698425.15640.5695107795590543274.b4-ty@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Wed, 18 Mar 2026 10:35:03 +0900
X-Gm-Features: AaiRm53Lg5Zo2AJUp6xaTGJ_mBVnBHtnars3jJTNT9JwA8Rtk6OghHrOaVZ_8Bo
Message-ID: <CABxCQKtNSjdj0pj_-Bt7Jrs9pEp-SbOyjGUno8xc8FpfojGpkQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] TrackPoint doubletap enablement and user control
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mpearson-lenovo@squebb.ca, dmitry.torokhov@gmail.com, hmh@hmh.eng.br, 
	hansg@kernel.org, corbet@lwn.net, derekjohn.clark@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you for accepting this.

On Wed, Mar 18, 2026 at 2:03=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 11 Mar 2026 23:31:41 +0900, Vishnu Sankar wrote:
>
> > This patch series adds support for TrackPoint doubletap with a clear an=
d
> > simple separation of responsibilities between drivers:
> >
> > 1. Firmware enablement (trackpoint.c):
> >    Automatically enables doubletap on capable hardware during device
> >    detection.
> >
> > [...]
>
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
Acked.
>
> The list of commits applied:
> [1/3] input: trackpoint - Enable doubletap by default on capable devices
>       commit: 9a98ebe630cf13c1a6063afa676d1cecc44fb2c9
> [2/3] platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint doubl=
e-tap
>       commit: 6227cc32fa01ffbf5bef8dcc6759743a28a2ad57
> [3/3] Documentation: thinkpad-acpi - Document doubletap_enable attribute
>       commit: fa5062e99b984448b7c8ca9aea47e7fc033b6e2f
>
> --
>  i.
>


--=20

Regards,

      Vishnu Sankar
