From: Yueyao Zhu <yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] sound: usb: allow interfaces that the driver claims to autosuspend
Date: Thu,  8 Jun 2017 14:58:28 -0700
Message-ID: <20170608215828.130455-4-yueyao.zhu@gmail.com>
References: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170608215828.130455-1-yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Chant <achant-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Badhri Jagan Sridharan <badhri-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yueyao Zhu <yueyao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Yueyao Zhu <yueyao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Instead of calling usb_enable_autosuspend() to change the configuration
of a USB device as an interface driver, enable autosuspend for every
interfaces that the driver claims.

Signed-off-by: Yueyao Zhu <yueyao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 sound/usb/card.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 6640277a725b..79bec2883740 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -184,6 +184,7 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 			return -EINVAL;
 		}
 		usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
+		usb_allow_interface_autosuspend(iface);
 
 		return 0;
 	}
@@ -206,6 +207,7 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	if (! snd_usb_parse_audio_interface(chip, interface)) {
 		usb_set_interface(dev, interface, 0); /* reset the current interface */
 		usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
+		usb_allow_interface_autosuspend(iface);
 	}
 
 	return 0;
@@ -618,6 +620,7 @@ static int usb_audio_probe(struct usb_interface *intf,
 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
 	usb_set_intfdata(intf, chip);
+	usb_allow_interface_autosuspend(intf);
 	atomic_dec(&chip->active);
 	mutex_unlock(&register_mutex);
 	return 0;
-- 
2.13.0.506.g27d5fe0cd-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
