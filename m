From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: make USB device id constant
Date: Tue, 12 Jan 2010 14:30:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001121430250.30977@pobox.suse.cz>
References: <4B4A076A.8020207@freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34087 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0ALNai (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2010 08:30:38 -0500
In-Reply-To: <4B4A076A.8020207@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, cocci@diku.dk

On Sun, 10 Jan 2010, N=C3=A9meth M=C3=A1rton wrote:

> From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
>=20
> The id_table field of the struct usb_device_id is constant in <linux/=
usb.h>
> so it is worth to make the initialization data also constant.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
