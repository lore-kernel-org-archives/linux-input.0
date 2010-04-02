From: david@hardeman.nu
Subject: [patch 0/3] ir-core keytable patches
Date: Fri, 02 Apr 2010 20:58:27 +0200
Message-ID: <20100402185827.425741206@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:49045 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab0DBTC7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Apr 2010 15:02:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mchehab@infradead.org
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

The following patchset provides a number of bug fixes and additional
features to ir-core in drivers/media/IR.

The first two patches are mostly cleanups to drivers/media/IR/ir-keytab=
le.c
while the third patch is an example of a conversion of
drivers/media/dvb/ttpci/budget-ci.c to use the new functionality (rathe=
r
than the drivers/media/IR/ir-functions.c functionality).

--=20
David H=C3=A4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
