From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/5] input: wacom: Initial support for Bamboo (rev2)
Date: Fri,  3 Sep 2010 14:17:22 +0200
Message-ID: <1283516247-11624-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:54949 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757903Ab0ICMSE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Sep 2010 08:18:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

This the third iteration of the Bamboo patches, two more this time.
The first three patches accomodate comments from Ping and Dmitry.  The
fourth patch introduces quirks for special behaviors, and the last
patch makes the bamboo touch motion appear a bit smoother.

Cheers,
Henrik

Henrik Rydberg (4):
  input: wacom: Add fuzz parameters to features
  input: wacom: Add support for the Bamboo Touch trackpad (rev3)
  input: wacom: Collect device quirks into single function
  input: wacom: Add a quirk for lowres Bamboo devices

Ping Cheng (1):
  input: wacom: Parse the Bamboo device family

 drivers/input/tablet/wacom.h     |    1 +
 drivers/input/tablet/wacom_sys.c |   57 +++++++++++++-----
 drivers/input/tablet/wacom_wac.c |  122 +++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |   14 ++++
 4 files changed, 175 insertions(+), 19 deletions(-)
