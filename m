From: JJ Ding <jj_ding@emc.com.tw>
Subject: Question about pass-through serio
Date: Tue, 20 Sep 2011 15:06:59 +0800
Message-ID: <87wrd3pu98.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:15925 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1ITHEO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 03:04:14 -0400
Received: from localhost ([192.168.81.59])
	by emc.com.tw (8.13.7+Sun/8.13.7) with ESMTP id p8K74D9T000079
	for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 15:04:13 +0800 (CST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi everyone,

I am trying to understand how serio works in Linux. When reading
drivers/input/mouse/synaptics.c I found a special serio type:
SERIO_PS_PSTHRU. I git-grep the source tree and it seems synaptics
driver is the only user of the type. I cannot find any detailed docs
explaining why the synaptics driver needs this, and what's the
difference between this pass-through serio and psmouse->ps2dev.serio.

Can anyone help me with this? Any pointer or keyword is very much
appreciated. Thank you very much.

jj
