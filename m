From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH 1/2] input: samsung-keypad: Use of_match_ptr()
Date: Tue, 21 Aug 2012 12:41:46 +0200
Message-ID: <1345545706-27420-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Instead of having to define the match table to NULL if CONFIG_OF isn't
set, use the of_match_ptr() macro which will do this for us.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/input/keyboard/samsung-keypad.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index a061ba6..e2f31c8 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -662,8 +662,6 @@ static const struct of_device_id samsung_keypad_dt_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
-#else
-#define samsung_keypad_dt_match NULL
 #endif
 
 static struct platform_device_id samsung_keypad_driver_ids[] = {
@@ -684,7 +682,7 @@ static struct platform_driver samsung_keypad_driver = {
 	.driver		= {
 		.name	= "samsung-keypad",
 		.owner	= THIS_MODULE,
-		.of_match_table = samsung_keypad_dt_match,
+		.of_match_table = of_match_ptr(samsung_keypad_dt_match),
 		.pm	= &samsung_keypad_pm_ops,
 	},
 	.id_table	= samsung_keypad_driver_ids,
-- 
1.7.5.4
