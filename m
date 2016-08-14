From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 0/3] Remove usages of deprecated create_singlethread_workqueue
Date: Sun, 14 Aug 2016 10:49:55 +0530
Message-ID: <cover.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33233 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbcHNJ1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2016 05:27:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch set removes the instances of deprecated
create_singlethread_workqueue (scheduled for removal) in drivers/input
by making the appropriate conversions.

Bhaktipriya Shridhar (3):
  Input: psmouse: Remove deprecated create_singletheread_workqueue
  Input: touchscreen: mc13783_ts:  Remove deprecated
    create_singletheread_workqueue
  Input: wm97xx: Remove deprecated create_singletheread_workqueue

 drivers/input/mouse/psmouse-base.c      |  2 +-
 drivers/input/touchscreen/mc13783_ts.c  | 19 ++++---------------
 drivers/input/touchscreen/wm97xx-core.c |  2 +-
 3 files changed, 6 insertions(+), 17 deletions(-)

--
2.1.4

