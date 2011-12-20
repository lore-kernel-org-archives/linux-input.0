From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Tue, 20 Dec 2011 11:18:24 +0100
Message-ID: <201112201118.24342.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <201112151001.52761.oneukum@suse.de> <CAGS+omCLU6FAxmT3+TgYf0b8YvgfbH9CL9M6WpZ0yNS01O5Hrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42720 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab1LTKQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 05:16:51 -0500
In-Reply-To: <CAGS+omCLU6FAxmT3+TgYf0b8YvgfbH9CL9M6WpZ0yNS01O5Hrw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Am Dienstag, 20. Dezember 2011, 11:12:37 schrieb Daniel Kurtz:
> > > Could you please be more specific about what this patch breaks an=
d
> > > perhaps give some guidance on how to fix it?
> >
> > It breaks nothing. It just continues a bug and I assumed it was not=
 present.
> > Basically the work queue must do nothing after pre_reset() and post=
_reset()
> > ought to rerun the work in case some request came down during that =
time.
>=20
> So, is this an Ack for this patchset?
> Can we fix any existing races in later patches?

Very well. You are fixing a bad bug and not making matters worse.

Acked-by: Oliver Neukum <oneukum@suse.de>

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
