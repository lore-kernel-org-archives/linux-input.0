From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hidraw : free list for all error in hidraw_open
Date: Wed, 7 Sep 2011 13:50:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109071349510.13109@pobox.suse.cz>
References: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com> <CA+F9FsA=u6EtGkWO8PVfJ4voSx+=wvoFdZ_61WO6x=8WMFM0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57521 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757275Ab1IGWaP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Sep 2011 18:30:15 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 057668B45E
	for <linux-input@vger.kernel.org>; Thu,  8 Sep 2011 00:30:15 +0200 (CEST)
In-Reply-To: <CA+F9FsA=u6EtGkWO8PVfJ4voSx+=wvoFdZ_61WO6x=8WMFM0Rg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: Alan Ott <alan@signal11.us>

On Fri, 2 Sep 2011, Amit Nagal wrote:

> > In function hidraw_open (linux-3.0.3/drivers/hid/hidraw.c ) , =A0st=
ruct
> > hidraw_list *list should be freed for all error conditions .
>=20
> Due to tab to space conversion by gmail , i have enclosed patch as
> attachment currently .

Applied. But please fix your mail client for further submissions. Thank=
s,

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
