From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Patch for multitouch in include/linux/hid.h
Date: Wed, 13 Jan 2010 00:26:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001130025570.30977@pobox.suse.cz>
References: <E152F1B0-A2E9-4787-8D8D-9CE24CB86A9A@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52758 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527Ab0ALX0T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 18:26:19 -0500
In-Reply-To: <E152F1B0-A2E9-4787-8D8D-9CE24CB86A9A@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org

On Sun, 10 Jan 2010, St=E9phane Chatty wrote:

> I discovered I might have left a minor mistake in the Stantum driver =
I sent
> you, and I directly checked in your for-next tree. It happens that th=
e mistake
> is there, and I'll work on a patch.
>=20
> While checking, I found that you have applied PATCH 2/2, but not PATC=
H 1/2.
> Remember, I had forgotten to Cc you when I submitted my patches and y=
ou found
> out about the second later; you probably haven't seen the first. The =
point is
> that this PATCH 1/2 is in include/linux/hid.h and, as we discussed mo=
nths ago,
> it might have consequences on other devices: it consists in changing =
the end
> of IS_INPUT_APPLICATION so that digitizer usages up to 0x0006 are con=
sidered
> as input applications. Could you have a look at it? Otherwise, the 3M=
, Stantum
> and Acer code will not be called by the HID core.

Hi Stephane,

could you please bounce/forward the mail with patch to me?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
