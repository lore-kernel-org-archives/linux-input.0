From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in  JooJoo tablet
Date: Thu, 19 Aug 2010 23:45:42 +0200
Message-ID: <C7CA092C-6BDD-4457-B800-606FF4C2DC9D@enac.fr>
References: <4C695985.5080403@bitmath.org>  <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr> <4C6A5CB2.6000603@bitmath.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:47202 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0HSVpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Aug 2010 17:45:49 -0400
In-Reply-To: <4C6A5CB2.6000603@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input <linux-input@vger.kernel.org>


Le 17 ao=FBt 10 =E0 11:56, Henrik Rydberg a =E9crit :

>
> Ah yes, the pointer emulation via ABS_X/Y. My personal view is that =20
> pointer
> emulation is a gesture, and thus best implemented in userspace.

I agree 100% with you on this (well, I'd rather say that gestures and =20
single touch emulation are two cases of input interpretation, but =20
that's just my academical bias).

However this issue was discussed last year on this list and as far as =20
I understood it was decided that single touch emulation was required =20
in the kernel for some time...

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
