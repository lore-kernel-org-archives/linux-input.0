From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH] Input: mousedev - fix implicit conversion warning
Date: Thu, 25 May 2017 22:22:16 -0700
Message-ID: <20170526052217.30624-1-nick.desaulniers@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36330 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163496AbdEZFWo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 May 2017 01:22:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Nick Desaulniers <nick.desaulniers@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Clang warns:

drivers/input/mousedev.c:653:63: error: implicit conversion from 'int'
to 'signed char' changes value from 200 to -56
[-Wconstant-conversion]
  client->ps2[1] = 0x60; client->ps2[2] = 3; client->ps2[3] = 200;
                                                            ~ ^~~

As far as I can tell, from

http://www.computer-engineering.org/ps2mouse/

Under "Command Set" > "0xE9 (Status Request)"

the value 200 is a valid sample rate. An explicit cast silences this
warning.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 drivers/input/mousedev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 0e0ff84088fd..816e2431bba8 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -650,7 +650,9 @@ static void mousedev_generate_response(struct mousedev_client *client,
 		break;
 
 	case 0xe9: /* Get info */
-		client->ps2[1] = 0x60; client->ps2[2] = 3; client->ps2[3] = 200;
+		client->ps2[1] = 0x60;
+		client->ps2[2] = 3;
+		client->ps2[3] = (char) 200;
 		client->bufsiz = 4;
 		break;
 
-- 
2.11.0

