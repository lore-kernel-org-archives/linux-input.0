From: simon.budig@kernelconcepts.de
Subject: [PATCH v4] Touchscreen driver for FT5x06 based EDT displays
Date: Tue,  6 Mar 2012 17:15:26 +0100
Message-ID: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:50786 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487Ab2CFQXw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 11:23:52 -0500
In-Reply-To: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, agust@denx.de, yanok@emcraft.com, b.van.den.berg.nl@gmail.com

Hi all.

Here is a new iteration of the EDT polytouch driver. Compared to v3 it fixes
some of the interrupt handling and adds support for the report rate setting.

Please give feedback on problems or on further plans for inclusion into
mainline.

Thanks,
        Simon

