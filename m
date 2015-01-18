From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 1/3] input: goodix: Add device tree support
Date: Sun, 18 Jan 2015 15:22:47 +0100
Message-ID: <20150118152247.34aa149f16c60bf30cebbb42@ao2.it>
References: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
	<1421505361-8871-1-git-send-email-mamlinav@gmail.com>
	<1421527085.2075.12.camel@hadess.net>
	<CAF==cZWVN=NNaayVxtXNBe2hw7vxr9nryOyKknwY3vceKnNygw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:1977 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbbAROWv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 09:22:51 -0500
In-Reply-To: <CAF==cZWVN=NNaayVxtXNBe2hw7vxr9nryOyKknwY3vceKnNygw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0JzQsNC80LvQuNC9?= <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Sun, 18 Jan 2015 16:25:35 +0400
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=9C=D0=B0=D0=BC=D0=BB=D0=B8=
=D0=BD <mamlinav@gmail.com> wrote:

> Look at include/linux/of.h
>=20
> #ifdef CONFIG_OF
>  ...
> #define of_match_ptr(_ptr)	(_ptr)
>  ...
> #else /* CONFIG_OF */
>  ...
> #define of_match_ptr(_ptr)	NULL
>  ...
> #endif /* CONFIG_OF */
>=20
> So it would be compiled. Similarly in other touchscreen drivers.
> But Kconfig should be fixed to enable CONFIG_OF. Will be fixed in v2.
>=20

I was thinking, instead of depending on (ACPI || OF), can we make ACPI
optional as well and remove the dependency on it?
Does it make sense to allow selecting a driver even with no
enabled mechanism to pass platform data to it?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
