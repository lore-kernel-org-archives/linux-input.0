From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/6] elantech extend version support and add semi-mt
Date: Mon, 16 May 2011 13:15:52 +0200
Message-ID: <20110516111552.GA10453@polaris.bitmath.org>
References: <4DCE24BE.70908@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:51434 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab1EPLLZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 07:11:25 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 61AA1EA675
	for <linux-input@vger.kernel.org>; Mon, 16 May 2011 13:11:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DCE24BE.70908@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Hi =C9ric,

> Here is an update of patches which I had sent quite a few monthes
> ago. At this time they were a bit controversial because the hardware
> reports only the minimum/maximum positions when two fingers are
> pressed. With the "semi-mt" property from Henrik that should now be
> well handled.
>=20
> The first few patches of this set should also add support for a few
> more hardware versions. I could not test all the hardware versions
> but it's based on the old Dell/Ubuntu driver and if it goes into
> Linus's tree during the merge window I'm confident we can catch and
> easily fix regressions :-)

Excellent work, thank you so much. A couple of tiny tiny details:

[patch 1]

+In the wild, there appear to be more versions, such as 04.03.01, 04.04=
=2E11. There
+appear to be almost no difference excepted the EF113 which do not repo=
rt

no difference, except

[patch 3]

@@ -100,14 +100,22 @@ struct elantech_data {
        unsigned char reg_26;
        unsigned char debug;
        unsigned char capabilities;
-       bool paritycheck;
+       unsigned char paritycheck;
        bool jumpy_cursor;
+       unsigned char reports_pres :1;
        unsigned char hw_version;
        unsigned int fw_version;
        unsigned int single_finger_reports;
        unsigned char parity[256];
 };

Any particular reason to use unsigned char instead of bool here, and to
restrict report_pres to a single bit? Bool for both seems apt.

Other than the above, which do not really need a resend, feel free to a=
dd

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

on all six patches. Thank you, =C9ric.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
