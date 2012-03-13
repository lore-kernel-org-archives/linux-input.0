From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Tue, 13 Mar 2012 15:54:07 +0100
Message-ID: <201203131554.07880.oneukum@suse.de>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com> <20120313143958.GA2754@polaris.bitmath.org> <20120313144941.GA13637@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46272 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab2CMOyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 10:54:10 -0400
In-Reply-To: <20120313144941.GA13637@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrik Rydberg <rydberg@bitmath.se>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Dienstag, 13. M=E4rz 2012, 15:49:41 schrieb Matthew Garrett:
> > Last time I checked, it seemed the first keystroke would sometimes
> > disappear at boot. As far as I can see, this version modifies the
> > needs_remote_wakeup variable to only be true while open, which migh=
t
> > remove that particular problem.
>=20
> I haven't seen any lost keystrokes.

Hi,

I have seen keyboards that lost keystrokes on UHCI but not on OHCI
and other strange things. Unfortunately such patches are very hard
to test.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
