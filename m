From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
Date: Mon, 7 Mar 2016 20:25:31 +0100
Message-ID: <56DDD5AB.1090707@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Julien Chauveau <chauveau.julien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

Am 07.03.2016 um 19:34 schrieb Javier Martinez Canillas:
> On Mon, Mar 7, 2016 at 3:24 PM, Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org=
> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices=
=2E
>>
>> Reported-by: Julien Chauveau <chauveau.julien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org>
>=20
> Looks good to me.
>=20
> Reviewed-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

Thanks. Quick summary for non-Rockchip reviewers:

This is a resend of: https://patchwork.kernel.org/patch/8513851/

To avoid future resends: https://patchwork.kernel.org/patch/8521501/

Rockchip arm64 cleanup: https://patchwork.kernel.org/patch/8513951/
Patch prompting all this: https://patchwork.kernel.org/patch/8513921/

Cheers,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton; HRB 21284 (AG=
 N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
