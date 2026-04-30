Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8B3FFAD2
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542779; cv=pass; b=GwFVQBi2ndl9kWEi5asKJNUVy85/g1fpzSDStarzt3vtnX3aQrFJ2GP9Z9/w6kixmHIt4k2NB3iRGeo2dBVxDWf7NSaHwhGKCapK1UsY+AbURbvzXzQZCf/nc5W1LdwNHGn/PKtwUOSI0RxUi5TCZdE8EaAFyfVjhrG2Ax6mNs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542779; c=relaxed/simple;
	bh=L5+adarktYuRtDfgEfgFMAOiTqqk/oh/KE7e/yvrlcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXhShUpQz7+5SyadDOuyYBf8Z7bSB7alvhd0WBCXFJi8kDD45Vc/KwNvkuA9BcjDre9pVkbH46cRteXk4CmwO/6dTeNEoM8Sk2uLNY2odXu8kLeojNMS/t6Dxrt/1/fpee5sX/Z3XKlYGYVxBhSkV9pSnYHkItt3L73/KPfjioE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7/TVStF; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7/TVStF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so6852715e9.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 02:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777542775; cv=none;
        d=google.com; s=arc-20240605;
        b=jDonkvd4+Nj1eGQLxPd0PqukHrMSQdYCKf6kLUhxC1z7DA6x7c84H0QJ9UAibFnvEW
         MkMm6hnxx0yqDHYTi4/i0vytV5i/cVmzjY0n81K/sakXDNNEO84ngIV/Oo2UG+afAMxZ
         UaLI9/IW3v4Os9PvRS4W+Z62DKMZYr9+GgDK+tC/iWvcZK2rAFnyqZzBb3zg+ZGw2tmg
         raqSXS64qMV9cj5RXkM6EOp0qtU+D5/1XNC3nC9n/LYZ/Smiaw+HgTchhBlWLvMHtX19
         UHV38twgfLqfijrnP8m3j7AZVCRjP7GTJw4rHVqWzU8fFUPxKeWD+MFthJXD8jojVG47
         DXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80nYfLrL1k2QOZW/UyIa+gL4sme0jkc9ZbDotf2ijH8=;
        fh=aCj4S4rvH3ttpjEb6aRRR7op48IyhzeTuxH9jaky97U=;
        b=EpEyExy2zrx3sP+dE9uyz8mQ6kCUbvCLuDzvy19/VbSn7m00hhWtjdgugbdpIe2s7V
         4paag/7495oxTeJkM71XRBwk3J1Lv+117wbf3JUsv25+uHEST8v2/EFnZmDd0a5GFV22
         Vcwom9LvgSXyivFDNZbwfmfhfTUYtySNbAFfvXZrQcxTetuvb13PiFnN7DorE8u1wWNY
         Sq/Wedb++ESGe4W2oRy9SeLdZNnjUElSZxdMnu+RbiIlzvBhGVCz9PsP96X2IQDhkq6g
         3fJ5qWJXaQTQVbuc4zSgGmzItWtFnumnel9wwNMX7qQQkNqmaFu51pSlPLmVoPBYnbxE
         ujSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777542775; x=1778147575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80nYfLrL1k2QOZW/UyIa+gL4sme0jkc9ZbDotf2ijH8=;
        b=D7/TVStFH101vuh3fk2xevKpUYH+u/BmJVj6m8KH7WnewRGkSPaWexaOoSSn+CgvgU
         HBDZk0SlGxM+6dxoi9acT2qy52Wl0KGxQyh51AAf75OJuguu7Vs0gfHcyOONAlz9T+Th
         qWv8IawLRQt/N4iAdAUJhGk7CcddlT5w4I+O53jSITQZKZXNcJ1gYBEL5gGewTA2sfqQ
         VTF1EMXd0ofmoTO6SaqrbE7RDI/bCo6H1MR1Zd+g3unwpxIQ/+cPhBfbO6bKyI8uOkE+
         xdgk4YifkIYd3tScI3qXrBPNd+nsGDvAqDrfol68E76RiqF2nQUjPjHC28ZQdfd0lTnW
         L0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542775; x=1778147575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80nYfLrL1k2QOZW/UyIa+gL4sme0jkc9ZbDotf2ijH8=;
        b=qk7/7mJ1iGdCRVfCUHvMCHTUVhdyn2aSjjq/1B78lzrC7DMUhaMTbhWuzxj5gC3N9n
         bGnP2MGVfMsh2TZTZNMaiWnyprinWe4p/Q9OGeuds44qLT3DGk3sgmMgoyJSo714Mf41
         xNq1eLCGf+iEM1wiLaH3BqjLclf2TSWhWTrzTC7lishUIfU6HYdCkV1nmJnUTIczQoCP
         7C6Ohl05tT94CmixdboyKvd3jLPmjoVpMM3RBy3yVK7A1JTJZ9tRjN6N2HJEcmkpNENg
         bl+vjZdOf47cJM/TnjSyCIuxABhkxzg+9jGnnpAnGO1WZjFM6tkNhaK7Vg9y2AjnT/V5
         mGBw==
