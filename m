From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fixed bug in single-touch emulation on the Stantum panel
Date: Tue, 9 Feb 2010 15:59:34 +0100
Message-ID: <878D4FFC-9FA8-4A20-90D9-06BFBAE63658@enac.fr>
References: <20100206141912.71BA89520A@smtp.lii-enac.fr> <alpine.LNX.2.00.1002091125490.30967@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:52416 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0BIO7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 09:59:43 -0500
In-Reply-To: <alpine.LNX.2.00.1002091125490.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org


Le 9 f=E9vr. 10 =E0 11:27, Jiri Kosina a =E9crit :

> On Sat, 6 Feb 2010, Stephane Chatty wrote:
>
>> Fixed bug in touchscreen emulation for the Stantum multitouch panel
>
> Hi Stephane,
>
> could you please perhaps provide a little bit more detailed =20
> information
> about the nature of the bug this is fixing? It might be useful for =20
> people
> looking through changelog.

=46ixed stupid copy-paste bug in touchscreen emulation for the Stantum =
=20
multitouch panel: a flag was reset just before being tested.

>>
>
> Are you planning to maintain this numbering, btw? Usually people =20
> forget to
> update it :)

As a user I find it useful. As a coder I usually maintain them. But I =20
was wondering what was going to happen if other people were to submit =20
patches on the code; in that case, and if they don't update the =20
number I guess having a version number is a bad idea.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
