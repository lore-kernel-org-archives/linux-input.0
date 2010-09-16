From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 3/4] Input: ads7846 - restore ADC to powerdown mode if no messgaes needed
Date: Thu, 16 Sep 2010 18:51:25 +0800
Message-ID: <1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-2-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-3-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38248 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab0IPKr6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 06:47:58 -0400
In-Reply-To: <1284634286-8871-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

When the ADC get wrong datas and have to ignore remaining messages in
a transfer turn, we should set ADC to powerdown mode instead of
leaving it at previous operation mode, otherwise we can't get the
correct pendown state and the irq will not trigger any more.

After the last message is transfered, we should add msg_idx to let
the code to skip out the loop.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5ddaeea..eab8b0b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -729,7 +729,8 @@ static void ads7846_read_state(struct ads7846 *ts)
 
 			case ADS7846_FILTER_IGNORE:
 				packet->tc.ignore = true;
-				return;
+				msg_idx = ts->msg_count - 1;
+				continue;
 
 			case ADS7846_FILTER_OK:
 				ads7846_update_value(m, val);
@@ -740,6 +741,8 @@ static void ads7846_read_state(struct ads7846 *ts)
 			default:
 				BUG();
 			}
+		} else {
+			msg_idx++;
 		}
 	}
 }
-- 
1.5.6.5

