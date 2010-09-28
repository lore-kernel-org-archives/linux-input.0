From: Philipp Merkel <mail@philmerk.de>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 28 Sep 2010 21:55:02 +0200
Message-ID: <1285703702.1653.26.camel@PhEeeTab>
References: <1284476919.3732.10.camel@PhEeeTab>
	 <4CA242B7.7020609@euromail.se>
	 <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.planet-school.de ([194.116.187.5]:59273 "EHLO
	turboconrad.planet-school.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754908Ab0I1TzF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:55:05 -0400
In-Reply-To: <D12492C5-2961-4C27-887B-E2FD31F70034@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

St=C3=A9phane Chatty wrote:
> By the way, since you apparently have access to a Joojoo and I did =20
> not get any response from any Joojoo owner, can you tell us whether =20
> it exhibits the bogus Xs and Ys that Philipp has observed? It would =20
> be consistent with the range inconsistency that you have observed.

As I wrote in my previous message (but was too slow and didn't read
yours before sending it), the problem Henrik is describing sounds
exactly like the one I experienced which is fixed by the three bit
shift.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
