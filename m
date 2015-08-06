From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] input: twl4030-vibra: Fix ERROR: Bad of_node_put() warning
Date: Thu, 6 Aug 2015 13:34:01 +0300
Message-ID: <55C33819.4030204@ti.com>
References: <1437683914-4660-1-git-send-email-marek@goldelico.com> <20150723205314.GB12733@dtor-ws> <CAAfyv376CG1oZUTzduJgvuQzVhQjm4c3xfU1oi=gWJUJwiVrKQ@mail.gmail.com> <CAL_Jsq+ZYqxU0kVGKNtHjEDN9n3Sv2SXknq3j3TzdQ8Oh--tpQ@mail.gmail.com> <082BB390-0E09-4B40-8E27-801C6E3361D7@goldelico.com> <B4D9FDDB-C8AA-4909-A5DB-8A6FEEE5E579@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QH4tqRNSQ2haOr3njIuBtE4QH4UPWnmbo"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbbHFKeS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2015 06:34:18 -0400
In-Reply-To: <B4D9FDDB-C8AA-4909-A5DB-8A6FEEE5E579@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, "Sarha, Jyri" <jsarha@ti.com>

--QH4tqRNSQ2haOr3njIuBtE4QH4UPWnmbo
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 29/07/15 12:44, Dr. H. Nikolaus Schaller wrote:

>> We have a similar error on OMAP5 here:
>>
>> [   11.027144] CPU: 1 PID: 6 Comm: kworker/u4:0 Not tainted 4.2.0-rc4-=
letux+ #1187
>> [   11.034790] Hardware name: Generic OMAP5 (Flattened Device Tree)
>> [   11.041077] Workqueue: deferwq deferred_probe_work_func
>> [   11.046557] [<c0015a00>] (unwind_backtrace) from [<c00124a0>] (show=
_stack+0x10/0x14)
>> [   11.054663] [<c00124a0>] (show_stack) from [<c05cb694>] (dump_stack=
+0x78/0x94)
>> [   11.062224] [<c05cb694>] (dump_stack) from [<c02cfd5c>] (kobject_re=
lease+0x68/0x7c)
>> [   11.070234] [<c02cfd5c>] (kobject_release) from [<c03291d8>] (omapd=
ss_of_find_source_for_first_ep+0x58/0x74)
>> [   11.080510] [<c03291d8>] (omapdss_of_find_source_for_first_ep) from=
 [<bf089290>] (hdmic_probe+0xb4/0x22c [connector_hdmi])
>> [   11.092080] [<bf089290>] (hdmic_probe [connector_hdmi]) from [<c038=
1490>] (platform_drv_probe+0x48/0x90)
>> [   11.101997] [<c0381490>] (platform_drv_probe) from [<c037fc98>] (re=
ally_probe+0xd4/0x238)
>> [   11.110556] [<c037fc98>] (really_probe) from [<c037ff44>] (driver_p=
robe_device+0x30/0x48)
>> [   11.119108] [<c037ff44>] (driver_probe_device) from [<c037e7bc>] (b=
us_for_each_drv+0x4c/0x84)
>> [   11.128023] [<c037e7bc>] (bus_for_each_drv) from [<c037fe90>] (__de=
vice_attach+0x70/0xd0)
>> [   11.136579] [<c037fe90>] (__device_attach) from [<c037f3f8>] (bus_p=
robe_device+0x28/0x84)
>> [   11.145135] [<c037f3f8>] (bus_probe_device) from [<c037f808>] (defe=
rred_probe_work_func+0x58/0x88)
>> [   11.154518] [<c037f808>] (deferred_probe_work_func) from [<c0054ff0=
>] (process_one_work+0x294/0x4a0)
>> [   11.164083] [<c0054ff0>] (process_one_work) from [<c0055414>] (work=
er_thread+0x1ec/0x2fc)
>> [   11.172641] [<c0055414>] (worker_thread) from [<c005a3b4>] (kthread=
+0xd4/0xe8)
>> [   11.180200] [<c005a3b4>] (kthread) from [<c000edf8>] (ret_from_fork=
+0x14/0x3c)
>>
>> So it looks as if there are more get/put mismatches in the drivers whi=
ch are usually not visible.

Yep, we'll have a look at that.

 Tomi


--QH4tqRNSQ2haOr3njIuBtE4QH4UPWnmbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwzgZAAoJEPo9qoy8lh71DzEQAJTXfERGagRCwbp799Nlba84
KlhYOC9ydZ3fLIQHX9yg3rMS4ZlO6Jk+PBTY/aD3EudWGYyDr35tX3eUA/JM+RmY
Qw34/zXI34Wus3BfkwhleRv9jJFdAQkMbyU6AwspbRmPd3vVXVqWErbvDPPGFj+W
uR+Medkcp7mI7q/oFrtfpHvm37pJGT4+k1JQ6BT3Gr9/H/aZbFedWpDORUOXwDYi
nrkBoRPAqPAAqN5icO0YoRq1jA4XLfs2hMueFVMY1MA9OZUCqBHN9rgc0ORIpsU5
NOi7n2SepnnHRKM2sHA8+le8f97h3Z+Wk73jdFuts3+S5IUehSjIN7+SQmcndSj5
IN3qN8XpHgEiXOrBt2cr5NxkKLqPraS5d6NbG0mG4zP9WtqQhVYDuN9ouB/x2ZVW
4XTyCASsLGFHNQm/U2LnbHQiJdk91QpKEPxsdVF+a7lTzkWzUJtQix2ofo5Qhqn+
Rz3r0iIcj7oKXUHhk7OWdCOmAH1KkYMDnnnUKoCTFStoXqx1YNk1H8JDTY7vuF8u
L3I6fXVpoAoumVelGYTI05iriP+VZEarA0Qk0oz/Su93lN5qbAiKW28nRMo69OFm
ysAFsYKBOFgwMQMH9/9BvtQ64cjL+AgtrqG4zNqvIm4rNp5OhL5Am0VJdeGR5dor
Nv0Knmay6tsZhXzpy84T
=Nca6
-----END PGP SIGNATURE-----

--QH4tqRNSQ2haOr3njIuBtE4QH4UPWnmbo--
