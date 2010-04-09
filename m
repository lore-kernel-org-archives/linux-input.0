From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 4/4] Add RC6 support to ir-core
Date: Fri, 09 Apr 2010 09:43:27 -0300
Message-ID: <4BBF20EF.6000407@redhat.com>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>    <20100408230440.14453.36936.stgit@localhost.localdomain>    <4BBEE27E.5000007@linuxtv.org> <8c0ad8ce32382165227407b11ee1f073.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47296 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab0DIMnj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Apr 2010 08:43:39 -0400
In-Reply-To: <8c0ad8ce32382165227407b11ee1f073.squirrel@www.hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: Andreas Oberritter <obi@linuxtv.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

David H=E4rdeman wrote:
> On Fri, April 9, 2010 10:17, Andreas Oberritter wrote:
>>> +/* from ir-rc6-decoder.c */
>>> +#ifdef CONFIG_IR_RC5_DECODER_MODULE
>> you probably intended to use CONFIG_IR_RC6_DECODER_MODULE instead.

Andreas, thanks for pointing it!

> Of course, thanks for noticing.
>=20
> Mauro, do you want a new patch or will you fix it yourself?=20

=46ixed. Just sent the correction patches upstream. As, in this case, i=
t
doesn't break bisect, I just added a one-line change patch.

> (and by the
> way, Mauro, how come the patches went straight to the v4l-dvb.git tre=
e? I
> assume they'll be merged back to your ir.git tree at a later stage?)

I just merged it back at the ir.git tree.

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
