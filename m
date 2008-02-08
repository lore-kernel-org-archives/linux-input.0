From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD_FAILURE] 2.6.24-git18 build fails section type conflict
 psmouse-base
Date: Fri, 08 Feb 2008 18:20:52 +0530
Message-ID: <47AC502C.70809@linux.vnet.ibm.com>
References: <47AC2FDB.7080104@linux.vnet.ibm.com> <20080208104851.GI7198@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:51438 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYBHMu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Feb 2008 07:50:57 -0500
In-Reply-To: <20080208104851.GI7198@cs181133002.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Adrian Bunk wrote:
> On Fri, Feb 08, 2008 at 04:02:59PM +0530, Kamalesh Babulal wrote:
>> Hi,
>>
>> The 2.6.24-git18 kernel build fails on the power machine with follow=
ing message
>>
>> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes a=
 section type conflict
>> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes a=
 section type conflict
>> make[3]: *** [drivers/input/mouse/psmouse-base.o] Error 1
>> make[2]: *** [drivers/input/mouse] Error 2
>> make[1]: *** [drivers/input] Error 2
>> make: *** [drivers] Error 2
>>
>> this failure was reported earlier http://lkml.org/lkml/2007/9/22/64
>=20
> You need the patch from [1] manually applied (due to changed context)=
=20
> and with " || defined(__powerpc__)" added for getting it compiling.
>=20
> @Rusty:
> Can you look at this issue? It's a modules problem on 3 architectures=
=2E
>=20
> cu
> Adrian
>=20
> [1] http://lkml.org/lkml/2007/12/27/29
>=20
I tried manually applying the patch and added ||defined(__powerpc__), t=
he above
build failure was resolved but it started failing at another place,=20

  CC      kernel/printk.o
kernel/printk.c:568: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=
=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attrib=
ute__=E2=80=99 before =E2=80=98static=E2=80=99
make[1]: *** [kernel/printk.o] Error 1
make: *** [kernel] Error 2


--=20
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
