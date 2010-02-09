From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] Fixed bug in single-touch emulation on the Stantum  panel
Date: Tue, 9 Feb 2010 18:05:21 +0100
Message-ID: <51CE0FF9-9B5D-4AEC-A5D7-882AE79CB194@enac.fr>
References: <20100206141912.71BA89520A@smtp.lii-enac.fr> <alpine.LNX.2.00.1002091633250.30967@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:55196 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab0BIRF0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 12:05:26 -0500
In-Reply-To: <alpine.LNX.2.00.1002091633250.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org


Le 9 f=E9vr. 10 =E0 16:34, Jiri Kosina a =E9crit :

>
> It doesn't apply to the driver I have in the tree. That claims to be
> version 0.6, and it doesn't contain this bug.

Obviously I got the version number wrong when I submitted the driver =20
(was 0.6, should have been 1.00). But the bug is there alright: when =20
I look at the code in your 'for-next' branch, sd->first is reset at =20
line 150 when it should be reset at line 160 or 161.


> Perhaps you forgot to submit a patch refreshing the driver to newer
> version (or perhaps I have missed it?).

I guess I just ticked the version number to 1.00 *after* submitting =20
the driver instead of doing it before. Sorry for the confusion.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
