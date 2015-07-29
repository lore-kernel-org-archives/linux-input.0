From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] input: twl4030-vibra: Fix ERROR: Bad of_node_put() warning
Date: Wed, 29 Jul 2015 19:50:24 +0200
Message-ID: <C6FA80D1-B1EC-4C8B-9E58-448156DDE766@goldelico.com>
References: <1437683914-4660-1-git-send-email-marek@goldelico.com> <20150723205314.GB12733@dtor-ws> <CAAfyv376CG1oZUTzduJgvuQzVhQjm4c3xfU1oi=gWJUJwiVrKQ@mail.gmail.com> <CAL_Jsq+ZYqxU0kVGKNtHjEDN9n3Sv2SXknq3j3TzdQ8Oh--tpQ@mail.gmail.com> <20150729172602.GB23178@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150729172602.GB23178@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Belisko Marek <marek.belisko@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-input@vger.kernel.org


Am 29.07.2015 um 19:26 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.c=
om>:

> On Tue, Jul 28, 2015 at 10:13:54PM -0500, Rob Herring wrote:
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
>>=20
>> As far as why in 4.2, it seems you have OF_DYNAMIC enabled in your
>> config either because you have DT unit test or overlays enabled.
>> Overlays are now user enable-able in 4.2.
>=20
> Right, but the question was whether we should also "get" the node tha=
t
> we are passing into of_find_node_by_name(), or, maybe better, stop
> of_find_node_by_name() from "putting" the node that is passed in? It =
is
> really surprising behavior.

I agree that it is quite unexpected and would be much easier to underst=
and
if it would not put the node.

But I guess it is intended to be a convenience to make it easier to wal=
k down
the tree, i.e. that you can simply write

np =3D of_find_node_by_name(NULL, =93level11=94);
np =3D of_find_node_by_name(np, =93level2=94);
np =3D of_find_node_by_name(np, =93level3=94);

Otherwise it would need some temporary variable and explicit calls to p=
ut the
parent level after finding a child node.

On the other hand greping for of_find_node_by_name returns many more
calls with parent =3D NULL than others. So the put is ignored anyways.

But it is a major change in semantics of a very low level function so i=
t is
easy to introduce regressions (especially in out-of-the tree drivers).

Just my 2 cts,
Nikolaus
