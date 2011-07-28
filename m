From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 06/16] HID: wiimote: Enable accelerometer on request
Date: Thu, 28 Jul 2011 20:08:55 +0200
Message-ID: <201107282008.55404.oneukum@suse.de>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <1311869316-17128-7-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52241 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab1G1SOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:14:11 -0400
In-Reply-To: <1311869316-17128-7-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Donnerstag, 28. Juli 2011, 18:08:26 schrieb David Herrmann:
> The wiimote has an internal accelerometer which can report data to th=
e host.
> Userspace may now write to a new sysfs file to make the driver enable
> accelerometer reporting. This is not enabled by default to reduce pow=
er
> consumption of the wiimote. Accelerometer data is reported every few
> milliseconds and thus consumes much bluetooth bandwidth which costs m=
uch energy
> of the wiimote.
> By writing 0 to the sysfs file, accelerometer reporting is disabled a=
gain.

This is an odd interface. Why can't you request the accelerometer data =
when
a device file dedicated to the accelerometer is opened?

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
