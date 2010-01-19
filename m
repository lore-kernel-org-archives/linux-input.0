From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
Date: Tue, 19 Jan 2010 00:19:35 +0000
Message-ID: <1263860375.20565.3374.camel@localhost.localdomain>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <167e8a331001181144u54cefd15m65a5a63ca8c4c4b6@mail.gmail.com>
	 <1263850557.20565.3204.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GeP1Vp8yxiTNYS6n9i3W"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263850557.20565.3204.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ping Cheng <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bgunn-2XggCk4BHTRBDgjK7y7TUQ@public.gmane.org
List-Id: linux-input@vger.kernel.org


--=-GeP1Vp8yxiTNYS6n9i3W
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Mon, 2010-01-18 at 21:35 +0000, Bastien Nocera wrote:
<snip>
> >         I still have the exact same problems as with the user-space
> >         patch in
> >         that an error occurs sending the second blob of data to the
> >         tablet, the
> >         first time the driver is initialised. Ping, any ideas about
> >         that?
> > 
> > I am not sure if your issue is similar to what we see with USB devices
> > or not.  In order to properly set the device to Wacom mode, we had to
> > call usb_set_report more than once (up to 5 times for older kernels,
> > and up to 3 times for newer kernels) to get it right.  Please call:
> > 
> > hdev->hid_output_raw_report again when ret is less than 0.  Try up to
> > three times to see what you get.  
> 
> That's pretty straight forward, I'll try and do that.

My brain must have started turning to mush.

It's hid_parse() failing, and calling it multiple times doesn't have any
effects (unlike on USB where it would poke the device repeatedly).

Marcel, any ideas about that?

Adding a few loops for the mode2 switching fixed very unfrequent
failures. All that's left is the hid_parse() failure the first time the
device connects.

> > You need to check if (ret < 0) before calling dev_err() with the
> > second hid_output_raw_report() call, right?
> 
> Copy/paste stupidness all around there (as you can see, it's indented
> properly already ;)

Fixed in the attached patch. Obviously still requires the first patch to
be reviewed.

Cheers

--=-GeP1Vp8yxiTNYS6n9i3W
Content-Disposition: attachment; filename="0001-hid-Implement-Wacom-quirk-in-the-kernel.patch"
Content-Type: text/x-patch; name="0001-hid-Implement-Wacom-quirk-in-the-kernel.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 15fd982367e4e8f5ceeec3b8f802fb0f43da4ef9 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Date: Mon, 18 Jan 2010 16:13:41 +0000
Subject: [PATCH] [hid] Implement Wacom quirk in the kernel

The hid-wacom driver required user-space to poke at the tablet
to make it send data about the cursor location.

This patch makes it do the same thing but in the kernel.

Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 drivers/hid/hid-wacom.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 7475421..ad71a85 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -155,7 +155,9 @@ static int wacom_probe(struct hid_device *hdev,
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct wacom_data *wdata;
+	char rep_data[3];
 	int ret;
+	int limit;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
 	if (wdata == NULL) {
@@ -165,6 +167,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, wdata);
 
+	/* Parse the HID report now */
 	ret = hid_parse(hdev);
 	if (ret) {
 		dev_err(&hdev->dev, "parse failed\n");
@@ -177,6 +180,36 @@ static int wacom_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	/* Set Wacom mode2 */
+	rep_data[0] = 0x53; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+	rep_data[1] = 0x03; rep_data[2] = 0x00;
+	limit =3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 3);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #1, %d\n", ret);
+		goto err_free;
+	}
+
+	rep_data[0] = 0x71; /* HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE */
+	/* 0x06 - high reporting speed, 0x05 - low speed */
+	rep_data[1] = 0x06; rep_data[2] = 0x00;
+	limit = 3;
+	do {
+		ret = hdev->hid_output_raw_report(hdev, rep_data, 3);
+	} while (ret < 0 && limit-- > 0);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to poke device #2, %d\n", ret);
+		goto err_free;
+	}
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "parse failed\n");
+		goto err_free;
+	}
+
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
-- 
1.6.5.2


--=-GeP1Vp8yxiTNYS6n9i3W--
