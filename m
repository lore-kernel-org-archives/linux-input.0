From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH v2] Input: mousedev - fix implicit conversion warning
Date: Fri, 26 May 2017 08:34:27 -0700
Message-ID: <20170526153427.7830-1-nick.desaulniers@gmail.com>
References: <20170526052217.30624-1-nick.desaulniers@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33224 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967805AbdEZPeq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 May 2017 11:34:46 -0400
In-Reply-To: <20170526052217.30624-1-nick.desaulniers@gmail.com>
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

the value 200 is a valid sample rate. Using unsigned char, rather than
signed char, for client->ps2 silences this warning.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
* Changed from using an explicit cast to changing the signedness
  of the declaration.

 drivers/input/mousedev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 0e0ff84088fd..c83688eb2ef4 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -103,7 +103,7 @@ struct mousedev_client {
 	spinlock_t packet_lock;
 	int pos_x, pos_y;
 
-	signed char ps2[6];
+	unsigned char ps2[6];
 	unsigned char ready, buffer, bufsiz;
 	unsigned char imexseq, impsseq;
 	enum mousedev_emul mode;
-- 
2.11.0

