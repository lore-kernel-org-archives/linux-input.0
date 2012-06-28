From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 05/23 v6] Input: atmel_mxt_ts - don't read T5 when dumping objects
Date: Thu, 28 Jun 2012 21:08:06 +0800
Message-ID: <1340888904-15620-6-git-send-email-djkurtz@chromium.org>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

T5 is the message processor object.  Reading it will only have two
outcomes, neither of which is particularly useful:
 1) the message count decrements, and a valid message will be lost
 2) an invalid message will be read (reportid == 0xff)

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c72f595..9f8dd97 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -263,7 +263,6 @@ struct mxt_data {
 static bool mxt_object_readable(unsigned int type)
 {
 	switch (type) {
-	case MXT_GEN_MESSAGE_T5:
 	case MXT_GEN_COMMAND_T6:
 	case MXT_GEN_POWER_T7:
 	case MXT_GEN_ACQUIRE_T8:
-- 
1.7.7.3
