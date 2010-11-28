From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input event for blocking touchpad
Date: Sun, 28 Nov 2010 00:07:43 -0800
Message-ID: <20101128080743.GE14499@core.coreip.homeip.net>
References: <20101126211056.GD3819@barata.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f66.google.com ([209.85.213.66]:46100 "EHLO
	mail-yw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0K1JQX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 04:16:23 -0500
Content-Disposition: inline
In-Reply-To: <20101126211056.GD3819@barata.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Nov 26, 2010 at 07:10:57PM -0200, Thadeu Lima de Souza Cascardo wrote:
> Hello,
> 
> I have a notebook with an ACPI system that notifies about the pressing
> of the key for blocking touchpad. However, it does not notify it by
> itself. I was considering sending the event to userspace and let it does
> the blocking.
> 
> Since other keys are also notified by this same ACPI object, it's even
> more natural that I use an input device to send this to userspace.
> 
> The problem is: there seems to be no event to represent this. Any
> suggestions?
> 

I have the patch below from Bastien that I will be queueing shortly.

Thanks.

-- 
Dmitry


Input: add keycodes for touchpad on/off keys

From: Bastien Nocera <hadess@hadess.net>

Some laptops will have a "touchpad toggle" soft button, which expects
user-space to turn off the touchpad themselves, some other devices will
do this in hardware, but send key events telling us that the touchpad
has been turned off/on.

KEY_TOUCHPAD_ON/KEY_TOUCHPAD_OFF will be used by user-space to show a
popup with the status of the touchpad.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 include/linux/input.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/include/linux/input.h b/include/linux/input.h
index 6c3c986..a8af21d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -643,6 +643,10 @@ struct input_keymap_entry {
 #define KEY_CAMERA_FOCUS	0x210
 #define KEY_WPS_BUTTON		0x211	/* WiFi Protected Setup key */
 
+#define KEY_TOUCHPAD_TOGGLE	0x212	/* Request switch touchpad on or off */
+#define KEY_TOUCHPAD_ON		0x213
+#define KEY_TOUCHPAD_OFF	0x214
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
