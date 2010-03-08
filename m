From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] USB: N-trig Finger Pen Multitouch fix
Date: Sun, 07 Mar 2010 20:41:38 -0500
Message-ID: <4B9455D2.7080502@seas.upenn.edu>
References: <48A28051AC6D7A48B64F28272458190301AF29@Exchange-IL.n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:36995 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0CHBlw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Mar 2010 20:41:52 -0500
In-Reply-To: <48A28051AC6D7A48B64F28272458190301AF29@Exchange-IL.n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Micki Balanga <micki@n-trig.com>
Cc: jkosina@suse.cz, chatty@enac.fr, peterhuewe@gmx.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One other note:

> +                                               input_report_abs(input,
> ABS_MT_TRACKING_ID, nt_rpt->finger_id);

I pulled the tracking id to conform to
	Documentation/input/multi-touch-protocol.txt
which states that unreliable tracking ids should not be passed to the user
space.  So unless you have done something to fix the broken tracking that I've
been seeing, we should leave it out for now.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkuUVdIACgkQwuRiAT9o608ymwCgpGXXnsWcEd2C+WaBxVpnla/e
xYgAoK68Yyvl2RLzqhWVGk9tKOFpsEwI
=O+8/
-----END PGP SIGNATURE-----
