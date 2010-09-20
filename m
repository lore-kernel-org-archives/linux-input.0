From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 21:51:15 +0200
Message-ID: <4C97BB33.5020806@euromail.se>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-2-git-send-email-rydberg@euromail.se> <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:58198 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802Ab0ITTv0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 15:51:26 -0400
In-Reply-To: <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/20/2010 09:46 PM, St=E9phane Chatty wrote:

>=20
> Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :
>=20
>>  #define MAX_SLOTS        60
>> -#define MAX_TRKID        59
>> +#define MAX_TRKID        USHRT_MAX
>>
>=20
> Oops, I forgot this one: in the rest of the code, it seems to me that=
 you use
> your knowledge that TRACKINGID cannot be more than 59 (you use it to =
map the
> tracking ID onto the slot ID). Therefore, why change TRKID to a large=
r value?


There are only 60 slots available, but an infinite number of tracking i=
ds.
Nowhere is the tracking id assumed to be bounded by anything but MAX_TR=
KID.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
