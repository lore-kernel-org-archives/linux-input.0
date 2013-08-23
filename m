From: =?utf-8?Q?Andreas_Lilleb=C3=B8_Holm?= <andreas-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Fri, 23 Aug 2013 12:52:45 +0200
Message-ID: <26E21BF00B944AB6B8F48B5E59B0442D@sqhead.com>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com>
 <20130813184056.GH7740@kroah.com>
 <16FA42AC8F654C3B81924591E607B342@sqhead.com>
 <20130815063736.GF25754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130815063736.GF25754-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

I just wanna followup this issue a bit more.

We have now tested on several hardware platform, and it is only on one =
platform it fails. The platform it fails on is Atom Intel e6xx CPU with=
 EG20T PCH platform controller. We do not observe it on the Intel i7 35=
17UE CPU with Intel 6/7 series system controller.

We see this error around 4 times over 100 boots / 2 hours runtime.

After the Oops our process is in uninterruptable sleep state (D state).=
 The process is not killable  when in this state. The process also uses=
 around 70% CPU, maybe because it is waiting for the ioctl system call =
to return?

We haven't found another way to recover from besides rebooting the syst=
em.

How can we proceed to fix this issue?

Andreas


On Thursday, August 15, 2013 at 8:37 AM, Greg KH wrote:

> > > > When communicating with AT90USB1287, at random intervals (1/25 =
boots)
> > > > the linux hid_output_field Oopses and kills the communicating t=
hread.
> > > > The AT90USB1287 microcontroller uses LUFA library for usb/hid
> > > > communication. It is trigged by a ioctl call from userspace and=
 fails
> > > > in a kernel paging request. The system is after the oops in a s=
tate
> > > > where no hid commands is sent anymore and only a boot can fix t=
he
> > > > system.
> > > > =20
> > > > Keywords: usbhid hid
> > > > =20
> > > > Kernel version: Linux version 3.8.13-03081301-generic (apw@gome=
isa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201305311535 =
SMP Fri May 31 19:44:30 UTC 2013
> > > > =20
> > > > Oopses:
> > > > http://paste.debian.net/24305
> > > > http://paste.debian.net/24306
> > > > http://paste.debian.net/24307
> > > > =20
> > > > Code:
> > > > The error is triggered by:
> > > > ioctl(fd,HIDIOCSUSAGES, &ref_multi_u);
> > > > ioctl(fd,HIDIOCSREPORT, &rep_info_u);
> > > > =20
> > > > Notes:
> > > > It is very hard to reproduce so seems like race condition=E2=80=
=A6
> > > > =20
> > > > Any tips to resolve/workaround this issue is appreciated and pl=
ease
> > > > let me know if my information is incomplete (This is my first k=
ernel
> > > > bug report)
> > > =20
> > > =20
> > > Any chance you can try a supported kernel, like 3.10.6 or 3.11-rc=
5 to
> > > see if that also causes problems? We can't do anything with
> > > distro-specific kernel releases like your 3.8.13 release from Ubu=
ntu,
> > > sorry.
> > =20
> > =20
> > I've now tried with kernel 3.10.6 (http://kernel.ubuntu.com/~kernel=
-ppa/mainline/v3.10.6-saucy/) and I can trigger the same issue on this =
kernel.
> > =20
> > Here is a paste from last Oops on this kernel:
> > http://paste.debian.net/24993/ =20
> > =20
> > I am also using usbmon to monitor the usb bus traffic, but cannot s=
ee anything that should cause the driver to Oops.
> > =20
> > Is there any way to find out what can trigger this issue?

 =20


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
