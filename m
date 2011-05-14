From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 0/6] elantech extend version support and add semi-mt
Date: Sat, 14 May 2011 08:44:14 +0200
Message-ID: <4DCE24BE.70908@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:35154 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Hello,

Here is an update of patches which I had sent quite a few monthes ago.=20
At this time they were a bit controversial because the hardware reports=
=20
only the minimum/maximum positions when two fingers are pressed. With=20
the "semi-mt" property from Henrik that should now be well handled.

The first few patches of this set should also add support for a few mor=
e=20
hardware versions. I could not test all the hardware versions but it's=20
based on the old Dell/Ubuntu driver and if it goes into Linus's tree=20
during the merge window I'm confident we can catch and easily fix=20
regressions :-)

Cheers,
=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
