From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] TWL6040: fix build error
Date: Fri, 11 May 2012 15:16:39 +0300
Message-ID: <4FAD0327.7040305@ti.com>
References: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com> <CAP=VYLqwAO8x4aWw7_pH1LH_SPO9Td2ec9oOmKPL-_5LOEQw3g@mail.gmail.com> <CACxGe6vbn7r10KT-q2GGtJatv12prE4ZFJxWsSzPEyLoCuH27A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:54974 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757656Ab2EKMQp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 08:16:45 -0400
Received: by lbbgj10 with SMTP id gj10so2270814lbb.23
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 05:16:42 -0700 (PDT)
In-Reply-To: <CACxGe6vbn7r10KT-q2GGtJatv12prE4ZFJxWsSzPEyLoCuH27A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sasha Levin <levinsasha928@gmail.com>, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/11/2012 07:27 AM, Grant Likely wrote:
> On Thu, May 10, 2012 at 4:49 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> On Thu, May 10, 2012 at 2:44 PM, Sasha Levin <levinsasha928@gmail.co=
m> wrote:
>>> Fixes build error due to missing of_property_read_u32.
>>
>> Yes, I saw the same on x86-64 allyesconfig -- which means that in ad=
dition to
>> this missing header, it needs to have a Kconfig dependency that limi=
ts
>> it to just being enabled on the platforms where it physically is pos=
sible to
>> have the hardware.  I'm guessing limiting to ARM would be a good sta=
rt?
>=20
> IIRC, this hardware is available on x86.  Also, if CONFIG_OF is not
> set, then the of_property_read_* functions compile out to do-nothing
> stubs.

I had only linux/of_device.h included which would include of.h only if
CONFIG_OF_DEVICE is set.
Since the i386 did not had OF_DEVICE the of.h was not included (by
of_device.h) thus caused a build breakage.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
