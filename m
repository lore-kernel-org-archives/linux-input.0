From: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Fri, 24 Aug 2012 16:42:20 +0200
Message-ID: <503792CC.6050209@laposte.net>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1368810.q4rGz16CTW@linux-lqwf.site> <50374B69.3040002@laposte.net> <1555763.Oi7gGGn7BU@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1555763.Oi7gGGn7BU-ugxBuEnWX9yG/4A2pS7c2Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

Le 24/08/2012 13:41, Oliver Neukum a =E9crit :
> On Friday 24 August 2012 11:37:45 Yann Cantin wrote:
>> Hi,
>>
>> Le 23/08/2012 09:23, Oliver Neukum a =E9crit :
>>> On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:
>=20
>>> These functions are identical. You should unify them.
>>
>> Removed reset_resume from the driver (optional, and not needed
>> for this hardware).
>=20
> Why did you do that? It is always better to have reset_resume().
> And you cannot tell whether it will be needed.

This function was used in usbtouchscreen (which this driver is based on=
)
for some hardware specific init after reset. eBeam devices doesn't need=
 that,
and i didn't mention the similarity of the 2 functions after stripping =
the code.

According to power-management.txt, reset_resume is optional, and lot of=
 input
driver lack it. Anyway, if you think it's worth the code, i'll re-add a=
=20
reset_resume function proxing resume like wacom_sys.c do.

--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
