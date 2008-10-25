From: Andreas Schwab <schwab@suse.de>
Subject: appletouch driver broken
Date: Sat, 25 Oct 2008 23:11:47 +0200
Message-ID: <je7i7wmlbg.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42768 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYJYVLt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Oct 2008 17:11:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org

Commit c500c9714011edab021591340042787722db9cf0 ("HID: hid, make parsin=
g
event driven") broke the appletouch driver on iBook G4: the module is n=
o
longer autoloaded, and manual loading does not make it work either
(atp_probe is never called).

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
