From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 2/2] input: ad714x - use stage qty to split max_coord for wheel algo
Date: Thu, 26 Apr 2012 13:17:19 -0400
Message-ID: <1335460639-1362-2-git-send-email-jeff.dagenais@gmail.com>
References: <1335460639-1362-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42579 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab2DZRRn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 13:17:43 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so1585341qad.19
        for <linux-input@vger.kernel.org>; Thu, 26 Apr 2012 10:17:43 -0700 (PDT)
In-Reply-To: <1335460639-1362-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>

Using "end_stage - start_stage" yields "number of used stages -1".
This makes the divisor smaller, hence the dividend greater.

So for example, with 8 (0..7) stages, and max_coord of 1024, the
algo should figure out that 1024 should be split in 8, so 8 slices
of 128. Instead, dividing by 7 will give bigger slices of 146.

While adding these "slices", when stages 7 and 0 are weighted to
determine the abs_pos, a dead-zone appears where we are stuck at
max_coord because of the bigger "slices" and the if that follows:
"if abs_pos > max_coord, then abs_pos =3D max_coord"

Hence this commit, which re-uses variable "stag_num" initialized with
the number of used stages.

Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/input/misc/ad714x.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 2cf26e5..29f5d10 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -477,8 +477,7 @@ static void ad714x_wheel_cal_abs_pos(struct ad714x_=
chip *ad714x, int idx)
 		ad714x->sensor_val[first_before] +
 		ad714x->sensor_val[first_after];
=20
-	sw->abs_pos =3D ((hw->max_coord / (hw->end_stage - hw->start_stage)) =
*
-			a_param) / b_param;
+	sw->abs_pos =3D ((hw->max_coord / stage_num) * a_param) / b_param;
=20
 	if (sw->abs_pos > hw->max_coord)
 		sw->abs_pos =3D hw->max_coord;
--=20
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
