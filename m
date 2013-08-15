From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Wed, 14 Aug 2013 23:37:36 -0700
Message-ID: <20130815063736.GF25754@kroah.com>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com>
 <20130813184056.GH7740@kroah.com>
 <16FA42AC8F654C3B81924591E607B342@sqhead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59278 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760054Ab3HOGgD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Aug 2013 02:36:03 -0400
Content-Disposition: inline
In-Reply-To: <16FA42AC8F654C3B81924591E607B342@sqhead.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Andreas =?iso-8859-1?Q?Lilleb=F8?= Holm <andreas@sqhead.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Aug 14, 2013 at 03:38:04PM +0200, Andreas Lilleb=C3=B8 Holm wro=
te:
> Hi,
>=20
> On Tuesday, August 13, 2013 at 8:40 PM, Greg KH wrote:
> > > When communicating with AT90USB1287, at random intervals (1/25 bo=
ots)
> > > the linux hid_output_field Oopses and kills the communicating thr=
ead.
> > > The AT90USB1287 microcontroller uses LUFA library for usb/hid
> > > communication. It is trigged by a ioctl call from userspace and f=
ails
> > > in a kernel paging request. The system is after the oops in a sta=
te
> > > where no hid commands is sent anymore and only a boot can fix the
> > > system.
> > > =20
> > > Keywords: usbhid hid
> > > =20
> > > Kernel version: Linux version 3.8.13-03081301-generic (apw@gomeis=
a) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201305311535 SM=
P Fri May 31 19:44:30 UTC 2013
> > > =20
> > > Oopses:
> > > http://paste.debian.net/24305
> > > http://paste.debian.net/24306
> > > http://paste.debian.net/24307
> > > =20
> > > Code:
> > > The error is triggered by:
> > > ioctl(fd,HIDIOCSUSAGES, &ref_multi_u);
> > > ioctl(fd,HIDIOCSREPORT, &rep_info_u);
> > > =20
> > > Notes:
> > > It is very hard to reproduce so seems like race condition=E2=80=A6
> > > =20
> > > Any tips to resolve/workaround this issue is appreciated and plea=
se
> > > let me know if my information is incomplete (This is my first ker=
nel
> > > bug report)
> > =20
> > =20
> > =20
> > =20
> > Any chance you can try a supported kernel, like 3.10.6 or 3.11-rc5 =
to
> > see if that also causes problems? We can't do anything with
> > distro-specific kernel releases like your 3.8.13 release from Ubunt=
u,
> > sorry.
>=20
>=20
> I've now tried with kernel 3.10.6 (http://kernel.ubuntu.com/~kernel-p=
pa/mainline/v3.10.6-saucy/) and I can trigger the same issue on this ke=
rnel.
>=20
> Here is a paste from last Oops on this kernel:
> http://paste.debian.net/24993/ =20
>=20
> I am also using usbmon to monitor the usb bus traffic, but cannot see=
 anything that should cause the driver to Oops.
>=20
> Is there any way to find out what can trigger this issue?

Jiri should be the one to know this, Jiri, any ideas?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
