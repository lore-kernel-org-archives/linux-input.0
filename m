From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: [PATCH BlueZ 4/4] plugins/sixaxis: Wait for the PS button before setting the LEDs
Date: Fri,  5 Aug 2011 16:09:18 +0200
Message-ID: <1312553358-26280-5-git-send-email-ospite@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312553358-26280-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Wait for actual input events, that is PS button has been pressed, before
setting the LEDs to indicate the controller number.
This makes setting LEDs look more like on the PS3.
---
 plugins/sixaxis.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 2b0616a..d64ad6d 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -511,8 +511,14 @@ static void handle_device_plug(struct udev_device *udevice)
 		sixpair(fd, adapter);
 	}
 
-	if (js_num > 0)
+	if (js_num > 0) {
+		char c;
+
+		/* wait for events before setting leds */
+		if (read(fd, &c, 1) != 1)
+			perror("read error");
 		set_controller_number(fd, js_num);
+	}
 
 	close(fd);
 }
-- 
1.7.5.4
