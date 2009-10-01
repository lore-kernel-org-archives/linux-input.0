From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 05/34] move grover_remove to .devexit.text
Date: Thu,  1 Oct 2009 10:28:09 +0200
Message-ID: <1254385718-14254-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091001082607.GA2181@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932169AbZJAI26@vger.kernel.org>
In-Reply-To: <20091001082607.GA2181@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The function grover_remove is used only wrapped by __devexit_p so defin=
e
it using __devexit.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/misc/sparcspkr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcs=
pkr.c
index 5399dd2..b064419 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -308,7 +308,7 @@ out_err:
 	return err;
 }
=20
-static int grover_remove(struct of_device *op)
+static int __devexit grover_remove(struct of_device *op)
 {
 	struct sparcspkr_state *state =3D dev_get_drvdata(&op->dev);
 	struct grover_beep_info *info =3D &state->u.grover;
--=20
1.6.4.3
