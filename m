From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: [PATCH] Input: pc110pad - remove unused variable dev
Date: Wed, 15 Apr 2009 13:38:51 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904151334270.10088@wrl-59.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-1873646702-1239791931=:10088"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38362 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZDOKiy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 06:38:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1873646702-1239791931=:10088
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


dev is leftover from b0ee0d3eb31a163c958f2960906c44bcdfdc607b
(Input: pc110pad - use no_pci_devices()).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 drivers/input/mouse/pc110pad.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index f63995f..3941f97 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -108,7 +108,6 @@ static int pc110pad_open(struct input_dev *dev)
  */
 static int __init pc110pad_init(void)
 {
-	struct pci_dev *dev;
 	int err;
 
 	if (!no_pci_devices())
-- 
1.5.2.2

---696208474-1873646702-1239791931=:10088--
