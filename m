Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BA3B71D4
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679180; cv=pass; b=JUfmKRFIa3rEG9Ao6edddUTL6Von1VaG6ibEiZPsIZThC0spOvJVEOHNLD2wosDVNTuRYq/7ihX1Xa01i8wrBAtCLtpxXo2ijyIqZ8NP26uH6TDpQlQU/cJgf8IyrVrCJtbl6oc5JC2K72dlRTPO0CmWneFjRO/R1NMxgAq+Hec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679180; c=relaxed/simple;
	bh=iSXxjbCL/hr1cvEgQ8IVLmSXjDTfgblayEtrSw9Vrz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRbuHq08wBXnLAHqYn9fqzzMlLhyroib8TjMfdxKlqS34j0v4rjlB8ABa2TKehmDO0M/UAwVhBUacr4vVy+U9n4QkJG+PKmTsfzkKKYbhfDsupGfvVDkMXq7AuIQO53uyckai+KMbWm7zBL9+LFUrnSPscGZYP46SCrNgqLWJd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1lsO8jX; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1lsO8jX"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1370417c01cso7038062c88.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 23:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781679177; cv=none;
        d=google.com; s=arc-20240605;
        b=eEdX/p1vYqp6QLcYXdA+5q7GN92upSqykDF0P+bK4ZUKMHMOoAGFJOTI3qMOBXp5wa
         XsI1IKs9Ek+fJKiAvkgTCkWUJDIh6R4IsgRMrqx3JAIDSfE4SYLGzTIF5ywfB6rnqGIq
         wnaMiH6vkOV343xjHtaa4c2hnFA0c9wXH+Y3RBJGp9v4+CeDZAzJStlG4f2DznUGDDnp
         ul1H4UczJprV1zI+ZxBenA0ASQmLTwaCHIDFr55l5RLYe45bnL6hdnpioIz/ncaAkPOp
         BEdAq1Vcp1nVP2ZITh/sQEFSqbvTfi0Mo3GRwM44AphrOvtcW6n1Is7u4RDFl2476CB5
         cHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iSXxjbCL/hr1cvEgQ8IVLmSXjDTfgblayEtrSw9Vrz8=;
        fh=RbOIwcPwMZiIWgZb4izUWrG842my8mUon8lZKI8uh38=;
        b=NiK1ujVOkqpuZujGdX1sGC1K76ZEEOc7avHouaabdlWSCD3IPXUXf1YmutU1Q+BeEa
         cAz/jA7m7azts8Z0akBqjAQdJbIENdtjmsKrt7IO+FkCMMERjtRx04w6vH7VNvhYuPvm
         EGdUZXlic1ZLuxgkL0mRAw66s0iU3/FAQ2BvtJvLlyoWV2QzDzIjYp8bp+ioJkXyw7F5
         4rABgVRwKvDIL8KilFHLQrsxSrwK7KwTRXZDRbu2OKa75CeUc12CZKNfSM1bn048ipjZ
         c6d7ku6Ln9ifsB+pfv0eCuCX58Xm8B3Cf6NyhaJk8U54/7H8X8nmW4LwANqcq50IY0mt
         1y6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679177; x=1782283977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSXxjbCL/hr1cvEgQ8IVLmSXjDTfgblayEtrSw9Vrz8=;
        b=q1lsO8jXaPPFDDe43JbTYqNEDtukcXajOd3h37VcpgWT9tFkw3Fm5k/PcvRBMe1mGI
         MxvgN6FYKuMCz91tznK5qOGW9nxe4/yunhvolIbAKLp3Rcr76iYK2ay1rw7+WMz4Ekyk
         eVHFo/c2quOp9qyzbfDTjj2zjlWQfBN3fhv4YLsgXbFssPoMjJekJUpMpXJTxcsSL8rS
         HVh4Xv1LriPJEXNhuVD9iTo1bcQJPsrHOOwMAEqlMFflPqzdu0EBNZNyvFMouwv6MCvA
         12204gEl4yYmz3uZN9vWD37diXkodxoGNKs/JlHIfEVMGYXMt6xR/ZqZPNREBq8YkBWG
         ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679177; x=1782283977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSXxjbCL/hr1cvEgQ8IVLmSXjDTfgblayEtrSw9Vrz8=;
        b=ATOkUaaB38/UBtQACI5H61zQO9tUk2FdEjfpHE1jrnKnVW1kUvMLFEr5ZjpWByKLkF
         6SJNhKKmApEQKpwQA2RBHPt5bCBjqatz+IFd9E/jgTp+0FyF1zjojqTM+mbxiz0y8cP7
         ONLPrLnUVNkUkOlCM9Z43HqNx0IYXeaF3oNVGJ4MqrkiCS+6D/RcNLkHEyrOoYmDfPiP
         FFg6M79swQtmma+UVVJMGcAQscwAU5iQTgWT65l8e9DboTlw5stFLOgif1QvIhcKxG+h
         /suzyFXcuIMrEcD1MPG0SdKzeSj8YzgwM1ir1awvqBFf1ZAd0BiEkFFiJf6GAh0iIfNo
         oipg==
