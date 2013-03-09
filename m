From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 0/4] Input: wm97xx: Fix handling of wrong readings
Date: Sat,  9 Mar 2013 18:05:49 +0100
Message-ID: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36622 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3CIRHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Mar 2013 12:07:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de

Hi,

the series adds/fixes some handling for wrong readings of penup/down
and out of screen readings. Those wrong readings had a big impact on
the usability in my tests.

Changes in v2:
- Fixed style of multiline condition in patch 1


Regards,

Markus

