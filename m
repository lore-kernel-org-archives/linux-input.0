From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: synaptics - use firmware data for Cr-48
Date: Wed, 18 Jul 2012 23:42:09 -0700
Message-ID: <20120719064209.GB3300@core.coreip.homeip.net>
References: <1342606923-9997-1-git-send-email-cywang@chromium.org>
 <5006D86C.7030208@canonical.com>
 <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42356 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2GSGmP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 02:42:15 -0400
Content-Disposition: inline
In-Reply-To: <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chung-Yih Wang =?utf-8?B?KOeOi+W0h+aHvyk=?= <cywang@google.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Daniel Kurtz <djkurtz@chromium.org>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chung-Yih,

On Thu, Jul 19, 2012 at 11:02:23AM +0800, Chung-Yih Wang (=E7=8E=8B=E5=B4=
=87=E6=87=BF) wrote:
> Hi Chase,
>=20
>    Thanks for your great comments. You are right, it is impossible to=
 get
>  correct finger tracking if both fingers are moving. However, we thin=
k it
> still worth to have the firmware tracking of the fingers as they coul=
d
> perform well for most one-stationary-one-moving cases. This will be g=
ood
> enough for the one-stationary-one-moving gestures we want to provide =
on
> Cr-48. And that's why we want to make the patch specific to Cr-48.
>=20

=46irst of all if the patch makes sense for Cr-48 then other boxes usin=
g
the same touchpad with the same sensor would also benefit from it.
However it is still not clear to me what coordinates are being reported
by the device? You say that it always reports finger with smaller Y in
SGM packet, but what about X coordinate? Could it be that the most
benefit from your patch is because it reports proper slot from 2->1
finger transitions?

BTW, you seem to have butchered single-touch protocol reporting for you=
r
device.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
