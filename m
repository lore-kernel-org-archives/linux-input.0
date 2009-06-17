From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 16:35:51 -0400
Message-ID: <4A3953A7.2080608@seas.upenn.edu>
References: <4A385751.8000904@seas.upenn.edu>  <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr> <4A393750.7020706@seas.upenn.edu> <58BC0DDC-EC89-4C4D-B688-079326B641E2@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:42485 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZFQUfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 16:35:54 -0400
In-Reply-To: <58BC0DDC-EC89-4C4D-B688-079326B641E2@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org

St=E9phane Chatty wrote:
>=20
> Le 17 juin 09 =E0 20:34, Rafi Rubin a =E9crit :
>=20
>> I did in fact submit a patch to linuxwacom a while ago specifically =
to
>> solve that problem.
>>
>=20
> Good!
>=20
> Then I have a minor suggestion: it would be better to just remove the=
se
> lines. The point of this switch is to catch the values that we want t=
o
> handle in a special way. All others (and that's quite a few) just mak=
e
> it through the switch.

=46air enough.  I partly just wanted to document the behavior.  I'll ad=
just shortly.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
