From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 14:42:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009201440140.26813@pobox.suse.cz>
References: <4C96B9DB.8030403@turmel.org> <AANLkTi=1zh4hD-1uzpgjAsnKZBE=qi_ZAX-ug=2XMkW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42242 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab0ITMm2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 08:42:28 -0400
In-Reply-To: <AANLkTi=1zh4hD-1uzpgjAsnKZBE=qi_ZAX-ug=2XMkW0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guillaume Chazarain <guichaz@gmail.com>
Cc: Phil Turmel <philip@turmel.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Mat <jackdachef@gmail.com>, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>Phil Turmel <philip@turmel.org>

On Mon, 20 Sep 2010, Guillaume Chazarain wrote:

> > The USB mouse I use with my laptop is causing a BUG when inserted. =
=C2=A0It works at that
> > point, but if removed and re-inserted, it is ignored. =C2=A0Also, a=
fter the 2nd insert,
> > other USB devices (like my thumb drive) are also ignored.
> >
> > [ =C2=A0 37.450777] BUG: unable to handle kernel NULL pointer deref=
erence at (null)
> > [ =C2=A0 37.451148] IP: [<ffffffff817d0991>] hiddev_open+0xc1/0x220
> > [ =C2=A0 37.452036] PGD 1131a0067 PUD 113036067 PMD 0
> > [ =C2=A0 37.452924] Oops: 0000 [#1] PREEMPT SMP
> > [ =C2=A0 37.453336] last sysfs file: /sys/devices/platform/toshiba_=
acpi/backlight/toshiba/max_brightness
> > [ =C2=A0 37.453336] CPU 1
> > [ =C2=A0 37.453336] Modules linked in: tpm_infineon iwlagn iwlcore =
tifm_7xx1 tpm_tis toshiba_bluetooth toshiba_acpi tifm_core pcmcia sdhci=
_pci yenta_socket sdhci [last unloaded: scsi_wait_scan]
> > [ =C2=A0 37.453336]
> > [ =C2=A0 37.453336] Pid: 3117, comm: hald-probe-hidd Not tainted 2.=
6.36-rc4-00166-g151b6a5 #28 Portable PC/TECRA A9
> > [ =C2=A0 37.453336] RIP: 0010:[<ffffffff817d0991>] =C2=A0[<ffffffff=
817d0991>] hiddev_open+0xc1/0x220

Could please those of you who are able to reproduce the problem (from a=
=20
quick test seems that I am not) use 'addr2line' utility to convert the =
RIP=20
value (ffffffff817d0991 in this case) to the line number inside of=20
hiddev_open(), so that we can see whether it's something behind=20
usbhid_find_interface() causing NULL pointer dereference, or whether it=
 is=20
intfdata being NULL and thus going to hid->hiddev faults?

(sticking two printk()s in there should do the same as well).

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
