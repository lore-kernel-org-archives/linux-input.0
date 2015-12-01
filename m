From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN
 devices
Date: Tue, 1 Dec 2015 23:09:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512012308160.32500@pobox.suse.cz>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com> <1448996208-19713-1-git-send-email-adrienverge@gmail.com> <1448996208-19713-3-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448996208-19713-3-git-send-email-adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Adrien_Verg=E9?= <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Macpaul Lin <macpaul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adel Gadllah <adel.gadllah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Dec 2015, Adrien Verg=C3=A9 wrote:

> All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's use
> this quirk for all devices from this vendor, rather than maintaining =
a
> list of all its known product IDs.
>=20
> Tested-by: Adrien Verg=C3=A9 <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Adrien Verg=C3=A9 <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Greg, I guess it makes sense to take both 1/2 and 2/2 together as a who=
le.=20
Would you mind adding the tags above and taking it through usb git tree=
?

Alternatively I can take it through my tree if you Ack the usb part.

Thanks,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
