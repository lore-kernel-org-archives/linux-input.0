From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 21 Sep 2010 17:07:24 +0200
Message-ID: <4563C8AB-A357-4D31-9943-E25951536977@enac.fr>
References: <1284476919.3732.10.camel@PhEeeTab>  <DAB0AEF8-B5D1-4D21-83E2-6535B8AA0A4B@enac.fr> <alpine.LNX.2.00.1009211606180.26813@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:42399 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab0IUPHc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 11:07:32 -0400
In-Reply-To: <alpine.LNX.2.00.1009211606180.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Philipp Merkel <mail@philmerk.de>, linux-input <linux-input@vger.kernel.org>


Le 21 sept. 10 =E0 16:06, Jiri Kosina a =E9crit :

> On Mon, 20 Sep 2010, St=E9phane Chatty wrote:
>
>>> 3) Only multi-touch pressure events are sent, single touch =20
>>> emulation is
>>>   missing pressure information. This patch adds single-touch
>>>   ABS_PRESSURE events.
>>>
>> Oops, thx for the fix.
>
> Stephane, can I consider this being your Acked-by: for the whole =20
> patch?

Well, there's still the issue of the 0eef:72xx series that might be =20
disrupted by the patch. We can decide to remove that series from the =20
list of supported devices, but it would be good to check first =20
whether these panels have the same issue or not. If they do, we can =20
apply the patch without second thoughts. If they don't, we should =20
probably remove them and write another driver. I have asked feedback =20
from an author of PyMT who owns a Joojoo.

Cheers,

St. --
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
