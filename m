From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Tue, 08 May 2012 11:50:23 -0700
Message-ID: <4FA96AEF.4090106@zytor.com>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se> <4FA5889E.2030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59606 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab2EHSuu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 May 2012 14:50:50 -0400
In-Reply-To: <4FA5889E.2030008@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, benjamin.tissoires@gmail.com, peter.hutterer@who-t.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/05/2012 01:07 PM, Chase Douglas wrote:
>> =20
>> +For devices capable of 360 degree orientation, the reported orienta=
tion
>> +should be twice the given range.
>=20
> I don't understand what this means. Can you elaborate?
>=20

A guess is that it means that the value is encoded as a single byte wit=
h
a 2=C2=B0 granuarity?

	-hpa

--=20
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
