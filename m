Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4017D6
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016905; cv=none; b=FIJKWeY+selV8xA4TsHnVfLSrOTCi7bm6TNDTPw34sJr1BWDfvrxQVqc5ufQW8yZ2jlmlAcKNN8lH00z65oJoLSyhFh23iR8Y9X0gEYXZyhG5JdiIQHm9h8o0WHJIudORVd3RZXs40evSTXRqFexnxen52X1C4kW/GUR4+WdUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016905; c=relaxed/simple;
	bh=feecK4MeBuj/VPyh/qYgnDaXVoeIaIRKFKR6chXYzQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUG2ihwkv+OOC3wNINMmQoqo56f3sU8tR5+YhMTj2BZw06psnRmEyIaraQzJBCLtGDL0aa5gFOAcfiYxOKVCFi02AoC89NKzef4p17xU0vwJo/utrKk6lrEaP0hV/vCZTHdNcHTYOf9nZdVKanTWcqBT9V4k+/bXhrVAFEg/YUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRKIckSO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRKIckSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E55DC2BCB6
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 07:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777016905;
	bh=feecK4MeBuj/VPyh/qYgnDaXVoeIaIRKFKR6chXYzQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iRKIckSOijMZisvasCxqfpngwj+h+OIOVBCIrBvqVdOx9uoOXCJVG2VcEd3Iz54OI
	 OwDUQT2XkF3gTu+99AhiATIhT1bZnz/FE7e38RmxjgN3ZcG7zhKDYGMt32U/MK7wsG
	 a1XZ/m+UOxKELs7MpzZkX69Z2d0WLDm20rWxe31KQef5dlPWnH4Vqo7JRgylfzpxZG
	 O6CbfwOMXymZJMsBp30ToRG2fiH9JtPoOjOP6wd2AMzhH+OSItAhEoT9cjUOi/TiW/
	 OIFuq+y/+HAVh4fQrQ8tgq5stf/HnmvayJBek2h9hqHByttv0kLzHXvHMq6HUtpFVz
	 EEkdN4gUKWZDg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so7641683e87.3
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 00:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++hSOiaQkolGFZKSVQWePXZZvgg4WbX7UTmLA48gIUDW2h93r28jkRG40UUuGpxy6ov05/i2500rLyow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPPS0V5FZ1y8z1OdUahUZotYrrpjTImc7XGnFHBFuN4n07yP7
	Df3BO9Qyp4QiDxzBgjLnI0PZeEZb2qL7ruOcLqfdbSBdd2IQHq0jUyX+TaeodFr80dG54OaFu2h
	bFVs8taqcC3s0nquKgDJXfoHsRooDIjM=
X-Received: by 2002:a05:6512:158c:b0:5a4:4ea:9982 with SMTP id
 2adb3069b0e04-5a4172bcc5cmr9318043e87.8.1777016904296; Fri, 24 Apr 2026
 00:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-2-clamor95@gmail.com>
In-Reply-To: <20260424071305.89503-2-clamor95@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 09:48:12 +0200
X-Gmail-Original-Message-ID: <CAD++jL=_oFXDSGxOziSB4JJsd0nJrxfN+xaJ031C-nq7=CaPOg@mail.gmail.com>
X-Gm-Features: AQROBzAeQLBiO2O8LJ_HmvCDG79a_y_CSWdVyN_SA_mC1wsB1hows8I5qh7lb78
Message-ID: <CAD++jL=_oFXDSGxOziSB4JJsd0nJrxfN+xaJ031C-nq7=CaPOg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 9:13=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:

> Document the Imagis ISA1200 haptic motor driver, used primarily in mobile
> handheld devices and capable of supporting up to two motors.
>
> The exact datasheet for the ISA1200 is not available; all data was modele=
d
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

DT binding maintainers: notice that this version is essentially a reply to
requested changes from Rob in 2022:
https://lore.kernel.org/linux-input/YjuaK09nOztYOmyn@robh.at.kernel.org/

I.e. moving from "all info derived from the compatible" to "use more
properties".

Yours,
Linus Walleij
