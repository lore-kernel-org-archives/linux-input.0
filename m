From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: clean up quirk for Sony RF receivers
Date: Tue, 22 Jan 2013 11:08:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301221108090.20374@pobox.suse.cz>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>   <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>   <50F52986.2080002@lab.ntt.co.jp>   <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>   <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
  <50F637D1.8070302@lab.ntt.co.jp>   <alpine.LNX.2.00.1301161141250.14768@pobox.suse.cz>  <50FE2A34.3050607@lab.ntt.co.jp> <1358835638.6336.1.camel@nexus.lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40761 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab3AVKIW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 05:08:22 -0500
In-Reply-To: <1358835638.6336.1.camel@nexus.lab.ntt.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Tue, 22 Jan 2013, Fernando Luis V=C3=A1zquez Cao wrote:

> Document what the fix-up is does and make it more robust by ensuring
> that it is only applied to the USB interface that corresponds to the
> mouse (sony_report_fixup() is called once per interface during probin=
g).

Applied.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
