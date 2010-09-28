From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 28 Sep 2010 22:14:24 +0200
Message-ID: <A03B2B76-DA22-49AF-9484-4365BE6AB3D9@enac.fr>
References: <1284476919.3732.10.camel@PhEeeTab>  <4CA242B7.7020609@euromail.se>  <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr> <1285703702.1653.26.camel@PhEeeTab>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:53609 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab0I1UOf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 16:14:35 -0400
In-Reply-To: <1285703702.1653.26.camel@PhEeeTab>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Merkel <mail@philmerk.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>


Le 28 sept. 10 =E0 21:55, Philipp Merkel a =E9crit :

> St=E9phane Chatty wrote:
>> By the way, since you apparently have access to a Joojoo and I did
>> not get any response from any Joojoo owner, can you tell us whether
>> it exhibits the bogus Xs and Ys that Philipp has observed? It would
>> be consistent with the range inconsistency that you have observed.
>
> As I wrote in my previous message (but was too slow and didn't read
> yours before sending it), the problem Henrik is describing sounds
> exactly like the one I experienced which is fixed by the three bit
> shift.

Then we could take Philipp's fix for now, and start looking for a way =20
to cross-test Henrik's proposal. Jiri, do you agree on this?

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
