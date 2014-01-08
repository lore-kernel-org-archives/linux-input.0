From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Re: Information about Atmel MXT224
Date: Wed, 08 Jan 2014 13:24:22 +0100
Message-ID: <52CD4376.50305@gmail.com>
References: <52CD04F1.8090100@gmail.com> <alpine.DEB.2.01.1401081228580.1454@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:45879 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbaAHMYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 07:24:38 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so779832eak.16
        for <linux-input@vger.kernel.org>; Wed, 08 Jan 2014 04:24:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.01.1401081228580.1454@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>

On 01/08/2014 12:42 PM, Peter Meerwald wrote:

> you need to request them from the distributor I guess, they docs are
> pretty good

I am in Belgium and we deal with Gleichmann & Co. Electronics in German=
y=20
to have their devkit (SMT-C-T10). I have signed a NDA with them to have=
=20
MXT224 protocol guide but they never send me Protocol Guide.
I will try another distributor.

> shouldn't this be 16/14?
You are right, I already try this and test it again but this does not=20
change anything.

> something goes wrong in the initialization; the object table of the
> chip doesn't match the register data fed in -- the mxt224 can be a bi=
tch
> and play dead

So what can I do ? Maybe a problem with the embedded firmware that need=
=20
an update (atmel_mxt_ts 0-004b: Family ID: 129 Variant ID: 1=20
Major.Minor.Build: 2.0.AB)

When I do cat /proc/interrupts and I short-circuit /CHG to ground,=20
number increases so low-level handling of interrupt is working.

Thanks,
Ga=C3=ABtan Carlier.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
