From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Touchpad on Dell Latitude XT (alps 73 00 14)
Date: Fri, 09 Jan 2009 18:51:51 -0500
Message-ID: <4967E317.6040407@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:48501 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759616AbZAIX7P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 18:59:15 -0500
Received: from [158.130.62.219] (rafi@log.seas.UPENN.EDU [158.130.62.219])
	(authenticated bits=0)
	by stag.seas.upenn.edu (8.13.6/8.13.6) with ESMTP id n09Npp4o011480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 9 Jan 2009 18:51:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My touchpad has the id 73,00,14 which I added to alps.c as
{ { 0x73, 0x00, 0x14 }, 0xf8, 0xf8, 0 }

How can I determine what values to use for those last three fields?

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkln4xcACgkQwuRiAT9o608/vQCfeBCfi72Q++3SfTABCOROxvCN
ZHEAoKslCUY5ti7+rz9zQXqzP0Id+Jik
=stuZ
-----END PGP SIGNATURE-----
