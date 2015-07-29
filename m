From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] input: twl4030-vibra: Fix ERROR: Bad of_node_put() warning
Date: Wed, 29 Jul 2015 11:44:47 +0200
Message-ID: <B4D9FDDB-C8AA-4909-A5DB-8A6FEEE5E579@goldelico.com>
References: <1437683914-4660-1-git-send-email-marek@goldelico.com> <20150723205314.GB12733@dtor-ws> <CAAfyv376CG1oZUTzduJgvuQzVhQjm4c3xfU1oi=gWJUJwiVrKQ@mail.gmail.com> <CAL_Jsq+ZYqxU0kVGKNtHjEDN9n3Sv2SXknq3j3TzdQ8Oh--tpQ@mail.gmail.com> <082BB390-0E09-4B40-8E27-801C6E3361D7@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:17167 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbG2Jo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 05:44:59 -0400
In-Reply-To: <082BB390-0E09-4B40-8E27-801C6E3361D7@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>

Hi Tomi,

Am 29.07.2015 um 07:47 schrieb Dr. H. Nikolaus Schaller <hns@goldelico.=
com>:

> Hi all,
>=20
> Am 29.07.2015 um 05:13 schrieb Rob Herring <robherring2@gmail.com>:
>=20
>> On Tue, Jul 28, 2015 at 3:23 PM, Belisko Marek <marek.belisko@gmail.=
com> wrote:
>>> Hi Dmitry,
>>>=20
>>> On Thu, Jul 23, 2015 at 10:53 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>> On Thu, Jul 23, 2015 at 10:38:34PM +0200, Marek Belisko wrote:
>>>>> Fix following:
>>>>> [    8.862274] ERROR: Bad of_node_put() on /ocp/i2c@48070000/twl@=
48/audio
>>>>> [    8.869293] CPU: 0 PID: 1003 Comm: modprobe Not tainted 4.2.0-=
rc2-letux+ #1175
>>>>> [    8.876922] Hardware name: Generic OMAP36xx (Flattened Device =
Tree)
>>>>> [    8.883514] [<c00159e0>] (unwind_backtrace) from [<c0012488>] =
(show_stack+0x10/0x14)
>>>>> [    8.891693] [<c0012488>] (show_stack) from [<c05cb810>] (dump_=
stack+0x78/0x94)
>>>>> [    8.899322] [<c05cb810>] (dump_stack) from [<c02cfd5c>] (kobje=
ct_release+0x68/0x7c)
>>>>> [    8.907409] [<c02cfd5c>] (kobject_release) from [<bf0040c4>] (=
twl4030_vibra_probe+0x74/0x188 [twl4030_vibra])
>>>>> [    8.917877] [<bf0040c4>] (twl4030_vibra_probe [twl4030_vibra])=
 from [<c03816ac>] (platform_drv_probe+0x48/0x90)
>>>>> [    8.928497] [<c03816ac>] (platform_drv_probe) from [<c037feb4>=
] (really_probe+0xd4/0x238)
>>>>> [    8.937103] [<c037feb4>] (really_probe) from [<c0380160>] (dri=
ver_probe_device+0x30/0x48)
>>>>> [    8.945678] [<c0380160>] (driver_probe_device) from [<c03801e0=
>] (__driver_attach+0x68/0x8c)
>>>>> [    8.954589] [<c03801e0>] (__driver_attach) from [<c037ea60>] (=
bus_for_each_dev+0x50/0x84)
>>>>> [    8.963226] [<c037ea60>] (bus_for_each_dev) from [<c037f828>] =
(bus_add_driver+0xcc/0x1e4)
>>>>> [    8.971832] [<c037f828>] (bus_add_driver) from [<c0380b60>] (d=
river_register+0x9c/0xe0)
>>>>> [    8.980255] [<c0380b60>] (driver_register) from [<c00097e0>] (=
do_one_initcall+0x100/0x1b8)
>>>>> [    8.988983] [<c00097e0>] (do_one_initcall) from [<c00b8008>] (=
do_init_module+0x58/0x1c0)
>>>>> [    8.997497] [<c00b8008>] (do_init_module) from [<c00b8cac>] (S=
yS_init_module+0x54/0x64)
>>>>> [    9.005950] [<c00b8cac>] (SyS_init_module) from [<c000ed20>] (=
ret_fast_syscall+0x0/0x54)
>>>>> [    9.015838] input: twl4030:vibrator as /devices/platform/68000=
000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:audio/input/input=
2
>>>>>=20
>>>>> node passed to of_find_node_by_name is put inside that function a=
nd new node
>>>>> is returned if found. Free returned node not already freed node.
>>>>=20
>>>> Hmm, if of_find_node_by_name() "puts" passed in node should we not=
 "get"
