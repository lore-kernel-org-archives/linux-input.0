From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 3/3] input: Made keyreset more robust
Date: Tue, 27 Oct 2015 09:33:25 +0100
Message-ID: <1445934805-5690-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Daniel Rosenberg <drosen@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-input@vger.kernel.org

=46rom: Daniel Rosenberg <drosen@google.com>

Switched do_restart to run in a seperate workqueue to  handle
cases where kernel_restart hangs.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/input/keyreset.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyreset.c b/drivers/input/keyreset.c
index eaaccde..7fbf724 100644
--- a/drivers/input/keyreset.c
+++ b/drivers/input/keyreset.c
@@ -27,9 +27,10 @@ struct keyreset_state {
	int restart_requested;
	int (*reset_fn)(void);
	struct platform_device *pdev_child;
+	struct work_struct restart_work;
 };

-static void do_restart(void)
+static void do_restart(struct work_struct *unused)
 {
	sys_sync();
	kernel_restart(NULL);
@@ -44,7 +45,7 @@ static void do_reset_fn(void *priv)
		state->restart_requested =3D state->reset_fn();
	} else {
		pr_info("keyboard reset\n");
-		do_restart();
+		schedule_work(&state->restart_work);
		state->restart_requested =3D 1;
	}
 }
@@ -69,6 +70,7 @@ static int keyreset_probe(struct platform_device *pde=
v)
	if (!state->pdev_child)
		return -ENOMEM;
	state->pdev_child->dev.parent =3D &pdev->dev;
+	INIT_WORK(&state->restart_work, do_restart);

	keyp =3D pdata->keys_down;
	while ((key =3D *keyp++)) {
--
1.7.9.5
