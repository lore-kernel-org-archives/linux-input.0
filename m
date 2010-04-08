From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 1/4] Fix the drivers/media/dvb/ttpci/budget-ci.c conversion
 to	ir-core
Date: Thu, 08 Apr 2010 20:11:51 -0300
Message-ID: <4BBE62B7.9010807@redhat.com>
References: <20100408230246.14453.97377.stgit@localhost.localdomain> <20100408230425.14453.62639.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933780Ab0DHXMa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Apr 2010 19:12:30 -0400
In-Reply-To: <20100408230425.14453.62639.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgSMOkcmRlbWFu?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

Hi David,

David H=C3=A4rdeman wrote:
> When I converted drivers/media/dvb/ttpci/budget-ci.c to use ir-core
> I missed one line. This patch fixes that mistake.

I did this already (I merged with your commit, at v4l-dvb.git), to avoi=
d=20
breaking git bisect. I'll backport it to the ir.git tree after finishin=
g
to process my loooong patchwork queue. (I'll probably just create a new
branch there from v4l-dvb.git - since I've merged all ir-related patche=
s
there already).


Cheers,
Mauro

PS.: As you can see, stgit did the right thing with inline ;)
>=20
> Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
> ---
>  drivers/media/dvb/ttpci/budget-ci.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/dvb/ttpci/budget-ci.c b/drivers/media/dvb/=
ttpci/budget-ci.c
> index 8950df1..4617143 100644
> --- a/drivers/media/dvb/ttpci/budget-ci.c
> +++ b/drivers/media/dvb/ttpci/budget-ci.c
> @@ -225,8 +225,6 @@ static int msp430_ir_init(struct budget_ci *budge=
t_ci)
>  		break;
>  	}
> =20
> -	ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);
> -
>  	error =3D ir_input_register(input_dev, ir_codes, NULL, MODULE_NAME)=
;
>  	if (error) {
>  		printk(KERN_ERR "budget_ci: could not init driver for IR device (c=
ode %d)\n", error);
>=20


--=20

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
