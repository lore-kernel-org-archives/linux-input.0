From: rydberg@euromail.se
Subject: [GIT PULL] input: mt updates for 3.11
Date: Thu, 27 Jun 2013 14:40:11 +0000
Message-ID: <20130627144011.GA553@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:41083 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab3F0PDK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 11:03:10 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b31.telenor.se (Postfix) with ESMTP id 283DA24211
	for <linux-input@vger.kernel.org>; Thu, 27 Jun 2013 16:40:12 +0200 (CEST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Please pull the for-next branch to receive a trivial MT documentation fix.

Thanks,
Henrik

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://github.com/rydberg/linux.git for-next

for you to fetch changes up to 257867dc8d893690c175c1f717f91c3b6d44a63d:

  Input: MT - Specify that ABS_MT_SLOT must have a minimum of 0 (2013-06-13 21:32:00 +0200)

----------------------------------------------------------------
Peter Hutterer (1):
      Input: MT - Specify that ABS_MT_SLOT must have a minimum of 0

 Documentation/input/multi-touch-protocol.txt | 2 ++
 1 file changed, 2 insertions(+)
