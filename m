From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 0/4] hid-multitouch: a first step towards multitouch  unification
Date: Thu, 14 Oct 2010 00:41:55 +0200
Message-ID: <E8092693-D2F3-4544-A18E-C7F5DCD8507A@enac.fr>
References: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41601 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab0JMWmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:42:09 -0400
In-Reply-To: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org


Le 14 oct. 10 =E0 00:28, Stephane Chatty a =E9crit :

>
> St=E9phane Chatty (4):
>   hid-multitouch: support for PixCir-based panels in a generic code =20
> structure
>   hid-multitouch: migrated support for Cando panels
>   hid-multitouch: added support for Cypress TrueTouch panels
>   hid-multitouch: migrated support for MosArt panels

I forgot to mention that:
  - I am looking for testers for Quanta panels
  - I have code that works for the GeneralTouch panels found in some =20
recent tablets. But these panels appear to have the exact same device =20
ID as previously existing single touch panels, with a different =20
protocol. I am working on a solution to discriminate the two types of =20
panels.

St.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
