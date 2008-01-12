From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] input: psmouse: fix potential input register race in
 psmouse_connect()
Date: Sat, 12 Jan 2008 15:13:45 -0500
Message-ID: <20080112151345.5d14c104@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762866AbYALUNg@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org


If we successfully call input_register_device() in
psmouse_connect but sysfs_create_group() fails, we'll enter the error
path without ever having called input_unregister_device() (potentially
leaking memory, or creating a race condition if something else attempts
to access the new input device).  This calls input_unregister_device
from the error path, and sets input_dev to NULL so that we don't
attempt to also call input_free_device on it.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/psmouse-base.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 21a9c0b..df25e7b 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1247,6 +1247,8 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
  err_pt_deactivate:
 	if (parent && parent->pt_deactivate)
 		parent->pt_deactivate(parent);
+	input_unregister_device(psmouse->dev);
+	input_dev = NULL;
  err_protocol_disconnect:
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
-- 
1.5.3.5

