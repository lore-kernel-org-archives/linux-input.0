From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/3] input: wacom: Initial support for Bamboo
Date: Thu,  2 Sep 2010 20:18:34 +0200
Message-ID: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59761 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab0IBSTB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 14:19:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

What was initially one patch has now grown to three, to better accomodate
the comments received on the initial patch.

The first patch extends the feature struct to better deal with fuzz
and devices of low resolution. The second patch brings in code from
the wacom project, preparing for the whole Bamboo family (somebody
else should be the author on that one). The third patch is the second
revision of the Bamboo Touch patch, hopefully taking all the comments
into account.

Ideally, Chris should be able to build on this patchset, adding
support for the rest of the Bamboo tablets.

Cheers,
Henrik

Henrik Rydberg (3):
  input: wacom: Add fuzz and scale features
  input: wacom: Parse the Bamboo device family
  input: wacom: Add support for the Bamboo Touch trackpad (rev2)

 drivers/input/tablet/wacom_sys.c |   62 +++++++++++++++++++++----
 drivers/input/tablet/wacom_wac.c |   92 ++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |   11 +++++
 3 files changed, 152 insertions(+), 13 deletions(-)

