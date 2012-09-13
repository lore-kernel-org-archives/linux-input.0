From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/4] HID: prodikeys: Remove unnecessary casts of void
 pointers
Date: Thu, 13 Sep 2012 14:10:34 +0800
Message-ID: <1347516634.3319.4.camel@phoenix>
References: <1347516512.3319.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65505 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2IMGKj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 02:10:39 -0400
Received: by obbuo13 with SMTP id uo13so3971425obb.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 23:10:38 -0700 (PDT)
In-Reply-To: <1347516512.3319.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Don Prince <dhprince-devel@yahoo.co.uk>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-prodikeys.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index b71b77a..ec8ca33 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -105,7 +105,7 @@ static ssize_t show_channel(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read channel=%u\n", pk->pm->midi_channel);
 
@@ -118,7 +118,7 @@ static ssize_t store_channel(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	unsigned channel = 0;
 
@@ -142,7 +142,7 @@ static ssize_t show_sustain(struct device *dev,
  struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read sustain=%u\n", pk->pm->midi_sustain);
 
@@ -155,7 +155,7 @@ static ssize_t store_sustain(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	unsigned sustain = 0;
 
@@ -181,7 +181,7 @@ static ssize_t show_octave(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	dbg_hid("pcmidi sysfs read octave=%d\n", pk->pm->midi_octave);
 
@@ -194,7 +194,7 @@ static ssize_t store_octave(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 
 	int octave = 0;
 
@@ -759,7 +759,7 @@ static int pk_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 	struct pcmidi_snd *pm;
 
 	pm = pk->pm;
@@ -777,7 +777,7 @@ static int pk_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 	u8 *data, int size)
 {
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 	int ret = 0;
 
 	if (1 == pk->pm->ifnum) {
@@ -858,7 +858,7 @@ err_free_pk:
 
 static void pk_remove(struct hid_device *hdev)
 {
-	struct pk_device *pk = (struct pk_device *)hid_get_drvdata(hdev);
+	struct pk_device *pk = hid_get_drvdata(hdev);
 	struct pcmidi_snd *pm;
 
 	pm = pk->pm;
-- 
1.7.9.5



