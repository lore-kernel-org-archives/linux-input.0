From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Sat, 20 Feb 2010 01:18:47 -0800
Message-ID: <20100220091847.GB30739@core.coreip.homeip.net>
References: <20100217180342.GA22522@srcf.ucam.org>
 <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com>
 <20100217191708.GA15554@core.coreip.homeip.net>
 <22ee4e771002171142q1496842ap4079026a5c0be8c6@mail.gmail.com>
 <20100217195435.GA15742@core.coreip.homeip.net>
 <22ee4e771002171218t69cc4348ia0300a645ce9763d@mail.gmail.com>
 <069C4DAE-598D-45F1-99B5-DA5BAF718179@gmail.com>
 <22ee4e771002171328w3c9cbb8n663c291e9d3634e5@mail.gmail.com>
 <2C0E2BCD-7589-45DE-B7D4-DBEFBFAE879D@gmail.com>
 <22ee4e771002171403o6f0b99e8qd683d78e74fe4522@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <22ee4e771002171403o6f0b99e8qd683d78e74fe4522-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Lamparter <chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, "johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org" <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org" <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 17, 2010 at 11:03:08PM +0100, Christian Lamparter wrote:
> On Wed, Feb 17, 2010 at 10:40 PM, Dmitry Torokhov
> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Feb 17, 2010, at 1:28 PM, Christian Lamparter <chunkeey-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > wrote:
> >
> >> On Wed, Feb 17, 2010 at 9:52 PM, Dmitry Torokhov
> >> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>
> >>> Sorry, I was not clear enough. I meant something in works in Linux
> >>> software
> >>> stack, I was aware that certain router have these buttons already.
> >>>
> >>
> >> wpa_supplicant and hostapd's CLI have this wps_pbc command.
> >> It's more a question of: what application will get to receive the event.
> >
> > Right. So as soon as you have an idea about userspace consumer
> > for the event ping me and I'd be glad to add a key definition for the event.
> Idea? Be a bit more specific...
> 
> As a matter of fact, there are a few potential consumer in the kernel:
> 
> arm/mach-kirkwood/mv88f6281gtw_ge-setup.c:
> .code           = KEY_F1,
> .gpio           = 46,
> .desc           = "WPS Button(F1)",
> .active_low     = 1,
> 
> arm/mach-orion5x/wrt350n-v2-setup.c:
> .code           = KEY_WLAN,
> .gpio           = 2,
> .desc           = "WPS Button",
> .active_low     = 1,
> 
> 
> 
> 
> and there's a lot more "out-off-tree":
> https://dev.openwrt.org/browser/trunk/target/linux/ar71xx/files/arch/mips/ar71xx
> 
> mach-tew-632brp.c:
> .desc           = "wps",
> .type           = EV_KEY,
> .code           = BTN_1,
> .threshold      = 3,
> .gpio           = TEW_632BRP_GPIO_BTN_WPS,
> 
> carl9170:
> input_set_capability(input, EV_KEY, BTN_0);
> 
> 
> as you can see, people are using BTN_1, BTN_0, F1, WLAN (rfkill?)
> as WPS Button substitute. Maybe it would be a good idea to get it right
> now!

I see, then I will be queueing the patch below...

-- 
Dmitry

Input: add KEY_WPS_BUTTON definition

The new key definition is supposed to be used for buttons that initiate
WiFi Protected Setup sequence:

	http://en.wikipedia.org/wiki/Wi-Fi_Protected_Setup

Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
---

 include/linux/input.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/include/linux/input.h b/include/linux/input.h
index 04416f6..6825308 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -597,6 +597,7 @@ struct input_absinfo {
 #define KEY_NUMERIC_POUND	0x20b
 
 #define KEY_CAMERA_FOCUS	0x210
+#define KEY_WPS_BUTTON		0x211	/* WiFi Protected Setup key */
 
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
