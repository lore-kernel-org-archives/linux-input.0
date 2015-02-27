From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ALPS - fix memory leak when detection fails
Date: Fri, 27 Feb 2015 15:53:57 -0800
Message-ID: <20150227235357.GA13166@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:46091 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbbB0XyD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 18:54:03 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org

This fixes memory leak introduced by commit
a09221e83e13e09a33109b9b037484eade901cea

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index d28726a..1bd15eb 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2605,8 +2605,10 @@ int alps_detect(struct psmouse *psmouse, bool set_properties)
 		return -ENOMEM;
 
 	error = alps_identify(psmouse, priv);
-	if (error)
+	if (error) {
+		kfree(priv);
 		return error;
+	}
 
 	if (set_properties) {
 		psmouse->vendor = "ALPS";
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
