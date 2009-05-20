From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Augment the event semantics documentation
Date: Wed, 20 May 2009 10:16:16 +0200
Message-ID: <4A13BC50.4010705@euromail.se>
References: <1242593479-9238-1-git-send-email-rydberg@euromail.se> <1242593479-9238-2-git-send-email-rydberg@euromail.se> <20090520025957.GE17649@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:53869 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756236AbZETIQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 04:16:39 -0400
In-Reply-To: <20090520025957.GE17649@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Henrik,
>=20
> On Sun, May 17, 2009 at 10:51:19PM +0200, Henrik Rydberg wrote:
>> Through the collaboration to adapt the N-trig and Stantum HID
>> drivers to the MT protocol, some semantic clarifications to the
>> protocol have been made. This patch adds them to the MT documentatio=
n.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> Tested-by: St=E9phane Chatty <chatty@enac.fr>
>=20
> I was wondering if the following changes would not make the text a bi=
t
> better:

They do, thanks. I got more comments on the text, perhaps it is easiest
if I send an additional patch on top of this one, with your changes
included? It seems folding a patch is easier than to find out what
changes were made to the changes.

Cheers,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
