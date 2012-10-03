From: sebastien.dinot-GANU6spQydw@public.gmane.org
Subject: Mouse and keyboard freeze on Ivy Bridge platform
Date: Wed, 3 Oct 2012 09:40:48 +0200 (CEST)
Message-ID: <181608016.271891744.1349250048886.JavaMail.root@zimbra59-e10.priv.proxad.net>
References: <551981935.271757401.1349247690620.JavaMail.root@zimbra59-e10.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551981935.271757401.1349247690620.JavaMail.root-J/s0bdte1BApj9y2c1zofRh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 689368-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

I am encountering random keyboard and mouse freezes which can only be r=
esolved by a hard reset (by pushing the power switch of the computer ca=
se).

I have this frequent and irritating issue with two differents Ivy Bridg=
e platforms:=20

1. Processor:   Intel Core i5 3450 (IGP HD 2500)
   Motherboard: MSI Z77A-G43 (with uptodate BIOS)
  =20
2. Processor:   Intel Core i5 3570K (IGP HD 4000)
   Motherboard: ASUS P8Z77-V LX (with uptodate BIOS)

I use Debian on these platforms and I tried several Linux kernels:
 =20
  * linux-image-3.2.0-3-amd64   (package from Debian testing)
  * linux-image-3.4-trunk-amd64 (package from Debian experimental)
  * linux-image-3.5-trunk-amd64 (package from Debian experimental)

I pointed out this bug to the Debian kernel team:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D689368

The mouse and keyboard are both USB devices and it seems that the bug i=
s coming from the echci-hcd module:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D689368#24

I attached the dmesg output and the kern.log file to my first message t=
o Debian:

* http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D35;filename=3Ddmes=
g.20121001-231244;att=3D1;bug=3D689268
* http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D35;filename=3Dkern=
=2Elog.20121001-232320.gz;att=3D2;bug=3D689268

As mentioned to the Debian maintainers, this bug is very frequent (I ha=
d up to four freezes in an hour) and my PC are really unusable!

Can I run additional tests or give you additional informations to help =
you resolve this painful bug?

Sebastien

--=20
S=C3=A9bastien Dinot, sebastien.dinot-GANU6spQydw@public.gmane.org
http://sebastien.dinot.free.fr/
Ne go=C3=BBtez pas au logiciel libre, vous ne pourriez plus vous en pas=
ser !

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
