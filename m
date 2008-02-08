From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD_FAILURE] 2.6.24-git18 build fails section type conflict
 psmouse-base
Date: Fri, 08 Feb 2008 19:53:10 +0530
Message-ID: <47AC65CE.7090708@linux.vnet.ibm.com>
References: <47AC2FDB.7080104@linux.vnet.ibm.com> <20080208104851.GI7198@cs181133002.pp.htv.fi> <47AC502C.70809@linux.vnet.ibm.com> <20080208133022.GA2254@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:60099 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131AbYBHOX0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Feb 2008 09:23:26 -0500
In-Reply-To: <20080208133022.GA2254@cs181133002.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Adrian Bunk wrote:
> On Fri, Feb 08, 2008 at 06:20:52PM +0530, Kamalesh Babulal wrote:
>> Adrian Bunk wrote:
>>> On Fri, Feb 08, 2008 at 04:02:59PM +0530, Kamalesh Babulal wrote:
>>>> Hi,
>>>>
>>>> The 2.6.24-git18 kernel build fails on the power machine with foll=
owing message
>>>>
>>>> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes=
 a section type conflict
>>>> drivers/input/mouse/psmouse-base.c:44: error: __param_proto causes=
 a section type conflict
>>>> make[3]: *** [drivers/input/mouse/psmouse-base.o] Error 1
>>>> make[2]: *** [drivers/input/mouse] Error 2
>>>> make[1]: *** [drivers/input] Error 2
>>>> make: *** [drivers] Error 2
>>>>
>>>> this failure was reported earlier http://lkml.org/lkml/2007/9/22/6=
4
>>> You need the patch from [1] manually applied (due to changed contex=
t)=20
>>> and with " || defined(__powerpc__)" added for getting it compiling.
>>>
>>> @Rusty:
>>> Can you look at this issue? It's a modules problem on 3 architectur=
es.
>>>
>>> cu
>>> Adrian
>>>
>>> [1] http://lkml.org/lkml/2007/12/27/29
>>>
>> I tried manually applying the patch and added ||defined(__powerpc__)=
, the above
>> build failure was resolved but it started failing at another place,=20
>>
>>   CC      kernel/printk.o
>> kernel/printk.c:568: error: expected =E2=80=98=3D=E2=80=99, =E2=80=98=
,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__at=
tribute__=E2=80=99 before =E2=80=98static=E2=80=99
>> make[1]: *** [kernel/printk.o] Error 1
>> make: *** [kernel] Error 2
>=20
> Below is what worked for me (based on Ivan's patch).
>=20
> The comment is wrong now, the #if's should refer to kconfig variables=
,=20
> and I don't know whether this patch is really the best solution.
>=20
> cu
> Adrian
>=20
>=20
> 1fffe660ace75bd875fc23f7b2121d7341f08464 diff --git a/include/linux/m=
oduleparam.h b/include/linux/moduleparam.h
> index 8126e55..d17ce12 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -62,6 +62,15 @@ struct kparam_array
>  	void *elem;
>  };
>=20
> +/* On alpha and ia64 relocations to global data cannot go into read-=
only
> +   sections, so 'const' makes no sense and even causes compile failu=
res
> +   with some compilers. */
> +#if defined(__alpha__) || defined(__ia64__) || defined(__powerpc__)
> +#define __moduleparam_const
> +#else
> +#define __moduleparam_const const
> +#endif
> +
>  /* This is the fundamental function for registering boot/module
>     parameters.  perm sets the visibility in sysfs: 000 means it's
>     not there, read bits mean it's readable, write bits mean it's
> @@ -71,7 +80,7 @@ struct kparam_array
>  	static int __param_perm_check_##name __attribute__((unused)) =3D	\
>  	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2));	\
>  	static const char __param_str_##name[] =3D prefix #name;		\
> -	static struct kernel_param const __param_##name			\
> +	static struct kernel_param __moduleparam_const __param_##name			\
>  	__used								\
>      __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(vo=
id *)))) \
>  	=3D { __param_str_##name, perm, set, get, { arg } }
> --
Hi Adrian,

Thanks the patch resolves the problem, I had a typo when applied the ma=
nually :-(.

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
