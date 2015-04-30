From: =?UTF-8?B?RGF2aWQgWmFmcmEgR8OzbWV6?= <dezeta@klo.es>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Thu, 30 Apr 2015 07:34:36 +0200
Message-ID: <5541BEEC.70905@klo.es>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es>	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>	<55320164.5010905@klo.es>	<553D5E91.2080704@klo.es> <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com> <553F2EF1.9000106@redhat.com> <553FFB10.6010005@klo.es> <554089DF.7040803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from llsa987-a03.servidoresdns.net ([82.223.190.28]:49378 "EHLO
	llsa987-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889AbbD3Fer (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Apr 2015 01:34:47 -0400
In-Reply-To: <554089DF.7040803@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>

Hi everyone

El 29/04/15 a las 09:35, Hans de Goede escribi=C3=B3:
> Hi,
>
> On 28-04-15 23:26, David Zafra G=C3=B3mez wrote:
>> [    0.257439] pnp 00:06: Plug and Play ACPI device, IDs ETD0108
>> SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
>
> Ok, so the "ETD0108" here means that you have an elantech ps/2 touchp=
ad.
Great! You got it.
>
> This also stands out in the log:
>
> > [    0.958323] i8042: [49] MUX error, status is 75, data is fe
>
> So the first thing to try is to boot with i8042.nomux=3D1 on the kern=
el
> commandline.
I have done it. The touchpad issue hasn't been solved. Do you want me t=
o=20
send dmesg output?

Cheers,

David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
