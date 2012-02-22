From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH 0/5] Input: sentelic - multiple finger output support
Date: Wed, 22 Feb 2012 21:52:32 +0800
Message-ID: <1329918757-16128-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:16234 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2BVNxL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 08:53:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tai-hwa Liang <avatar@sentelic.com>

Hi,

This patch set (against for-linus) is intended to add support for newer
Sentelic FSP(hardware revision Cx/Dx).  The relative coordinates output
mode is retained for supporting older hardware(prior to Cx release).

Tai-hwa Liang (5):
  Input: sentelic - code refactorying for upcoming new hardware support
  Input: sentelic - enabling absolute coordinates output for newer
    hardware
  Input: sentelic - enabling hardware supported gesture ID output
  Input: sentelic - minor code cleaning up
  Input: sentelic: improving packet debugging information

 drivers/input/mouse/sentelic.c |  291 ++++++++++++++++++++++++++++++++-------
 drivers/input/mouse/sentelic.h |  108 +++++++++++++++-
 2 files changed, 344 insertions(+), 55 deletions(-)

-- 
1.7.9

