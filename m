From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: initializing reports
Date: Wed, 09 Mar 2011 21:29:00 -0500
Message-ID: <4D78376C.5040104@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:48171 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1CJC3F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 21:29:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Initializing reports is causing problems with the latest firmware that I've been
using.  At least one of the submit report calls is timing out, adding 10 seconds
to my boot and every time I load the reload the module.  And perhaps more
seriously merely prodding the feature reports alters the pen/touch mode of the
device and sometimes leave it in a non-functional state.

Should I just use HID_QUIRK_NO_INIT_REPORTS, or is it worth narrowing down the
blacklisted reports to leave untouched (such as the feature reports)?

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNeDdpAAoJEPILXytRLnK2Y1AP/1cc2oIUVZEMPZxTgfzg9DYN
gReoM7hG0EHDr37GXvL5I3ugVKIuVTezkYK8ZTP0aa7vKYykB33L5Bn4x0owmB8L
vxqgrA4E0AcgrXZEcESwUHFzrQ5LEpNvycn+mzVSMg/ZGgbkeN2XL7eG03mDPH9R
Z2AqN1XiVBwLLvFF6P7qiMuDrQ3z3IxslJDtbzvT29kNfaxkwDOoXEgxPeyPx1Vd
lx8RiERzYux7VDxXBdcDVZlS/LNEdIvzHnOW8nfgYksxB/kCve12lG5inn4d4GMx
qDF/lTopkUpldHDaizuOhda6PKj9UT1NLYc1QVcGV9/JPgl0tFUtJ4BpSIAz+zJY
8RqfOs7bYrn87GBOBSCgqJ54ybBhMQM2UZEVS7mxI5s0Rv6WBzJbkeop3pIMDxwI
LkJGY0BdPHL//DhiZ7YdfgM8kLTKjTLaIDidHMOJFkOQNukBKQAP89nM1IM8a8TQ
s2MEXGzcyn2oN23xgzXm9Ilm25KsNCQfTCakqL14SZIv9nB5dLY6V3Jr24MshvqB
+sAuG/SuYVpwMpjhjbzwEdZWStSM/1hve7XJScybj9RKsqnODrWOwRuaeyMwLZQc
Q87XExghR3nazFfaR6xJMOUoQRvdUgU2BwnqlgSBHKlbTAHwpVVvBGdYqEjUDUqc
QNG71I75FhL1UKm9KmOo
=bFEF
-----END PGP SIGNATURE-----
