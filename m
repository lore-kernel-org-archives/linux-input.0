From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Thu, 14 Aug 2008 18:49:48 -0700
Message-ID: <20080814184948.093d2cad.rdunlap@xenotime.net>
References: <200808080702.24969.aivils@latnet.lv>
	<20080809104226.GF4546@implementation>
	<200808100408.37473.aivils@latnet.lv>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__14_Aug_2008_18_49_48_-0700_NLUsxwZgbXZeG6Wo"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200808100408.37473.aivils-zFrTw0b2IqLyG1zEObXtfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aivils Stoss <aivils-zFrTw0b2IqLyG1zEObXtfA@public.gmane.org>, lud <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxconsole-dev-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__14_Aug_2008_18_49_48_-0700_NLUsxwZgbXZeG6Wo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Aug 2008 04:08:37 +0100 Aivils Stoss wrote:

> On Saturday 09 August 2008 11:42:26 am Samuel Thibault wrote:
> > Aivils Stoss, le Fri 08 Aug 2008 07:02:24 +0100, a =E9crit :
> > > I suppose this is Linux kernel bug because i test keyboards under
> > > Windows, which support any schema of cascading of usb hubs.
> >
> > On the very same machine and hubs?
>=20
> Yes, on same machine. Under Windows i don't have evdev interface,
> checked only how keypress go to console.
> Of course to repeat a try You must have at least 5 keyboards and
> 1 7-port or 2 4-port hubs and kernel 2.6.22 and above. I allways
> got result - 5th, 6th, 7th keyboard does not send events to console
> or evdev.


[adding linux-usb mailing list]

Hi,

I finally got 5 USB keyboards together along with 2 hubs.
I daisy-chained the hubs and connected 1 keyboard to the hub that is
on the notebook computer USB port, then I connected 4 keyboards to the
second hub.  They all worked for me, meaning that I can type on all of
them and have their characters show up on my console.

I'm testing with 2.6.7-rc2.
'usbtree' output of the USB subsystem is attached.


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/

--Multipart=_Thu__14_Aug_2008_18_49_48_-0700_NLUsxwZgbXZeG6Wo
Content-Type: text/plain;
 name="usb-kbds.txt"
Content-Disposition: attachment;
 filename="usb-kbds.txt"
Content-Transfer-Encoding: quoted-printable

/: Bus 05.Port 1: Dev 1, Class=3Droot_hub, Drv=3Duhci_hcd/2p, 12M
/: Bus 04.Port 1: Dev 1, Class=3Droot_hub, Drv=3Duhci_hcd/2p, 12M
    |_ Port 1: Dev 2, If 0, Prod=3DMicrosoft IntelliMouse=AE Explorer, Clas=
s=3DHID, Drv=3Dusbhid, 1.5M
    |_ Port 2: Dev 3, If 0, Prod=3DGeneric USB Hub, Class=3Dhub, Drv=3Dhub/=
4p, 12M
        |_ Port 1: Dev 8, If 0, Prod=3DMobility USB EasiDock 200, Class=3Dh=
ub, Drv=3Dhub/9p, 12M
            |_ Port 1: Dev 17, If 0, Prod=3DAPI USB KB HUB, Class=3Dhub, Dr=
v=3Dhub/3p, 12M
                |_ Port 1: Dev 18, If 0, Prod=3DAPI USB KB HUB, Class=3DHID=
, Drv=3Dusbhid, 12M
                |_ Port 2: Dev 19, If 0, Prod=3D, Class=3DHID, Drv=3Dusbhid=
, 1.5M
            |_ Port 2: Dev 14, If 0, Prod=3DUSB Keyboard, Class=3DHID, Drv=
=3Dusbhid, 1.5M
            |_ Port 2: Dev 14, If 1, Prod=3D, Class=3DHID, Drv=3Dusbhid, 1.=
5M
            |_ Port 3: Dev 13, If 0, Prod=3DUSB Multimedia Keyboard, Class=
=3DHID, Drv=3Dusbhid, 1.5M
            |_ Port 3: Dev 13, If 1, Prod=3D, Class=3DHID, Drv=3Dusbhid, 1.=
5M
            |_ Port 4: Dev 11, If 0, Prod=3DDell USB Keyboard Hub, Class=3D=
hub, Drv=3Dhub/3p, 12M
                |_ Port 1: Dev 12, If 0, Prod=3DDell USB Keyboard, Class=3D=
HID, Drv=3Dusbhid, 12M
                |_ Port 1: Dev 12, If 1, Prod=3D, Class=3DHID, Drv=3Dusbhid=
, 12M
            |_ Port 8: Dev 9, If 0, Prod=3DMobility PS/2 Keyboard And Mouse=
 I/F, Class=3DHID, Drv=3Dusbhid, 12M
            |_ Port 9: Dev 10, If 0, Prod=3DMobility USB Serial Converter, =
Class=3Dvend., Drv=3Dnone, 12M
        |_ Port 2: Dev 15, If 0, Prod=3DMultimedia Keyboard Hub, Class=3Dhu=
b, Drv=3Dhub/3p, 12M
            |_ Port 1: Dev 16, If 0, Prod=3DMultimedia Keyboard Hub, Class=
=3DHID, Drv=3Dusbhid, 12M
            |_ Port 1: Dev 16, If 1, Prod=3D, Class=3DHID, Drv=3Dusbhid, 12M
/: Bus 03.Port 1: Dev 1, Class=3Droot_hub, Drv=3Duhci_hcd/2p, 12M
/: Bus 02.Port 1: Dev 1, Class=3Droot_hub, Drv=3Duhci_hcd/2p, 12M
/: Bus 01.Port 1: Dev 1, Class=3Droot_hub, Drv=3Dehci_hcd/8p, 480M

--Multipart=_Thu__14_Aug_2008_18_49_48_-0700_NLUsxwZgbXZeG6Wo--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