X-Gm-Message-State: AOJu0YzcBN/FHnouYhUsdkD+N6CH+bdGzu/M84yzyi+JC/ph8GEDjoBk
	gbgr/LvhKg/PlEM4QH7+D3izcz92i8p6Rh3/QwdhOlWKu+kcgoqIL3npsNiWWDeJfcoWO/uE2J2
	+aWm8sO/OkR65UP2DzdWNEZTzA3W2mmAi7mM2
X-Gm-Gg: AfdE7cnO9R89YpACPkbXSjUwKwKe172+8ULbGWtI0Z40Xl7iEYWajSrettZbsLuGsdo
	CXafZnADD0+tyuBeL3ANI378kxraCCShnEpTAjsgZR/Uwsk1De6cGfRp8cqi6lbpbDcEvW8R+ST
	15JpeSKnLXnsyKpVdqbKxyh9z/9m8RZivyfRflo4mnafIJ7Nnct0afky/AnAH7nI72TAP/xR+BQ
	gKaBIgs2qnVk4RRRWAy4HM3r3OkLm8DZlG1e/k5oceObGtg9kfXOjUijkbcOqUpXbv2NMlxpg5h
	BmqVEKkO
X-Received: by 2002:a05:7300:6402:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30bca09f522mr1548857eec.23.1781679177199; Tue, 16 Jun 2026
 23:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512102445.55372-1-clamor95@gmail.com> <20260512102445.55372-3-clamor95@gmail.com>
 <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
 <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com>
 <ajDEsU8oZWT7KB9d@google.com> <CAPVz0n26H2t=pi_C+t8jP_cWXGSa5pk=1cpTZtkBh3=RQsUk2g@mail.gmail.com>
 <ajGk5YxRTFycFc1G@google.com>
In-Reply-To: <ajGk5YxRTFycFc1G@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 17 Jun 2026 09:52:45 +0300
X-Gm-Features: AVVi8CdAHA6KnMvlndzjVeY1RjOWdn3VkGJdH7TEmihVzr_x7xsKAS4t5iH-0hc
Message-ID: <CAPVz0n3RJF7j9hfqZe3Sd3NQXigizHgBxDrR6h8jcRK1R6RNAw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 23:3=
0 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Jun 16, 2026 at 09:45:25AM +0300, Svyatoslav Ryhel wrote:
> >
> > I have tested your code on my P895 and it works perfectly fine. Should
> > I resend with these changes or you can integrate them while picking
> > patchset?
>
> I think there was an update requested by Rob for the bindings?
>

Acknowledged, I will resend with both changes.

> >
> > Thank you for your suggestions and efforts!
>
> Thank you for your patience.
>
> --
> Dmitry
