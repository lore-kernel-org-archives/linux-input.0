From: Andy Ross <andy@windriver.com>
Subject: [PATCH 0/3] Pegatron Lucid tablet accelerometer
Date: Fri, 14 Jan 2011 12:14:08 -0800
Message-ID: <1295036050-10553-1-git-send-email-andy@windriver.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:36106 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab1ANUOM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Jan 2011 15:14:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

Driver for the ACPI interface to the accelerometer on the Pegatron
Lucid tablets (sold as WeTab and ExoPC).  I put detection into
asus-laptop, as that seems to be the owner of the "\_SB.ATKD." space
in ACPI.  Hopefully that's the right choice.

Andy


