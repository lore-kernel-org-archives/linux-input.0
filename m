From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 06/16] HID: wiimote: Enable accelerometer on request
Date: Thu, 28 Jul 2011 21:32:46 +0200
Message-ID: <201107282132.46764.oneukum@suse.de>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <201107282008.55404.oneukum@suse.de> <CANq1E4SL1JVLw4F2pffoZtZSaskNbNkhW-1cVGgnPr02--J+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57279 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab1G1T37 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 15:29:59 -0400
In-Reply-To: <CANq1E4SL1JVLw4F2pffoZtZSaskNbNkhW-1cVGgnPr02--J+uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Donnerstag, 28. Juli 2011, 21:01:34 schrieb David Herrmann:
> I can see the problem with my approach. If multiple applications use
> the wiimote and one disables the accelerometer, then the other
> application has it also disabled. However, what other API would be
> more appropriate here?

So arguments can be seen for both. I suggest you ask this question
specifically on the lists before you introduce an API here.

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
