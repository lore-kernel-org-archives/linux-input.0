From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: fix bug destroying hidraw device files after
 parent
Date: Wed, 26 Feb 2014 11:02:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402261101540.5466@pobox.suse.cz>
References: <1393401084.4876.2.camel@nexus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39427 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaBZKCn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Feb 2014 05:02:43 -0500
In-Reply-To: <1393401084.4876.2.camel@nexus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>

On Wed, 26 Feb 2014, Fernando Luis V=C3=A1zquez Cao wrote:

> I noticed that after hot unplugging a Logitech unifying receiver
> (drivers/hid/hid-logitech-dj.c) the kernel would occasionally spew a
> stack trace similar to this:
>=20
> usb 1-1.1.2: USB disconnect, device number 7
> WARNING: CPU: 0 PID: 2865 at fs/sysfs/group.c:216 device_del+0x40/0x1=
b0()
> sysfs group ffffffff8187fa20 not found for kobject 'hidraw0'
> [...]
> CPU: 0 PID: 2865 Comm: upowerd Tainted: G        W 3.14.0-rc4 #7
> Hardware name: LENOVO 7783PN4/        , BIOS 9HKT43AUS 07/11/2011
>  0000000000000009 ffffffff814cd684 ffff880427ccfdf8 ffffffff810616e7
>  ffff88041ec61800 ffff880427ccfe48 ffff88041e444d80 ffff880426fab8e8
>  ffff880429359960 ffffffff8106174c ffffffff81714b98 0000000000000028
> Call Trace:
>  [<ffffffff814cd684>] ? dump_stack+0x41/0x51
>  [<ffffffff810616e7>] ? warn_slowpath_common+0x77/0x90
>  [<ffffffff8106174c>] ? warn_slowpath_fmt+0x4c/0x50
>  [<ffffffff81374fd0>] ? device_del+0x40/0x1b0
>  [<ffffffff8137516f>] ? device_unregister+0x2f/0x50
>  [<ffffffff813751fa>] ? device_destroy+0x3a/0x40
>  [<ffffffffa03ca245>] ? drop_ref+0x55/0x120 [hid]
>  [<ffffffffa03ca3e6>] ? hidraw_release+0x96/0xb0 [hid]
>  [<ffffffff811929da>] ? __fput+0xca/0x210
>  [<ffffffff8107fe17>] ? task_work_run+0x97/0xd0
>  [<ffffffff810139a9>] ? do_notify_resume+0x69/0xa0
>  [<ffffffff814dbd22>] ? int_signal+0x12/0x17

Applied, thanks.

I have slightly modified the patch title to make sure that it's obvious=
=20
that what it fixes is actually a WARN_ON() splat.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
