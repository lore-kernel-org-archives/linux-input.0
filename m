From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] elantech: Add support for IC-body version 8
Date: Mon,  9 Dec 2013 15:32:31 +0100
Message-ID: <1386599551-2339-2-git-send-email-hdegoede@redhat.com>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760906Ab3LIOci (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 09:32:38 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB9EWbGm032752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-input@vger.kernel.org>; Mon, 9 Dec 2013 09:32:38 -0500
In-Reply-To: <1386599551-2339-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Hans de Goede <hdegoede@redhat.com>

Acording to: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1232877
a patch for this has been send before, but I don't see this in 3.13-rc3,
so here is another one.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index f7baa32..fc72446 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1350,6 +1350,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 			break;
 		case 6:
 		case 7:
+		case 8:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
1.8.4.2

