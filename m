From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: [PATCH] hid: hidraw_connect memleak fix
Date: Thu, 27 Sep 2007 09:33:12 +0200
Message-ID: <200709270933.13497.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: jkosina@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It looks like hidraw_connect() is leaking memory in case of failure.
Also it should return -ENOMEM when kzalloc fails.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/hid/hidraw.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.23-rc8-mm1-a/drivers/hid/hidraw.c	2007-09-26 12:07:37.000000000 +0200
+++ linux-2.6.23-rc8-mm1-b/drivers/hid/hidraw.c	2007-09-26 14:36:08.000000000 +0200
@@ -282,7 +282,7 @@ EXPORT_SYMBOL_GPL(hidraw_report_event);

 int hidraw_connect(struct hid_device *hid)
 {
-	int minor, result = -EINVAL;
+	int minor, result;
 	struct hidraw *dev;

 	/* TODO currently we accept any HID device. This should later
@@ -290,8 +290,11 @@ int hidraw_connect(struct hid_device *hi
 	 * non-input applications
 	 */

-	if (!(dev = kzalloc(sizeof(struct hidraw), GFP_KERNEL)))
-		return -1;
+	dev = kzalloc(sizeof(struct hidraw), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	result = -EINVAL;

 	spin_lock(&minors_lock);

@@ -305,8 +308,10 @@ int hidraw_connect(struct hid_device *hi

 	spin_unlock(&minors_lock);

-	if (result)
+	if (result) {
+		kfree(dev);
 		goto out;
+	}

 	dev->dev = device_create(hidraw_class, NULL, MKDEV(hidraw_major, minor),
 				"%s%d", "hidraw", minor);
@@ -316,6 +321,7 @@ int hidraw_connect(struct hid_device *hi
 		hidraw_table[minor] = NULL;
 		spin_unlock(&minors_lock);
 		result = PTR_ERR(dev->dev);
+		kfree(dev);
 		goto out;
 	}
