From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] input: fix EVIOCSABS regression
Date: Mon, 18 Oct 2010 15:45:24 +0200
Message-ID: <1287409524-3032-2-git-send-email-zonque@gmail.com>
References: <1287409524-3032-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.bugwerft.de ([212.112.241.193]:50584 "EHLO
	mail.bugwerft.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab0JRNy7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 09:54:59 -0400
In-Reply-To: <1287409524-3032-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: s.neumann@raumfeld.com, linux-input@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

448cd16 ("Input: evdev - rearrange ioctl handling") broke EVIOCSABS by
checking for the wrong direction bit.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Tested-by: Sven Neumann <s.neumann@raumfeld.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/evdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index afb64cf..9ddafc3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -683,7 +683,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		}
 	}
 
-	if (_IOC_DIR(cmd) == _IOC_READ) {
+	if (_IOC_DIR(cmd) == _IOC_WRITE) {
 
 		if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCSABS(0))) {
 
-- 
1.7.1