X-Forwarded-Encrypted: i=1; AFNElJ/TuH4Mul1yod6Weh+q5+F0nqmOfT2qQ8CKFxw/XDve21UImptBNKefLrDNkiPlThLZYwTdNGsdtZv+Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9n2tlmtW2x7hHBb3NXSLWM1WrXEM3XNll/TYqOkE/3NWhpDrP
	40O9/YeQuaugGF9nbtzUZoas+R2Bu9YpZw0dj5ViuTDtbCYetAsezXp/XUudQwj/FLhkW/OqlU1
	S9PKmAOZueFrUW5ndCl8aMr8D//lrgUQ=
X-Gm-Gg: AeBDiesnJsfUd6m5nGOa8KClOnOJYf8jNOr2UVQa15jaFAqa8opfSBtTeQamJlGVh2T
	rQBh8q6qsQm15NK6MSUUvKng2N9oc7CmRtu/x0vaKXTUVTBjZS9PRda1NfP5XQO5wTrSpEBipIF
	6rCV8odSO5tacXXKDEtcCL+sEHCFGDUWHM8MHjnj9swJmdFt/7zFmNaSToiU7TifFKrQGz4P0Kj
	p5nbnwhN2yEDQIaavSnoWzQ3rVlpmlnoyTZ+YYDvmiXPQtdKiGlVBF4DKs6BGrSHGgs9x1VIVpY
	rbPna9WJHO7XYoq4u2k=
X-Received: by 2002:a05:600c:a119:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48a84252bd3mr28233095e9.7.1777542775251; Thu, 30 Apr 2026
 02:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com> <CAD++jLmNKWwHAxV8OLK5wupwj4dT1TWEn2Dmd6gP-Ez9Pgk0tw@mail.gmail.com>
In-Reply-To: <CAD++jLmNKWwHAxV8OLK5wupwj4dT1TWEn2Dmd6gP-Ez9Pgk0tw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 30 Apr 2026 12:52:43 +0300
X-Gm-Features: AVHnY4InMnq5sIIvHuLuG3dBtCw9MXJXgSokBfxK9mzHcR7haNN_KHz91b9oE0w
Message-ID: <CAPVz0n119=Ec7qT4gXrqQGzm30X7oeD4DwKWEoFgaM6B=YwdNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] input: misc: add support for Imagis ISA1200 haptic
 motor driver
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:1=
6 Linus Walleij <linusw@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Apr 28, 2026 at 1:43=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
>
> > The ISA1200 is a haptic feedback unit from Imagis Technology using two
> > motors for haptic feedback in mobile phones. Used in many mobile device=
s
> > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Be=
am
> > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
>
> I applied a patch to the Janice devicetree like this:
>
> +               /* Haptic feedback unit Immersion ISA1200 */
> +               haptic-engine@49 {
> +                       compatible =3D "immersion,isa1200";
> +                       reg =3D <0x49>;
> +
> +                       /* clkout1 from ACLK divided by 8 */
> +                       clocks =3D <&clkout_clk DB8500_CLKOUT_1
> DB8500_CLKOUT_SRC_ACLK 8>;
> +
> +                       /*
> +                        * GPIO194 pin HEN (motor hardware enable)
> +                        * GPIO195 pin LEN (motor LDO enable)
> +                        */
> +                       control-gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>,
> <&gpio6 3 GPIO_ACTIVE_HIGH>;
> +
> +                       imagis,clk-div =3D <256>;
> +                       imagis,pll-div =3D <2>;
> +
> +                       imagis,mode =3D <0>; /* LRA_MODE */
> +
> +                       imagis,period-ns =3D <1340000>;

Hello Linus!

May you please try with imagis,period-ns =3D <12900>; and <11900> which
one will fit better.

> +                       imagis,duty-cycle-ns =3D <100>;
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&isa1200_janice_default>;
> +
> +                       ldo {
> +                               regulator-name =3D "vdd_vib";
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3000000>;
> +                       };
> +               };
>
> It works, I get rumble on the keys.
>
> Tested-by: Linus Walleij <linusw@kernel.org>
>

Very nice! Thank you for testing!

> Yours,
> Linus Walleij
