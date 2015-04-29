From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Wed, 29 Apr 2015 09:35:59 +0200
Message-ID: <554089DF.7040803@redhat.com>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es>	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>	<55320164.5010905@klo.es>	<553D5E91.2080704@klo.es> <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com> <553F2EF1.9000106@redhat.com> <553FFB10.6010005@klo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031308AbbD2HgO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 03:36:14 -0400
In-Reply-To: <553FFB10.6010005@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgWmFmcmEgR8OzbWV6?= <dezeta@klo.es>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>

Hi,

On 28-04-15 23:26, David Zafra G=C3=B3mez wrote:
> [    0.257439] pnp 00:06: Plug and Play ACPI device, IDs ETD0108 SYN0=
a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)

Ok, so the "ETD0108" here means that you have an elantech ps/2 touchpad=
=2E

This also stands out in the log:

 > [    0.958323] i8042: [49] MUX error, status is 75, data is fe

So the first thing to try is to boot with i8042.nomux=3D1 on the kernel=
 commandline.

Regards,

Hans

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
