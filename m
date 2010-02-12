From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 19:37:39 -0500
Message-ID: <4B74A2D3.60208@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:50787 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757643Ab0BLAhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 19:37:46 -0500
In-Reply-To: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch set is a rethinking of my earlier mess.  I've broken it down into 4 conceptual steps, and a little extra which I've left
off for now.

The first three are basically clean up from the not handling the input devices correctly and leaving them a multiplexed stream.  In
userspace the only changes should be the need to open different devices and the loss of unnecessary events that indicated which
sensor a point came from.

The fourth adds the missing contact id event and implements basic finger tracking.  Stephane's code did send tracking id's, but it
was masked off.  The benefits of finger tracking should be pretty clear.  The most recent firmware seems to sort contacts by Y position.


Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt0otAACgkQwuRiAT9o6098XgCg8P+m7mf4PT5ufZ0tsmsNd4av
ehoAoPXbgcm9zFOS4EpTZe5BPi3euzNN
=jCM6
-----END PGP SIGNATURE-----
