From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Fri, 1 Oct 2010 15:36:08 +0200
Message-ID: <1412A8D8-6B7A-46AA-859A-A7CCFF1E2148@enac.fr>
References: <1284476919.3732.10.camel@PhEeeTab>   <4CA242B7.7020609@euromail.se>   <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>  <1285703702.1653.26.camel@PhEeeTab>  <A03B2B76-DA22-49AF-9484-4365BE6AB3D9@enac.fr> <alpine.LNX.2.00.1010011532130.29535@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:58391 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0JANg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Oct 2010 09:36:27 -0400
In-Reply-To: <alpine.LNX.2.00.1010011532130.29535@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Philipp Merkel <mail@philmerk.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>


Le 1 oct. 10 =E0 15:32, Jiri Kosina a =E9crit :

> On Tue, 28 Sep 2010, St=E9phane Chatty wrote:
>
>>>> By the way, since you apparently have access to a Joojoo and I did
>>>> not get any response from any Joojoo owner, can you tell us whethe=
r
>>>> it exhibits the bogus Xs and Ys that Philipp has observed? It woul=
d
>>>> be consistent with the range inconsistency that you have observed.
>>>
>>> As I wrote in my previous message (but was too slow and didn't read
>>> yours before sending it), the problem Henrik is describing sounds
>>> exactly like the one I experienced which is fixed by the three bit
>>> shift.
>>
>> Then we could take Philipp's fix for now, and start looking for a =20
>> way to
>> cross-test Henrik's proposal. Jiri, do you agree on this?
>
> Sounds reasonable to me. So can I add
>
> 	Acked-by: St=E9phane Chatty <chatty@enac.fr>
>
> to Philipp's patch?

=46ine by me. And Henrik's solution should come soon, from what I hear.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
