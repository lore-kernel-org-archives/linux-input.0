From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: Sitronix ST9RM01 multitouch panel
Date: Tue, 28 Sep 2010 19:50:41 +0200
Message-ID: <E8E47989-5040-4B4C-9955-5B48A5CA2073@enac.fr>
References: <20100928093949.26553.55566.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:45617 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451Ab0I1Ruw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 13:50:52 -0400
In-Reply-To: <20100928093949.26553.55566.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Gowri Ries - Stantum <G.Ries@stantum.com>, Henrik Rydberg <rydberg@euromail.se>


Le 28 sept. 10 =E0 11:40, Alan Cox a =E9crit :

> From: Rudy Huang <rudy_huang@sitronix.com.tw>
>
> USB HID support for the Sitronix ST9RM01 multi-touch panel as an inpu=
t
> device.
>

The Sitronix ST9RM01 appears to be based on Stantum's design and =20
firmware (see http://www.stantum.com/en/supply-chain/icdesigners/=20
Sitronix). Actually, the submitted driver still contains an error =20
message from the original hid-stantum.c :-) Are there differences =20
that force the creation of a new driver?

Cheers,

St.--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
