From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]joydev open count handling
Date: Fri, 5 Oct 2007 17:10:21 +0200
Message-ID: <200710051710.21518.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

if joydev_open() fails, the open count has to be adjusted.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

----

--- a/drivers/input/joydev.c	2007-10-05 17:01:21.000000000 +0200
+++ b/drivers/input/joydev.c	2007-10-05 17:01:39.000000000 +0200
@@ -193,8 +193,10 @@ static int joydev_open(struct inode *ino
 
 	if (!joydev->open++ && joydev->exist) {
 		error = input_open_device(&joydev->handle);
-		if (error)
+		if (error) {
+			joydev->open--;
 			goto err_free_client;
+		}
 	}
 
 	file->private_data = client;
