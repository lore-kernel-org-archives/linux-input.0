From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] hid: add suspend/resume hooks for hid drivers
Date: Tue, 27 Apr 2010 15:25:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004271525090.9849@pobox.suse.cz>
References: <20100425214003.7e87c6a3@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100425214003.7e87c6a3-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, 25 Apr 2010, Bruno Pr=C3=A9mont wrote:

> Add suspend/resume hooks for HID drivers so these can do some
> additional state adjustment when device gets suspended/resumed.
>=20
> v3:
>   - Pass full message to hid driver's suspend hook
> v2:
>   - Adds auto_suspend parameter to suspend hook
>   - Only calls HID driver's resume hooks when previous code
>     did succeed
>=20

I have applied this to 'hid-suspend' branch of my tree for now. Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
