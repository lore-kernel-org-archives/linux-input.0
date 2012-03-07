From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 3.4-rc0
Date: Wed, 7 Mar 2012 11:24:12 +0100
Message-ID: <20120307102412.GA6112@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:33564 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab2CGKXD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 05:23:03 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id CA7C9DE5E
	for <linux-input@vger.kernel.org>; Wed,  7 Mar 2012 11:23:00 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Here are the input-mt updates for 3.4-rc0, mainly introducing the MT
slots ioctl. All patches have been in linux-next for the past three
weeks.

Thanks,
Henrik

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:

  git@github.com:rydberg/linux.git for-next

for you to fetch changes up to 7491f3dffd99fadf1239011c0ab5346925618dae:

  bcm5974: Add pointer and buttonpad properties (2012-02-14 19:35:36 +0100)

----------------------------------------------------------------
Chase Douglas (1):
      bcm5974: Add pointer and buttonpad properties

Henrik Rydberg (2):
      Input: Use accessor for MT values
      Input: Add EVIOC mechanism for MT slots

 drivers/input/evdev.c         |   27 ++++++++++++++++++++++++++-
 drivers/input/input.c         |    2 +-
 drivers/input/mouse/bcm5974.c |    1 +
 include/linux/input.h         |   25 +++++++++++++++++++++++++
 include/linux/input/mt.h      |    8 ++++++--
 5 files changed, 59 insertions(+), 4 deletions(-)
