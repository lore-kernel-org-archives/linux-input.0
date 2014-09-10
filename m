From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atkbd - Fix broken keyboard in another LG laptop
Date: Wed, 10 Sep 2014 13:52:13 -0700
Message-ID: <20140910205213.GD38736@core.coreip.homeip.net>
References: <1410372374-11591-1-git-send-email-jsagarribay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410372374-11591-1-git-send-email-jsagarribay@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jaime Velasco Juan <jsagarribay@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, Sheng-Liang Song <ssl@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Jamie,

On Wed, Sep 10, 2014 at 07:06:14PM +0100, Jaime Velasco Juan wrote:
> This model has the same quirk as others, see 3d725caa9dcc "Input:
> atkbd - fix keyboard not working on some LG laptops"
> 

How about the patch below instead?

Thanks!

-- 
Dmitry

Input: atkbd - do not try 'deactivate' keyboard on any LG laptops

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We are getting more and more reports about LG laptops not having
functioning keyboard if we try to deactivate keyboard during probe.
Given that having keyboard deactivated is merely "nice to have"
instead of a hard requirement for probing, let's disable it on all
LG boxes instead of trying to hunt down particular models.

This change is prompted by patches trying to add "LG Electronics"/"ROCKY"
and "LG Electronics"/"LW60-F27B" to the DMI list.

https://bugzilla.kernel.org/show_bug.cgi?id=77051

Cc: stable@vger.kernel.org
Reported-by: Jaime Velasco Juan <jsagarribay@gmail.com>
Reported-by: Georgios Tsalikis <georgios@tsalikis.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2dd1d0d..6f5d795 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1791,14 +1791,6 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LW25-B7HV"),
-		},
-		.callback = atkbd_deactivate_fixup,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P1-J273B"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
