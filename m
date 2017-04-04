From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: [PATCH 1/2] Alps HID I2C T4 device support
Date: Mon, 03 Apr 2017 20:08:57 -0700
Message-ID: <87zifw7tti.fsf_-_@vostro.rath.org>
References: <20170403121559.1397-1-clabbe.montjoie@gmail.com>
        <20170403121559.1397-6-clabbe.montjoie@gmail.com>
        <64bd824c-2d09-3c8c-d35d-06d3808713b2@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32799 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751406AbdDDDI7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 3 Apr 2017 23:08:59 -0400
References: <20170330025317.4093-2-masaki.ota@jp.alps.com>
In-Reply-To: <64bd824c-2d09-3c8c-d35d-06d3808713b2@ladisch.de> (Clemens
        Ladisch's message of "Mon, 3 Apr 2017 14:55:14 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi Ota,

> -Support Alps HID I2C T4 Touchpad device.
> -Laptop names that use this Touchpad:HP Zbook Studio, Elitebook Folio G1,=
 Elitebook 1030 G1, Elitebook 1040 G3
>
> Signed-off-by: Masaki Ota <masaki.ota@xxxxxxxxxxx>
> ---
>  drivers/hid/hid-alps.c | 500 +++++++++++++++++++++++++++++++++++++++----=
------
>  drivers/hid/hid-core.c |   3 +-
>  drivers/hid/hid-ids.h  |   1 +
>  3 files changed, 403 insertions(+), 101 deletions(-)
=20
I tried your patch on an HP Elitebook, but with rather limited
success. Before, I was able to use the touchpad in limited fashion
(https://bugs.freedesktop.org/show_bug.cgi?id=3D100345). With your patch
(applied on top of 4.10), the touchpad no longer reacts at all.

That said, I didn't find a patch 2/2 anywhere.. is there something
missing?

Thanks,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
