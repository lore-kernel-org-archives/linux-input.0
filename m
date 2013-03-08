From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/4] Input: wm97xx: Fix handling of wrong readings
Date: Fri,  8 Mar 2013 17:15:05 +0100
Message-ID: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55033 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093Ab3CHQRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Mar 2013 11:17:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de

Hi,

the series adds/fixes some handling for wrong readings of penup/down
and out of screen readings. Those wrong readings had a big impact on
the usability in my tests.

Regards,

Markus

