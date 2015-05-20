From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input/joydev: Don't classify the vmmouse as a
 joystick
Date: Wed, 20 May 2015 15:23:52 -0700
Message-ID: <20150520222352.GG23809@dtor-ws>
References: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
 <1432035425-45514-2-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33543 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbETWX5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 18:23:57 -0400
Received: by iebgx4 with SMTP id gx4so50336391ieb.0
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 15:23:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432035425-45514-2-git-send-email-thellstrom@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: linux-input@vger.kernel.org, pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com

Hi Thomas,

On Tue, May 19, 2015 at 04:37:04AM -0700, Thomas Hellstrom wrote:
> Joydev is currently thinking some absolute mice are joystick, and that
> messes up games in VMware guests, as the cursor typically gets stuck in
> the top left corner.
> 
> Try to detect the event signature of a VMmouse input device and back off
> for such devices. We're still incorrectly detecting, for example, the
> VMware absolute USB mouse as a joystick, but adding an event signature
> matching also that device would be considerably more risky, so defer that
> to a later merge window.

Right. What events does it report?

> 
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  drivers/input/joydev.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index f362883..1ad2fb1 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -747,6 +747,42 @@ static void joydev_cleanup(struct joydev *joydev)
>  		input_close_device(handle);
>  }
>  
> +static bool joydev_dev_is_mouse(struct input_dev *dev)
> +{
> +	DECLARE_BITMAP(jd_scratch, KEY_CNT);
> +
> +	BUILD_BUG_ON(ABS_CNT > KEY_CNT || EV_CNT > KEY_CNT);
> +
> +	/*
> +	 * A device is, for joystick detection purposes, considered to be
> +	 * a mouse if the following is true. (This is currently tailored to
> +	 * the VMware PS/2 VMMouse device but might be extended).
> +	 *
> +	 * 1) Absolute events are exactly ABS_X and ABS_Y.
> +	 * 2) Keys are exactly BTN_LEFT, BTN_RIGHT and BTN_MIDDLE.
> +	 * 3) Event types include EV_ABS, EV_KEY and possibly EV_SYN.

EV_SYN is set automatically on _every_ input device.
There is also amijoy driver that historically uses
BTN_LEFT/RIGHT/MIDDLE.

Does the version of the patch below still work for you?

-- 
Dmitry


Input: joydev - don't classify the vmmouse as a joystick

From: Thomas Hellstrom <thellstrom@vmware.com>

Joydev is currently thinking some absolute mice are joystick, and that
messes up games in VMware guests, as the cursor typically gets stuck in
the top left corner.

Try to detect the event signature of a VMmouse input device and back off
for such devices. We're still incorrectly detecting, for example, the
VMware absolute USB mouse as a joystick, but adding an event signature
matching also that device would be considerably more risky, so defer that
to a later merge window.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joydev.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f362883..1d247bc 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -747,6 +747,63 @@ static void joydev_cleanup(struct joydev *joydev)
 		input_close_device(handle);
 }
 
+static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
+{
+	DECLARE_BITMAP(jd_scratch, KEY_CNT);
+
+	BUILD_BUG_ON(ABS_CNT > KEY_CNT || EV_CNT > KEY_CNT);
+
+	/*
+	 * Virtualization (VMware, etc) and remote management (HP
+	 * ILO2) solutions use absolute coordinates for their virtual
+	 * pointing devices so that there is one-to-one relationship
+	 * between pointer position on the host screen and virtual
+	 * guest screen, and so their mice use ABS_X, ABS_Y and 3
+	 * primary button events. This clashes with what joydev
+	 * considers to be joysticks (a device with at minimum ABS_X
+	 * axis).
+	 *
+	 * Here we are trying to separate absolute mice from
+	 * joysticks. A device is, for joystick detection purposes,
+	 * considered to be an absolute mouse if the following is
+	 * true:
+	 *
+	 * 1) Event types are exactly EV_ABS, EV_KEY and EV_SYN.
+	 * 2) Absolute events are exactly ABS_X and ABS_Y.
+	 * 3) Keys are exactly BTN_LEFT, BTN_RIGHT and BTN_MIDDLE.
+	 * 4) Device is not on "Amiga" bus.
+	 */
+
+	bitmap_zero(jd_scratch, EV_CNT);
+	__set_bit(EV_ABS, jd_scratch);
+	__set_bit(EV_KEY, jd_scratch);
+	__set_bit(EV_SYN, jd_scratch);
+	if (!bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
+		return false;
+
+	bitmap_zero(jd_scratch, ABS_CNT);
+	__set_bit(ABS_X, jd_scratch);
+	__set_bit(ABS_Y, jd_scratch);
+	if (!bitmap_equal(dev->absbit, jd_scratch, ABS_CNT))
+		return false;
+
+	bitmap_zero(jd_scratch, KEY_CNT);
+	__set_bit(BTN_LEFT, jd_scratch);
+	__set_bit(BTN_RIGHT, jd_scratch);
+	__set_bit(BTN_MIDDLE, jd_scratch);
+
+	if (!bitmap_equal(dev->keybit, jd_scratch, KEY_CNT))
+		return false;
+
+	/*
+	 * Amiga joystick (amijoy) historically uses left/middle/right
+	 * button events.
+	 */
+	if (dev->id.bustype == BUS_AMIGA)
+		return false;
+
+	return true;
+}
 
 static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 {
@@ -758,6 +815,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_DIGI, dev->keybit))
 		return false;
 
+	/* Avoid absolute mice */
+	if (joydev_dev_is_absolute_mouse(dev))
+		return false;
+
 	return true;
 }
 
