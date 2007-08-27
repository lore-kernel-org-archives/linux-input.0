From: Adrian Bunk <bunk@kernel.org>
Subject: [-mm patch] mousedev.c:mixdev_open_devices() bugfix
Date: Mon, 27 Aug 2007 23:28:32 +0200
Message-ID: <20070827212832.GA4121@stusta.de>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764929AbXH0Vgo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070822020648.5ea3a612.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, Aug 22, 2007 at 02:06:48AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc2-mm2:
>...
>  git-input.patch
>...
>  git trees
>...

This patch fixes an obvious bug in mixdev_open_devices().

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
bb574366744163ff84609843ee43e84a39f57d5a 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 2ad8633..4ca0ad3 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -461,7 +461,7 @@ static void mixdev_open_devices(void)
 
 	list_for_each_entry(mousedev, &mousedev_mix_list, mixdev_node) {
 		if (!mousedev->mixdev_open) {
-			if (mousedev_open_device(mousedev));
+			if (mousedev_open_device(mousedev))
 				continue;
 
 			mousedev->mixdev_open = 1;
