From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] TWL6040: fix build error
Date: Fri, 11 May 2012 10:03:51 +0300
Message-ID: <4FACB9D7.5090100@ti.com>
References: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com> <CAP=VYLqwAO8x4aWw7_pH1LH_SPO9Td2ec9oOmKPL-_5LOEQw3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59517 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548Ab2EKHDz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 03:03:55 -0400
Received: by lbbgo11 with SMTP id go11so2477724lbb.17
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 00:03:52 -0700 (PDT)
In-Reply-To: <CAP=VYLqwAO8x4aWw7_pH1LH_SPO9Td2ec9oOmKPL-_5LOEQw3g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sasha Levin <levinsasha928@gmail.com>, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 05/11/2012 01:49 AM, Paul Gortmaker wrote:
> On Thu, May 10, 2012 at 2:44 PM, Sasha Levin <levinsasha928@gmail.com=
> wrote:
>> Fixes build error due to missing of_property_read_u32.
>=20
> Yes, I saw the same on x86-64 allyesconfig -- which means that in add=
ition to
> this missing header, it needs to have a Kconfig dependency that limit=
s
> it to just being enabled on the platforms where it physically is poss=
ible to
> have the hardware.  I'm guessing limiting to ARM would be a good star=
t?

Yes it is only usable on ARM, most specifically on OMAP4+ platforms.
If I make the twl6040 MFD core to depend on ARM (or even on OMAP) this
won't happen again.


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
