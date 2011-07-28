From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 03/16] HID: wiimote: Add drm request
Date: Thu, 28 Jul 2011 20:05:40 +0200
Message-ID: <201107282005.40226.oneukum@suse.de>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <1311869316-17128-4-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52239 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab1G1SOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:14:11 -0400
In-Reply-To: <1311869316-17128-4-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Donnerstag, 28. Juli 2011, 18:08:23 schrieb David Herrmann:
> +static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
> +{
> +       __u8 cmd[3];

Are you sure these buffers nned not be safe for DMA?

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
