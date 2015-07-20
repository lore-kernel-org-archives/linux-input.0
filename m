From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 0/4 v2] Input: zforce - update interrupt handling
Date: Mon, 20 Jul 2015 14:56:33 +0200
Message-ID: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30545 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbGTM4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:56:41 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 32074158022A
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:40 +0200 (CEST)
Received: from SI-HUB1001.de.bosch.com (vsgw21.fe.internet.bosch.com [10.4.98.19])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id A8C66A40552
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:56:39 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>

This is version 2 of the previous sent zforce interrupt patches.

Patch #1 and #2 are new: Patch #1 fixes an issue found while implementing
patch #3. Patch #2 is just a preparation for #3.

Patch #3 implements the review comments of the first version of this
patch about not dropping the interrupt GPIO completely, but making it
optional.

Patch #4 is unchanged compared to the first version and is still under
discussion in

http://article.gmane.org/gmane.linux.kernel.input/44580

It's sent here for completeness and can be handled later depending on the
outcome of the discussion

Best regards

Dirk
