From: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] input: cyapa: fix output unwanted warning issue
Date: Fri, 24 Jul 2015 13:05:59 +0800
Message-ID: <1437714359-2484-4-git-send-email-dudl@cypress.com>
References: <1437714359-2484-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437714359-2484-1-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Avoid the driver generate warning message when the cyapa driver working
with the old Gen5 trackpad device which does not support the proximity function.
Those old Gen5 trackpad device all have the platform version less than 2.

Signed-off-by: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
---
 drivers/input/mouse/cyapa_gen5.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 6d7abbe..118ba97 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2519,10 +2519,13 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
 				__func__);
 
 		/* By default, the trackpad proximity function is enabled. */
-		error = cyapa_pip_set_proximity(cyapa, true);
-		if (error)
-			dev_warn(dev, "%s: failed to enable proximity.\n",
-				__func__);
+		if (cyapa->platform_ver >= 2) {
+			error = cyapa_pip_set_proximity(cyapa, true);
+			if (error)
+				dev_warn(dev,
+					"%s: failed to enable proximity.\n",
+					__func__);
+		}
 
 		/* Get trackpad product information. */
 		error = cyapa_gen5_get_query_data(cyapa);
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
