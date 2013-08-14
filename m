From: =?utf-8?Q?Andreas_Lilleb=C3=B8_Holm?= <andreas@sqhead.com>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Wed, 14 Aug 2013 15:38:04 +0200
Message-ID: <16FA42AC8F654C3B81924591E607B342@sqhead.com>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com>
 <20130813184056.GH7740@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:37426 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098Ab3HNNiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 09:38:11 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so6894252lbi.0
        for <linux-input@vger.kernel.org>; Wed, 14 Aug 2013 06:38:09 -0700 (PDT)
In-Reply-To: <20130813184056.GH7740@kroah.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Tuesday, August 13, 2013 at 8:40 PM, Greg KH wrote:
> > When communicating with AT90USB1287, at random intervals (1/25 boot=
s)
> > the linux hid_output_field Oopses and kills the communicating threa=
d.
> > The AT90USB1287 microcontroller uses LUFA library for usb/hid
> > communication. It is trigged by a ioctl call from userspace and fai=
ls
> > in a kernel paging request. The system is after the oops in a state
> > where no hid commands is sent anymore and only a boot can fix the
> > system.
> > =20
> > Keywords: usbhid hid
> > =20
> > Kernel version: Linux version 3.8.13-03081301-generic (apw@gomeisa)=
 (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201305311535 SMP =
=46ri May 31 19:44:30 UTC 2013
> > =20
> > Oopses:
> > http://paste.debian.net/24305
> > http://paste.debian.net/24306
> > http://paste.debian.net/24307
> > =20
> > Code:
> > The error is triggered by:
> > ioctl(fd,HIDIOCSUSAGES, &ref_multi_u);
> > ioctl(fd,HIDIOCSREPORT, &rep_info_u);
> > =20
> > Notes:
> > It is very hard to reproduce so seems like race condition=E2=80=A6
> > =20
> > Any tips to resolve/workaround this issue is appreciated and please
> > let me know if my information is incomplete (This is my first kerne=
l
> > bug report)
> =20
> =20
> =20
> =20
> Any chance you can try a supported kernel, like 3.10.6 or 3.11-rc5 to
> see if that also causes problems? We can't do anything with
> distro-specific kernel releases like your 3.8.13 release from Ubuntu,
> sorry.


I've now tried with kernel 3.10.6 (http://kernel.ubuntu.com/~kernel-ppa=
/mainline/v3.10.6-saucy/) and I can trigger the same issue on this kern=
el.

Here is a paste from last Oops on this kernel:
http://paste.debian.net/24993/ =20

I am also using usbmon to monitor the usb bus traffic, but cannot see a=
nything that should cause the driver to Oops.

Is there any way to find out what can trigger this issue?

Thanks
Andreas L. Holm


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
