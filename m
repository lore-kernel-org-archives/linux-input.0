From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Thu, 16 Jun 2011 12:18:55 +0200
Message-ID: <201106161218.55279.oneukum@suse.de>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <201106150834.16081.oliver@neukum.org> <alpine.LNX.2.00.1106161119280.22872@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab1FPKQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 06:16:40 -0400
In-Reply-To: <alpine.LNX.2.00.1106161119280.22872@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org, padovan@profusion.mobi

Am Donnerstag, 16. Juni 2011, 11:20:18 schrieb Jiri Kosina:
> > Here an smp_wmb()
> > It is redundant because input_register_device takes a spinlock whic=
h
> > implies a barrier, but you'll make the automated checking tools hap=
pier. =20
>=20
> Yeah, spinlock implies SMP barrier implicitly.
>=20
> I don't think adding barriers just to make some buggy automatic check=
er=20
> happy is worth it.

=46ine by me as long as the problem is understood.

	Regards
		Oliver

--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
