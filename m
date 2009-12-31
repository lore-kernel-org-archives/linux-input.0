From: Marcin Tolysz <tolysz@gmail.com>
Subject: Re: [RFC v2] [HID] allow using external Hid Descriptors.
Date: Thu, 31 Dec 2009 19:24:08 +0000
Message-ID: <54bbe4e00912311124v4e7c869egb78645d1432d17d@mail.gmail.com>
References: <4B337226.6050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:58134 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbZLaTYM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Dec 2009 14:24:12 -0500
Received: by fxm25 with SMTP id 25so6886435fxm.21
        for <linux-input@vger.kernel.org>; Thu, 31 Dec 2009 11:24:08 -0800 (PST)
In-Reply-To: <4B337226.6050509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Politics:
Q1) Why is this patch important?
A1) Linux HID driver is really good code, however because of errors in
HID description reports we need to write separate drivers, patching,
and playing with raw data: reimplementing the hid event reporting, and
adding quirks.
Most of the hardware could be usable just after providing a valid hid
descriptor!

Q2) But is it useful. How can I use it?
A2). Take, Sony Vaio VGX has wrongly mouse pointer declared as
constant  from hid-sony.c there is a just a bit of code which fixes
descriptor. We were lucky as we did not needed to change its size.
But the most sane approach is to fix the descriptor! as it is the only
stuff needed.
1) dump it from /debug/hid/!!device!!/rdesc
2) copy&edit it leaving only 1st line
3) convert to bin eg. cat descriptor.txt | hex2bin.sh > descriptor.bin
----hex2bin.sh
#!/bin/bash
echo -n -e $(tr -d '[:space:]' | sed 's/../\\x&/g')
4) place in /lib/firmware/hid/... where the location is provided by ker=
n.log
BTW, If someone could fix this descriptor, the mouse could be removed
from hid-sony.c


Q3) Why I want this?
A3) A while back, a year back I thought it would be possible to make
PS3 Sixaxis Controller(over USB, as current BT stack is broken for
this controller) usable with Linux. Just by replacing its descriptor,
the previous solution required static compiled in array and
recompilation after each change, with this one you can edit it,
re-plug device, and see in /debug/hid/ the resultant parse (!).

Q4) Did I managed to do this?
A4) Yes, but it requires a bit more than just HID, it requires
patching the hid-core, and hid-input, and hid-sony.
1)Sixaxis report, provides its accelerometers in reversed to standard
(for hid report) endianes, thus I need to swap those bits in the
report.
2)Create a proper report (now it takes 16 bits for each of the
accelerometers the first two have logical range [512-128,512+127],
with physical [127,-128][inverted by hid-input but we can compensate
this in descriptor inverting it once more] and [-128,127]) the last
two [0,1024] and [-512,512]  (done.) + as extra putting buttons in a
proper order.
Soon I will focus more on the other features reported by this device
and investigate how to make it rumble just by playing with its
descriptor.

3)Now the hard bit, we need to use Logical(hardware) and Physical(what
the user wants to see) extrema, the current implementation uses just
Logical one, this requires one step more processing by user-land
software (events are reported in logical terms, I did not seen how to
extract the physical extrema latter, and reimplement its handling in
every software). I had used translation from logical to physical,
based on values from the descriptor (and if this was wrong, we can fix
it by replacing it :D ), I have changed the parser to use signed vales
for both physical extrema, as in case pmax < pmin
translation[(pmax-pmin)*(x-min)/(max-min) + pmin] inverts the axis.
(This fixes EVENTS reporting, and works with jscalibrator)
4) hid-input, just a small change to report not logical but physical
extrema for axes (+handling pmax<pmin +some more handling)

[the patch will come soon I just need to clean it a bit more]

Works!

2009/12/24 Marcin Tolysz <tolysz@gmail.com>:
> It simple yet effective way of changing HID device descriptors
> using kernel firmware loading mechanism.
> Each time kernel will initialise a new hid device it will print
> as INFO the searched location for new descriptor.
>
> Just place your new descriptor in binary format in this location
> i.e. somewhere in /lib/firmware/hid/
> and it will use it in-place of HID descriptor of the device.
>
> This is good enough for now but ideally there should be a way of
> hotswaping it (i.e. while using this device) now we need to reconnect=
 it.
> This would be ideal for some game controllers where you change its la=
yout
> dynamically depending on add-ons you connect to it (i.e. wii)
>
> There are few questions:
> 1) What file name should have in it? What in it: SN, VEN,PROD,BUS,VER=
,...
> =C2=A0giving the ability to hard code each device, or to rely on "hot=
plug".
> 2) Should we print the info each time as we can see the info from
> =C2=A0the firmware_class telling us the location.
>
> Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
> ---
> =C2=A0drivers/hid/hid-core.c | =C2=A0 29 ++++++++++++++++++++++++++++=
-
> =C2=A01 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 80792d3..4ee4299 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -27,6 +27,7 @@
> =C2=A0#include <linux/wait.h>
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/sched.h>
> +#include <linux/firmware.h>
>
> =C2=A0#include <linux/hid.h>
> =C2=A0#include <linux/hiddev.h>
> @@ -640,6 +641,10 @@ int hid_parse_report(struct hid_device *device, =
__u8 *start,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hid_item item;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 *end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> + =C2=A0 =C2=A0 =C2=A0 const struct firmware *fw;
> + =C2=A0 =C2=A0 =C2=A0 int fw_fail;
> + =C2=A0 =C2=A0 =C2=A0 const char *file;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static int (*dispatch_type[])(struct hid_p=
arser *parser,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct h=
id_item *item) =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hid_parser_mai=
n,
> @@ -650,10 +655,28 @@ int hid_parse_report(struct hid_device *device,=
 __u8 *start,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (device->driver->report_fixup)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device->driver=
->report_fixup(device, start, size);
> + =C2=A0 =C2=A0 =C2=A0 /* Now try to load a hid descriptor from a fil=
e firmware
> + =C2=A0 =C2=A0 =C2=A0 if succesful ignoring this fixup thing */
> + =C2=A0 =C2=A0 =C2=A0 file =3D kasprintf(GFP_KERNEL, "hid/%04X:%04X:=
%04X:%04X.bin",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 device->bus, device->vendor, device->product, device->version);
> +
> + =C2=A0 =C2=A0 =C2=A0 fw_fail =3D request_firmware(&fw, file, &devic=
e->dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fw_fail)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("To relace=
 HID descriptor place it in /lib/firmaware/%s\n", file);
> + =C2=A0 =C2=A0 =C2=A0 else{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D fw->data=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D fw->size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("HID descr=
iptor relaced with /lib/firmaware/%s\n", file);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 kfree(file);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device->rdesc =3D kmalloc(size, GFP_KERNEL=
);
> - =C2=A0 =C2=A0 =C2=A0 if (device->rdesc =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 if (device->rdesc =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fw_fail)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 release_firmware(fw);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(device->rdesc, start, size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device->rsize =3D size;
>
> @@ -690,6 +713,8 @@ int hid_parse_report(struct hid_device *device, _=
_u8 *start,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbg_hid("unbalanced delimiter=
 at end of report description\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!fw_fail)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(fw);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0vfree(parser);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -697,6 +722,8 @@ int hid_parse_report(struct hid_device *device, _=
_u8 *start,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dbg_hid("item fetching failed at offset %d=
\n", (int)(end - start));
> =C2=A0err:
> + =C2=A0 =C2=A0 =C2=A0 if (!fw_fail)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(f=
w);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0vfree(parser);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> --
> 1.6.5.7
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
