From: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Sun, 05 Apr 2015 20:06:16 +0300
Message-ID: <1428253576.29867.7.camel@plaes.org>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
	 <1428181693-25362-2-git-send-email-plaes@plaes.org>
	 <1428249864.28443.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plaes.org ([188.166.43.21]:54780 "EHLO plaes.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752365AbbDERHL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Apr 2015 13:07:11 -0400
In-Reply-To: <1428249864.28443.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On Sun, 2015-04-05 at 18:04 +0200, Bastien Nocera wrote:
> On Sun, 2015-04-05 at 00:08 +0300, Priit Laes wrote:
> > This patch implements GT801x2 touchscreen support.
> > Unfortunately, there is a big difference between GT801 and GT9xx=20
> > series
> > chips, therefore some advice is needed on how to proceed.
> >=20
> > Differences between GT801x2 and GT9xx series:
> >=20
> > 1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
> > 2. Different configuration layout and version info
> > 3. Different touch report protocol
>=20
> That doesn't seem like an awful lot of differences. Approximately 80=20
> line changes for 500 lines of driver code. You could add an enum for=20
> the 8xx and 9xx types near the top, add that as driver data in the=20
> match arrays (both the ACPI and OF ones). Then have if statements=20
> choose the correct init, read and report functions.

How should I handle the version readout?

Currently the driver has following info in its registers (starting=20
from 0xf0):

f0: 47 54 38 30 31 4e 49 5f 33 52 31 35 5f 31 41 56    GT801NI_3R15_1AV


And there's another issue with deactivating interrupts. When I remove=20
the goodix module, I get following traceback:

[snip]
WARNING: CPU: 0 PID: 381 at fs/proc/generic.c:552 remove_proc_entry+0x1=
38/0x16c()
remove_proc_entry: removing non-empty directory 'irq/50', leaking at le=
ast 'gt801x2'
Modules linked in: goodix(-) rtl8192cu rtl_usb rtl8192c_common rtlwifi
CPU: 0 PID: 381 Comm: rmmod Not tainted 4.0.0-rc1+ #22
Hardware name: Allwinner A1X (Device Tree)
[<c0014544>] (unwind_backtrace) from [<c00116e4>] (show_stack+0x10/0x14=
)
[<c00116e4>] (show_stack) from [<c042995c>] (dump_stack+0x84/0x94)
[<c042995c>] (dump_stack) from [<c0021140>] (warn_slowpath_common+0x80/=
0xb0)
[<c0021140>] (warn_slowpath_common) from [<c00211a0>] (warn_slowpath_fm=
t+0x30/0x40)
[<c00211a0>] (warn_slowpath_fmt) from [<c0124474>] (remove_proc_entry+0=
x138/0x16c)
[<c0124474>] (remove_proc_entry) from [<c0060358>] (unregister_irq_proc=
+0xa8/0xb0)
[<c0060358>] (unregister_irq_proc) from [<c00595d0>] (free_desc+0x30/0x=
60)
[<c00595d0>] (free_desc) from [<c0059648>] (irq_free_descs+0x48/0x80)
[<c0059648>] (irq_free_descs) from [<c02da850>] (i2c_device_remove+0x64=
/0x80)
[<c02da850>] (i2c_device_remove) from [<c025af5c>] (__device_release_dr=
iver+0x70/0xc4)
[<c025af5c>] (__device_release_driver) from [<c025b68c>] (driver_detach=
+0xcc/0xd0)
[<c025b68c>] (driver_detach) from [<c025acbc>] (bus_remove_driver+0x4c/=
0xa0)
[<c025acbc>] (bus_remove_driver) from [<c007d170>] (SyS_delete_module+0=
x16c/0x1b8)
[<c007d170>] (SyS_delete_module) from [<c000e4a0>] (ret_fast_syscall+0x=
0/0x34)
[/snip]

Devicetree node contains following:

[snip]
&i2c2 {
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&i2c2_pins_a>;
    status =3D "okay";

    /* Touchscreen */
    touchscreen@55 {
        compatible =3D "goodix,gt801x2";
        reg =3D <0x55>;

        interrupt-parent =3D <&pio>;
        interrupts =3D <21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
   };
};
[/snip]

P=C3=A4ikest,
Priit :)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
