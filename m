From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Mouse and keyboard freeze on Ivy Bridge platform
Date: Thu, 4 Oct 2012 16:59:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210041654550.1441-100000@iolanthe.rowland.org>
References: <20121004194347.GB6927@dinot.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121004194347.GB6927-RqwYBe9jBbFeoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?S=C3=A9bastien?= Dinot <sebastien.dinot-GANU6spQydw@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 689368-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 4 Oct 2012, S=C3=A9bastien Dinot wrote:

> Hi,
>=20
> Alan Stern a =C3=A9crit :
> > Please build a kernel with CONFIG_USB_DEBUG enabled.
>=20
> Done (3.6.0+ kernel)
>=20
> > When a hang occurs, get a list of hang tasks (Alt-SysRq-w probably
> > won't work, but "echo w >/proc/sysrq-trigger" from a network login
> > should). Then send the dmesg output
>=20
> The mouse and the keyboard froze four times tonight in half an hour=C2=
=A0:
>=20
> - at 20:42:05
> - at 20:53:44
> - at 20:58:21
> - at 21:15:19
>=20
> But the SysRq command (executed through a remote SSH connection)
> displayed nothing. :(

No tasks were hung.  That's okay.

> In attachment, you will find the kern.log file.
=20
The log file shows lots and lots of low-level communication errors. =20
They could be caused by bad cabling or by bad USB hardware in your
computer.  It's unlikely that they were caused by the mouse or
keyboard, because the log shows errors for both of them starting at
exactly the same times.
=20
You could try getting a USB-2 hub and attaching your mouse and
keyboard through the hub.  That might help ... or it might not.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
