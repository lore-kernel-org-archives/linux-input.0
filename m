From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: Re: [PATCH 1/3] input: goodix: Add device tree support
Date: Sun, 18 Jan 2015 19:12:43 +0400
Message-ID: <CAF==cZWvqCdgVTJ76d4NoWhc09EnU=kxArgMQtz8=x5TesGpVQ@mail.gmail.com>
References: <1421505253-7474-1-git-send-email-mamlinav@gmail.com>
	<1421505361-8871-1-git-send-email-mamlinav@gmail.com>
	<1421527085.2075.12.camel@hadess.net>
	<CAF==cZWVN=NNaayVxtXNBe2hw7vxr9nryOyKknwY3vceKnNygw@mail.gmail.com>
	<20150118152247.34aa149f16c60bf30cebbb42@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:62970 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbARPMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 10:12:44 -0500
In-Reply-To: <20150118152247.34aa149f16c60bf30cebbb42@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org

Do you mean that I should use #ifdef CONFIG_ACPI and ACPI_PTR?

#ifdef CONFIG_ACPI
static const struct acpi_device_id goodix_acpi_match[] =3D {
	{ "GDIX1001", 0 },
	{ }
};
MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
#endif

#ifdef CONFIG_OF
static struct of_device_id goodix_of_match[] =3D {
	{ .compatible =3D "goodix,gt9xx" },
	{ }
};
MODULE_DEVICE_TABLE(of, goodix_of_match);
#endif

static struct i2c_driver goodix_ts_driver =3D {
	...
		.acpi_match_table =3D ACPI_PTR(goodix_acpi_match),
		.of_match_table =3D of_match_ptr(goodix_of_match),
}

2015-01-18 17:22 GMT+03:00, Antonio Ospite <ao2@ao2.it>:
> On Sun, 18 Jan 2015 16:25:35 +0400
> =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=9C=D0=B0=D0=BC=D0=BB=D0=
=B8=D0=BD <mamlinav@gmail.com> wrote:
>
>> Look at include/linux/of.h
>>
>> #ifdef CONFIG_OF
>>  ...
>> #define of_match_ptr(_ptr)	(_ptr)
>>  ...
>> #else /* CONFIG_OF */
>>  ...
>> #define of_match_ptr(_ptr)	NULL
>>  ...
>> #endif /* CONFIG_OF */
>>
>> So it would be compiled. Similarly in other touchscreen drivers.
>> But Kconfig should be fixed to enable CONFIG_OF. Will be fixed in v2=
=2E
>>
>
> I was thinking, instead of depending on (ACPI || OF), can we make ACP=
I
> optional as well and remove the dependency on it?
> Does it make sense to allow selecting a driver even with no
> enabled mechanism to pass platform data to it?
>
> Thanks,
>    Antonio
>
> --
> Antonio Ospite
> http://ao2.it
>
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
>


--=20
Thanks and regards,
Aleksei Mamlin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
