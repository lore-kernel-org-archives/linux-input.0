From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Sat, 7 Jan 2012 17:05:31 -0800
Message-ID: <CAPnjgZ3G7yFOrngJP=KtJNcgAWtZg3xn22tRMMi+pUnZ2rJpBQ@mail.gmail.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
	<1325626648-9425-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:33005 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752508Ab2AHBFc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Jan 2012 20:05:32 -0500
Received: by obcwo16 with SMTP id wo16so3047931obc.19
        for <linux-input@vger.kernel.org>; Sat, 07 Jan 2012 17:05:31 -0800 (PST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Hi Olof,

On Tue, Jan 3, 2012 at 2:37 PM, Stephen Warren <swarren@nvidia.com> wro=
te:
> Olof Johansson wrote at Tuesday, January 03, 2012 2:37 PM:
>> This adds a simple device tree binding for simple key matrix data an=
d
>> a helper to fill in the platform data.
>>
>> The implementation is in a shared file outside if drivers/input/keyb=
oard
>> since some drivers in drivers/input/misc might be making use of it
>> as well.
>>
>> Changes since v3:
>> =A0* Dropped compatible field in matrix-keymap.txt
>> =A0* Dropped linux,fn-key
>> =A0* Dropped linux,fn-keymap optional property but included guidelin=
e on
>> =A0 =A0naming convention
>> =A0* Now passing property name in to the helper function (or will as=
sume
>> =A0 =A0"linux,keymap" if passed NULL)
>
>> diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
>
>> +struct matrix_keymap_data *
>> +matrix_keyboard_of_fill_keymap(struct device_node *np, char *propna=
me)
>> +{
> ...
>> + =A0 =A0 kd =3D kmalloc(sizeof(*kd), GFP_KERNEL);
>> + =A0 =A0 if (!kd)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>
> Should that use kzalloc in case struct matrix_keymap_data grows some
> new fields that people will assume are set to zero since the struct
> would usually be in .data? Still, people should probably grep the cod=
e
> when making such changes...
>
> Otherwise,
>
> Acked-by: Stephen Warren <swarren@nvidia.com>

Do you have a Tegra .dts binding for the Seaboard keyboard that I can
test with please?

Regards,
Simon

>
> --
> nvpublic
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
