From: Tero Saarni <tero.saarni@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add support for reporting x/y
	resolution
Date: Thu, 7 May 2009 21:59:36 +0300
Message-ID: <ad348feb0905071159i68138a6cyef0d98410fc752cb@mail.gmail.com>
References: <1241460369.29685.6.camel@hp> <1241461145.29685.13.camel@hp>
	<20090507164859.GB6450@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49005 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbZEGS75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 14:59:57 -0400
Received: by ewy24 with SMTP id 24so1334231ewy.37
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 11:59:56 -0700 (PDT)
In-Reply-To: <20090507164859.GB6450@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, May 7, 2009 at 19:49, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
>> +#define ABS_RESX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x26
>> +#define ABS_RESY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x27
>
> This data is not part of dynamic state of the device but rather
> describes it's physical characteristics and as such should not be
> transmitted as input events. We should consider extending input_absin=
fo
> and making this data available via EVIOCGABS ioctl but we need to be
> careful with keeping compatibility with existing clients.

Thanks for your reply!

What kind of extension do you mean?

Making it available via EVIOCGABS ioctl was my intention too but
extending by adding new ABS_nnn was the only obvious way I came up
with.  All the other similar uses of input_absinfo seem to describe
static limits of dynamic parameters (like max and min y coordinates)
so I agree that resolution is not a perfect fit into the group,  For
resolution I never need to call input_report_abs().

I'm very new to the area so please bear with me! :-)

--=20
Tero
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
