From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 21:29:22 +0200
Message-ID: <58BC0DDC-EC89-4C4D-B688-079326B641E2@enac.fr>
References: <4A385751.8000904@seas.upenn.edu>  <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr> <4A393750.7020706@seas.upenn.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41364 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZFQT3a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 15:29:30 -0400
In-Reply-To: <4A393750.7020706@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org


Le 17 juin 09 =E0 20:34, Rafi Rubin a =E9crit :

> I did in fact submit a patch to linuxwacom a while ago specifically =20
> to solve that problem.
>

Good!

Then I have a minor suggestion: it would be better to just remove =20
these lines. The point of this switch is to catch the values that we =20
want to handle in a special way. All others (and that's quite a few) =20
just make it through the switch.

St.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
