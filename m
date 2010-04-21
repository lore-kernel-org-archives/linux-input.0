From: Jian-feng Ding <jian-feng.ding@intel.com>
Subject: some questions about Synaptics Clickpad driver patch
Date: Wed, 21 Apr 2010 16:40:58 +0800
Message-ID: <20100421084058.GS15241@djf-karmic.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1473 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab0DUIiv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 04:38:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: tiwai@suse.de
Cc: linux-input@vger.kernel.org

Hi IWai,

  I am from MeeGo team of Intel, and being to enable the clickpad in HP Mini210 netbook by applying your great patch.
  I have tried the old copy from: https://patchwork.kernel.org/patch/67335/ , it just worked fine for both
  left/mid/right clicks. And today, I noticed your patch has been integrated to dtor's input subsys git tree as the
  commit: 5f57d67da87332a9a1ba8fa7a33bf0680e1c76e7
    http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=5f57d67da87332a9a1ba8fa7a33bf0680e1c76e7

  It seems the latest copy, right?
  I noticed you have removed the code for left/mid/right clicks diffenrentiation, and only export left clicks events
  to user level. In the commit comment, you mentioned:

    The kernel driver morphs to the left button. The real handling of Clickpad is done rather in X driver side.

  Did you mean the left/mid/right clicks differentiation should be done in x.org input drv? If so, would you give
  me some clues for it?

  Thanks!

- jf.ding
 
