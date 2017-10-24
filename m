From: Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drivers/hid: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 23:00:22 +0530
Message-ID: <1508866222-15063-1-git-send-email-allen.pais@oracle.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Switch to using the new timer_setup() and from_timer()
for drivers/hid/*

Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
Note: This patch is only compile tested. 

 drivers/hid/hid-appleir.c      | 8 ++++----
 drivers/hid/hid-multitouch.c   | 6 +++---
 drivers/hid/hid-prodikeys.c    | 7 +++----
 drivers/hid/hid-wiimote-core.c | 6 +++---
 drivers/hid/usbhid/hid-core.c  | 8 ++++----
 5 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 07cbc70..f5f4a93 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -173,9 +173,9 @@ static void battery_flat(struct appleir *appleir)
 	dev_err(&appleir->input_dev->dev, "possible flat battery?\n");
 }
 
-static void key_up_tick(unsigned long data)
+static void key_up_tick(struct timer_list *t)
 {
-	struct appleir *appleir = (struct appleir *)data;
+	struct appleir *appleir = from_timer(applier, t, key_up_timer);
 	struct hid_device *hid = appleir->hid;
 	unsigned long flags;
 
@@ -303,8 +303,8 @@ static int appleir_probe(struct hid_device *hid, const struct hid_device_id *id)
 	hid->quirks |= HID_QUIRK_HIDINPUT_FORCE;
 
 	spin_lock_init(&appleir->lock);
-	setup_timer(&appleir->key_up_timer,
-		    key_up_tick, (unsigned long) appleir);
+	timer_setup(&appleir->key_up_timer,
+		    key_up_tick, 0);
 
 	hid_set_drvdata(hid, appleir);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 9e8c4d2..b5117a8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1246,9 +1246,9 @@ static void mt_release_contacts(struct hid_device *hid)
 	td->num_received = 0;
 }
 
-static void mt_expired_timeout(unsigned long arg)
+static void mt_expired_timeout(struct timer_list *t)
 {
-	struct hid_device *hdev = (void *)arg;
+	struct hid_device *hdev = from_timer(hdev, t, release_timer);
 	struct mt_device *td = hid_get_drvdata(hdev);
 
 	/*
@@ -1331,7 +1331,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
-	setup_timer(&td->release_timer, mt_expired_timeout, (long)hdev);
+	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 49c4bd3..87eda34 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -239,9 +239,9 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 	return;
 }
 
-static void pcmidi_sustained_note_release(unsigned long data)
+static void pcmidi_sustained_note_release(struct timer_list *t)
 {
-	struct pcmidi_sustain *pms = (struct pcmidi_sustain *)data;
+	struct pcmidi_sustain *pms = from_timer(pms, t, timer);
 
 	pcmidi_send_note(pms->pm, pms->status, pms->note, pms->velocity);
 	pms->in_use = 0;
@@ -256,8 +256,7 @@ static void init_sustain_timers(struct pcmidi_snd *pm)
 		pms = &pm->sustained_notes[i];
 		pms->in_use = 0;
 		pms->pm = pm;
-		setup_timer(&pms->timer, pcmidi_sustained_note_release,
-			(unsigned long)pms);
+		timer_setup(&pms->timer, pcmidi_sustained_note_release, 0);
 	}
 }
 
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index d003914..579884e 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1226,9 +1226,9 @@ static void wiimote_schedule(struct wiimote_data *wdata)
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 }
 
-static void wiimote_init_timeout(unsigned long arg)
+static void wiimote_init_timeout(struct timer_list *t)
 {
-	struct wiimote_data *wdata = (void*)arg;
+	struct wiimote_data *wdata = from_timer(wdata, t, timer);
 
 	wiimote_schedule(wdata);
 }
@@ -1740,7 +1740,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->state.cmd_battery = 0xff;
 
 	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
-	setup_timer(&wdata->timer, wiimote_init_timeout, (long)wdata);
+	timer_setup(&wdata->timer, wiimote_init_timeout, 0);
 
 	return wdata;
 }
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 045b5da..640dfb93 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -101,10 +101,10 @@ static int hid_start_in(struct hid_device *hid)
 }
 
 /* I/O retry timer routine */
-static void hid_retry_timeout(unsigned long _hid)
+static void hid_retry_timeout(struct timer_list *t)
 {
-	struct hid_device *hid = (struct hid_device *) _hid;
-	struct usbhid_device *usbhid = hid->driver_data;
+	struct usbhid_device *usbhid = from_timer(usbhid, t, io_retry);
+	struct hid_device *hid = usbhid->hid;
 
 	dev_dbg(&usbhid->intf->dev, "retrying intr urb\n");
 	if (hid_start_in(hid))
@@ -1373,7 +1373,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 
 	init_waitqueue_head(&usbhid->wait);
 	INIT_WORK(&usbhid->reset_work, hid_reset);
-	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
+	timer_setup(&usbhid->io_retry, hid_retry_timeout, 0);
 	spin_lock_init(&usbhid->lock);
 
 	ret = hid_add_device(hid);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
