From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?=
	<francois.valenduc@tvcablenet.be>
Subject: Logitech mouse not detected with kernel 3.5-rc2
Date: Tue, 19 Jun 2012 22:16:43 +0200
Message-ID: <4FE0DE2B.3010708@tvcablenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mirapoint3.brutele.be ([212.68.199.148]:16967 "EHLO
	mirapoint3.brutele.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab2FSUWt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jun 2012 16:22:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everybody,

I have a logitech M195 mouse and it doesn't work with kernel 3.5-rc2. A
bisection leads to this commit:

commit 8215d557e5f3a70e50e07c857d35c250fee62a73
Author: Henrik Rydberg <rydberg@euromail.se>
Date:   Mon Apr 23 12:07:07 2012 +0200

    HID: Create a common generic driver

Indeed, reverting it allows my mouse to work correctly. I created a bug
report on https://bugzilla.kernel.org/show_bug.cgi?id=3D43531 but nobod=
y
has seems to look at it yet.

Can somebody explain what is happening ?
Thanks for your help.

=46ran=E7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