>>>> it before calling of_find_node_by_name()? The node pointer in ques=
tion
>>>> is simply copied from parent device.
>>> I'm not sure. what I can say is that I cannot see such error in 4.1
>>> but only in 4.2-rcx.
>>> Adding Grant and Rob to CC, maybe they know what should be done and
>>> why I see such error in 4.2-rcx.
>>=20
>> The problem was that node passed into of_find_node_by_name is the th=
e
>> starting point to search, but you should be doing the put on the
>> returned node. So the patch below is correct.
>=20
> Fine!
>=20
> We have a similar error on OMAP5 here:
>=20
> [   11.027144] CPU: 1 PID: 6 Comm: kworker/u4:0 Not tainted 4.2.0-rc4=
-letux+ #1187
> [   11.034790] Hardware name: Generic OMAP5 (Flattened Device Tree)
> [   11.041077] Workqueue: deferwq deferred_probe_work_func
> [   11.046557] [<c0015a00>] (unwind_backtrace) from [<c00124a0>] (sho=
w_stack+0x10/0x14)
> [   11.054663] [<c00124a0>] (show_stack) from [<c05cb694>] (dump_stac=
k+0x78/0x94)
> [   11.062224] [<c05cb694>] (dump_stack) from [<c02cfd5c>] (kobject_r=
elease+0x68/0x7c)
> [   11.070234] [<c02cfd5c>] (kobject_release) from [<c03291d8>] (omap=
dss_of_find_source_for_first_ep+0x58/0x74)
> [   11.080510] [<c03291d8>] (omapdss_of_find_source_for_first_ep) fro=
m [<bf089290>] (hdmic_probe+0xb4/0x22c [connector_hdmi])
> [   11.092080] [<bf089290>] (hdmic_probe [connector_hdmi]) from [<c03=
81490>] (platform_drv_probe+0x48/0x90)
> [   11.101997] [<c0381490>] (platform_drv_probe) from [<c037fc98>] (r=
eally_probe+0xd4/0x238)
> [   11.110556] [<c037fc98>] (really_probe) from [<c037ff44>] (driver_=
probe_device+0x30/0x48)
> [   11.119108] [<c037ff44>] (driver_probe_device) from [<c037e7bc>] (=
bus_for_each_drv+0x4c/0x84)
> [   11.128023] [<c037e7bc>] (bus_for_each_drv) from [<c037fe90>] (__d=
evice_attach+0x70/0xd0)
> [   11.136579] [<c037fe90>] (__device_attach) from [<c037f3f8>] (bus_=
probe_device+0x28/0x84)
> [   11.145135] [<c037f3f8>] (bus_probe_device) from [<c037f808>] (def=
erred_probe_work_func+0x58/0x88)
> [   11.154518] [<c037f808>] (deferred_probe_work_func) from [<c0054ff=
0>] (process_one_work+0x294/0x4a0)
> [   11.164083] [<c0054ff0>] (process_one_work) from [<c0055414>] (wor=
ker_thread+0x1ec/0x2fc)
> [   11.172641] [<c0055414>] (worker_thread) from [<c005a3b4>] (kthrea=
d+0xd4/0xe8)
> [   11.180200] [<c005a3b4>] (kthread) from [<c000edf8>] (ret_from_for=
k+0x14/0x3c)
>=20
> So it looks as if there are more get/put mismatches in the drivers wh=
ich are usually not visible.
>=20
>>=20
>> As far as why in 4.2, it seems you have OF_DYNAMIC enabled in your
>> config either because you have DT unit test or overlays enabled.
>> Overlays are now user enable-able in 4.2.
>=20
> Further analysis turns out that we recently have enabled DRM_TILCDC_S=
LAVE_COMPAT=3Dy
> which we need to make our uImage additionally support the BeagleBone =
Black with LDC panel
> (as mandated by  arch/arm/boot/dts/am335x-boneblack.dts using =93ti,t=
ilcdc,slave=94).
>=20
> This automatically enables OF_OVERLAY which enables OF_DYNAMIC.
>=20
> Obviously this now has unexpected side-effects on other systems with =
universal kernels configured
> to support both, beaglebone and non-beaglebone devices.
>=20
> So what is wrong? The sequence DRM_TILCDC_SLAVE_COMPAT =3D> set OF_OV=
ERLAY =3D> set OF_DYNAMIC?
>=20
> Or of_node_get/put() bugs in some drivers revealed by running the uni=
t tests?
>=20
> I have added Tomi to the discussion and we will try to understand/fix=
 omapdss_of_find_source_for_first_ep().

This workaround silences the ERROR but I have no explanation or fix:

diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbd=
ev/omap2/dss/dss-of.c
index 928ee63..2b55a5c 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -174,7 +174,7 @@ omapdss_of_find_source_for_first_ep(struct device_n=
ode *node)
=20
        src =3D omap_dss_find_output_by_port_node(src_port);
=20
-       of_node_put(src_port);
+//     of_node_put(src_port);
=20
        return src ? src : ERR_PTR(-EPROBE_DEFER);
 }

>=20

> BR,
> Nikolaus
>=20
>>=20
>> Rob
>>=20
>>>>=20
>>>> Thanks.
>>>>=20
>>>>>=20
>>>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>>>> ---
>>>>> drivers/input/misc/twl4030-vibra.c | 3 ++-
>>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/m=
isc/twl4030-vibra.c
>>>>> index fc17b95..10c4e3d 100644
>>>>> --- a/drivers/input/misc/twl4030-vibra.c
>>>>> +++ b/drivers/input/misc/twl4030-vibra.c
>>>>> @@ -183,7 +183,8 @@ static bool twl4030_vibra_check_coexist(struc=
t twl4030_vibra_data *pdata,
>>>>>     if (pdata && pdata->coexist)
>>>>>             return true;
>>>>>=20
>>>>> -     if (of_find_node_by_name(node, "codec")) {
>>>>> +     node =3D of_find_node_by_name(node, "codec");
>>>>> +     if (node) {
>>>>>             of_node_put(node);
>>>>>             return true;
>>>>>     }
>>>>> --
>>>>> 1.9.1
>>>>>=20
>>>>=20
>>>> --
>>>> Dmitry
>>>=20
>>> BR,
>>>=20
>>> marek
>>>=20
>>> --
>>> as simple and primitive as possible
>>> -------------------------------------------------
>>> Marek Belisko - OPEN-NANDRA
>>> Freelance Developer
>>>=20
>>> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
>>> Tel: +421 915 052 184
>>> skype: marekwhite
>>> twitter: #opennandra
>>> web: http://open-nandra.com
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
