From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: [PATCH] iforce: Use usb_kill_urb instead of usb_unlink_urb.
Date: Sat, 17 Mar 2007 22:50:58 +0100
Message-ID: <38b3b7c0703171450q5217f4eer91e7ba0f6135d98@mail.gmail.com>
References: <38b3b7c0703171439n10025a7bx55a588911eb765d6@mail.gmail.com>
	 <38b3b7c0703171443j2f50f913r76ab111ba7ed109f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_108632_8931978.1174168258917"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0703171443j2f50f913r76ab111ba7ed109f@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

------=_Part_108632_8931978.1174168258917
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A note about that patch: Apparently Anders Fugmann submitted a patch to use
usb_kill_urb to linux-usb-devel for version 2.6.10.
I don't know if this patch got lost, or if it was rejected.

On 3/17/07, johann deneux <johann.deneux@gmail.com> wrote:
>
> commit 0ba8785483c2ee7f56e8f242e000f6cd17a7da40
> Author: Johann Deneux <johann.deneux@gmail.com>
> Date:   Sat Mar 17 22:23:44 2007 +0100
>
>     iforce: Use usb_kill_urb instead of usb_unlink_urb.
>
>     Using usb_unlink_urb can cause iforce_open to fail when called soon
> after iforce_release.
>     Also updated my email address and replaced calls to printk() by dbg(),
> warn(), info(), err()...
>
>     Signed-off-by: Johann Deneux < johann.deneux@gmail.com>
>
> diff --git a/drivers/input/joystick/iforce/iforce-ff.cb/drivers/input/joystick/iforce/iforce-
> ff.c
> index 8fb0c19..f2a4381 100644
> --- a/drivers/input/joystick/iforce/iforce- ff.c
> +++ b/drivers/input/joystick/iforce/iforce-ff.c
> @@ -2,7 +2,7 @@
>   * $Id: iforce-ff.c,v 1.9 2002/02/02 19:28:35 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2002 Vojtech Pavlik < vojtech@ucw.cz>
> - *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
> + *  Copyright (c) 2001-2002, 2007 Johann Deneux < johann.deneux@gmail.com
> >
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
> @@ -205,7 +205,7 @@ static int need_condition_modifier(struct ff_effect
> *old, struct ff_effect *new)
> int i;
>
> if (new->type != FF_SPRING && new->type != FF_FRICTION) {
> - printk(KERN_WARNING "iforce.c: bad effect type in
> need_condition_modifier\n");
> + warn("bad effect type in need_condition_modifier");
> return 0;
> }
>
> @@ -227,7 +227,7 @@ static int need_condition_modifier(struct ff_effect
> *old, struct ff_effect *new)
> static int need_magnitude_modifier(struct ff_effect *old, struct ff_effect
> *effect)
> {
> if (effect->type != FF_CONSTANT) {
> - printk(KERN_WARNING "iforce.c: bad effect type in
> need_envelope_modifier\n");
> + warn("bad effect type in need_envelope_modifier");
> return 0;
> }
>
> @@ -258,7 +258,7 @@ static int need_envelope_modifier(struct ff_effect
> *old, struct ff_effect *effec
> break;
>
> default:
> - printk(KERN_WARNING "iforce.c: bad effect type in
> need_envelope_modifier\n");
> + warn("bad effect type in need_envelope_modifier");
> }
>
> return 0;
> @@ -271,7 +271,7 @@ static int need_envelope_modifier(struct ff_effect
> *old, struct ff_effect *effec
> static int need_period_modifier(struct ff_effect *old, struct ff_effect
> *new)
> {
> if (new->type != FF_PERIODIC) {
> - printk(KERN_WARNING "iforce.c: bad effect type in
> need_period_modifier\n");
> + warn("bad effect type in need_period_modifier");
> return 0;
> }
> return (old->u.periodic.period != new->u.periodic.period
> diff --git a/drivers/input/joystick/iforce/iforce-main.cb/drivers/input/joystick/iforce/iforce-
> main.c
> index 3393a37..bd5a6de 100644
> --- a/drivers/input/joystick/iforce/iforce-main.c
> +++ b/drivers/input/joystick/iforce/iforce-main.c
> @@ -2,7 +2,7 @@
>   * $Id: iforce-main.c,v 1.19 2002/07/07 10:22:50 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
> - *  Copyright (c) 2001-2002 Johann Deneux < deneux@ifrance.com >
> + *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
> @@ -29,7 +29,7 @@
>
> #include "iforce.h"
>
> -MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <
> deneux@ifrance.com>");
> +MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com
> >");
> MODULE_DESCRIPTION("USB/RS232 I-Force joysticks and wheels driver");
> MODULE_LICENSE("GPL");
>
> @@ -220,7 +220,7 @@ static void iforce_release(struct input_dev *dev)
> /* Check: no effects should be present in memory */
> for (i = 0; i < dev->ff->max_effects; i++) {
> if (test_bit(FF_CORE_IS_USED, iforce->core_effects[i].flags)) {
> - printk(KERN_WARNING "iforce_release: Device still owns effects\n");
> + warn("iforce_release: Device still owns effects");
> break;
> }
> }
> @@ -232,7 +232,7 @@ static void iforce_release(struct input_dev *dev)
> switch (iforce->bus) {
> #ifdef CONFIG_JOYSTICK_IFORCE_USB
> case IFORCE_USB:
> - usb_unlink_urb(iforce->irq);
> + usb_kill_urb(iforce->irq);
>
> /* The device was unplugged before the file
> * was released */
> @@ -324,7 +324,7 @@ int iforce_init_device(struct iforce *iforce)
> break;
>
> if (i == 20) { /* 5 seconds */
> - printk(KERN_ERR "iforce-main.c: Timeout waiting for response from
> device.\n");
> + err("Timeout waiting for response from device.");
> error = -ENODEV;
> goto fail;
> }
> @@ -336,26 +336,26 @@ int iforce_init_device(struct iforce *iforce)
> if (!iforce_get_id_packet(iforce, "M"))
> input_dev->id.vendor = (iforce->edata[2] << 8) | iforce->edata[1];
> else
> - printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet
> M\n");
> + warn("Device does not respond to id packet M");
>
> if (!iforce_get_id_packet(iforce, "P"))
> input_dev->id.product = (iforce->edata[2] << 8) | iforce->edata[1];
> else
> - printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet
> P\n");
> + warn("Device does not respond to id packet P");
>
> if (!iforce_get_id_packet(iforce, "B"))
> iforce->device_memory.end = (iforce->edata[2] << 8) | iforce->edata[1];
> else
> - printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet
> B\n");
> + warn("Device does not respond to id packet B");
>
> if (!iforce_get_id_packet(iforce, "N"))
> ff_effects = iforce->edata[1];
> else
> - printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet
> N\n");
> + warn("Device does not respond to id packet N");
>
> /* Check if the device can store more effects than the driver can really
> handle */
> if (ff_effects > IFORCE_EFFECTS_MAX) {
> - printk(KERN_WARNING "iforce: Limiting number of effects to %d (device
> reports %d)\n",
> + warn("Limiting number of effects to %d (device reports %d)",
>        IFORCE_EFFECTS_MAX, ff_effects);
> ff_effects = IFORCE_EFFECTS_MAX;
> }
> @@ -457,8 +457,6 @@ int iforce_init_device(struct iforce *iforce)
> if (error)
> goto fail;
>
> - printk(KERN_DEBUG "iforce->dev->open = %p\n", iforce->dev->open);
> -
> return 0;
>
>   fail: input_free_device(input_dev);
> diff --git a/drivers/input/joystick/iforce/iforce- packets.cb/drivers/input/joystick/iforce/iforce-
> packets.c
> index 808f059..21c4e13 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
> @@ -2,7 +2,7 @@
>   * $Id: iforce-packets.c,v 1.16 2002/07/07 10:22:50 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2002 Vojtech Pavlik < vojtech@ucw.cz>
> - *  Copyright (c) 2001-2002 Johann Deneux < deneux@ifrance.com>
> + *  Copyright (c) 2001-2002, 2007 Johann Deneux < johann.deneux@gmail.com
> >
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
> @@ -39,10 +39,10 @@ void iforce_dump_packet(char *msg, u16 cmd, unsigned
> char *data)
> {
> int i;
>
> - printk(KERN_DEBUG "iforce.c: %s ( cmd = %04x, data = ", msg, cmd);
> + printk(KERN_DEBUG __FILE__ ": %s cmd = %04x, data = ", msg, cmd);
> for (i = 0; i < LO(cmd); i++)
> printk("%02x ", data[i]);
> - printk(")\n");
> + printk("\n");
> }
>
> /*
> @@ -65,8 +65,9 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd,
> unsigned char* data)
> head = iforce->xmit.head;
> tail = iforce->xmit.tail;
>
> +
> if (CIRC_SPACE(head, tail, XMIT_SIZE) < n+2) {
> - printk(KERN_WARNING "iforce.c: not enough space in xmit buffer to send
> new packet\n");
> + warn("not enough space in xmit buffer to send new packet");
> spin_unlock_irqrestore(&iforce->xmit_lock, flags);
> return -1;
> }
> @@ -126,8 +127,6 @@ int iforce_control_playback(struct iforce* iforce, u16
> id, unsigned int value)
> {
> unsigned char data[3];
>
> -printk(KERN_DEBUG "iforce-packets.c: control_playback %d %d\n", id,
> value);
> -
> data[0] = LO(id);
> data[1] = (value > 0) ? ((value > 1) ? 0x41 : 0x01) : 0;
> data[2] = LO(value);
> @@ -151,7 +150,7 @@ static int mark_core_as_ready(struct iforce *iforce,
> unsigned short addr)
> return 0;
> }
> }
> - printk(KERN_WARNING "iforce-packets.c: unused effect %04x updated
> !!!\n", addr);
> + warn("unused effect %04x updated !!!", addr);
> return -1;
> }
>
> @@ -162,7 +161,7 @@ void iforce_process_packet(struct iforce *iforce, u16
> cmd, unsigned char *data)
> static int being_used = 0;
>
> if (being_used)
> - printk(KERN_WARNING "iforce-packets.c: re-entrant call to iforce_process
> %d\n", being_used);
> + warn("re-entrant call to iforce_process %d", being_used);
> being_used++;
>
> #ifdef CONFIG_JOYSTICK_IFORCE_232
> @@ -266,7 +265,7 @@ int iforce_get_id_packet(struct iforce *iforce, char
> *packet)
> return -1;
> }
> #else
> - printk(KERN_ERR "iforce_get_id_packet: iforce->bus = USB!\n");
> + err("iforce_get_id_packet: iforce->bus = USB!");
> #endif
> break;
>
> @@ -284,13 +283,12 @@ int iforce_get_id_packet(struct iforce *iforce, char
> *packet)
> return -1;
> }
> #else
> - printk(KERN_ERR "iforce_get_id_packet: iforce->bus = SERIO!\n");
> + err("iforce_get_id_packet: iforce->bus = SERIO!");
> #endif
> break;
>
> default:
> - printk(KERN_ERR "iforce_get_id_packet: iforce->bus = %d\n",
> -        iforce->bus);
> + err("iforce_get_id_packet: iforce->bus = %d", iforce->bus);
> break;
> }
>
> diff --git a/drivers/input/joystick/iforce/iforce-serio.cb/drivers/input/joystick/iforce/iforce-
> serio.c
> index ec4be53..7b4bc19 100644
> --- a/drivers/input/joystick/iforce/iforce-serio.c
> +++ b/drivers/input/joystick/iforce/iforce-serio.c
> @@ -2,7 +2,7 @@
>   * $Id: iforce-serio.c,v 1.4 2002/01/28 22:45:00 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2001 Vojtech Pavlik <vojtech@ucw.cz>
> - *  Copyright (c) 2001 Johann Deneux < deneux@ifrance.com>
> + *  Copyright (c) 2001, 2007 Johann Deneux <johann.deneux@gmail.com>
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
> diff --git a/drivers/input/joystick/iforce/iforce- usb.cb/drivers/input/joystick/iforce/iforce-
> usb.c
> index 80cdebc..750099d 100644
> --- a/drivers/input/joystick/iforce/iforce-usb.c
> +++ b/drivers/input/joystick/iforce/iforce-usb.c
> @@ -2,7 +2,7 @@
>   * $Id: iforce-usb.c ,v 1.16 2002/06/09 11:08:04 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz >
> - *  Copyright (c) 2001-2002 Johann Deneux < deneux@ifrance.com>
> + *  Copyright (c) 2001-2002, 2007 Johann Deneux <johann.deneux@gmail.com>
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
> @@ -65,7 +65,7 @@ void iforce_usb_xmit(struct iforce *iforce)
> XMIT_INC(iforce->xmit.tail, n);
>
> if ( (n=usb_submit_urb(iforce->out, GFP_ATOMIC)) ) {
> - printk(KERN_WARNING "iforce-usb.c: iforce_usb_xmit: usb_submit_urb
> failed %d\n", n);
> + warn("usb_submit_urb failed %d\n", n);
> }
>
> /* The IFORCE_XMIT_RUNNING bit is not cleared here. That's intended.
> @@ -110,7 +110,7 @@ static void iforce_usb_out(struct urb *urb)
> struct iforce *iforce = urb->context;
>
> if (urb->status) {
> - printk(KERN_DEBUG "iforce_usb_out: urb->status %d, exiting",
> urb->status);
> + dbg("urb->status %d, exiting", urb->status);
> return;
> }
>
> @@ -190,10 +190,9 @@ fail:
> /* Called by iforce_delete() */
> void iforce_usb_delete(struct iforce* iforce)
> {
> - usb_unlink_urb(iforce->irq);
> -/* Is it ok to unlink those ? */
> - usb_unlink_urb(iforce->out);
> - usb_unlink_urb(iforce->ctrl);
> + usb_kill_urb(iforce->irq);
> + usb_kill_urb(iforce->out);
> + usb_kill_urb(iforce->ctrl);
>
> usb_free_urb(iforce->irq);
> usb_free_urb(iforce->out);
> diff --git a/drivers/input/joystick/iforce/iforce.h
> b/drivers/input/joystick/iforce/iforce.h
> index ffaeaef..dadcf4f 100644
> --- a/drivers/input/joystick/iforce/iforce.h
> +++ b/drivers/input/joystick/iforce/iforce.h
> @@ -2,7 +2,7 @@
>   * $Id: iforce.h,v 1.13 2002/07/07 10:22:50 jdeneux Exp $
>   *
>   *  Copyright (c) 2000-2002 Vojtech Pavlik < vojtech@ucw.cz>
> - *  Copyright (c) 2001-2002 Johann Deneux < deneux@ifrance.com>
> + *  Copyright (c) 2001-2002, 2007 Johann Deneux < johann.deneux@gmail.com
> >
>   *
>   *  USB/RS232 I-Force joysticks and wheels.
>   */
>

------=_Part_108632_8931978.1174168258917
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A note about that patch: Apparently Anders Fugmann submitted a patch to use usb_kill_urb to linux-usb-devel for version 2.6.10.<br>I don&#39;t know if this patch got lost, or if it was rejected.<br><br><div><span class="gmail_quote">
On 3/17/07, <b class="gmail_sendername">johann deneux</b> &lt;<a href="mailto:johann.deneux@gmail.com">johann.deneux@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><span class="q" id="q_11161da7d8d23884_0">commit 0ba8785483c2ee7f56e8f242e000f6cd17a7da40<br>Author: Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
johann.deneux@gmail.com</a>&gt;<br>
Date:&nbsp;&nbsp; Sat Mar 17 22:23:44 2007 +0100<br><br>&nbsp;&nbsp;&nbsp;&nbsp;iforce: Use usb_kill_urb instead of usb_unlink_urb.
<br>&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;Using usb_unlink_urb can cause iforce_open to fail when called soon after iforce_release.<br>&nbsp;&nbsp;&nbsp;&nbsp;Also updated my email address and replaced calls to printk() by dbg(), warn(), info(), err()...<br>&nbsp;&nbsp;&nbsp;&nbsp;<br>

&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Johann Deneux &lt;
<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">johann.deneux@gmail.com</a>&gt;<br><br>diff --git a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joystick/iforce/iforce-
ff.c<br>index 8fb0c19..f2a4381 100644<br>--- a/drivers/input/joystick/iforce/iforce-
ff.c<br>+++ b/drivers/input/joystick/iforce/iforce-ff.c<br>@@ -2,7 +2,7 @@<br>&nbsp;&nbsp;* $Id: iforce-ff.c,v 1.9 2002/02/02 19:28:35 jdeneux Exp $<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2002 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">


vojtech@ucw.cz</a>&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001-2002 Johann Deneux &lt;<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>&gt;<br>+ *&nbsp;&nbsp;Copyright (c) 2001-2002, 2007 Johann Deneux &lt;
<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
johann.deneux@gmail.com</a>&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.<br>&nbsp;&nbsp;*/<br>@@ -205,7 +205,7 @@ static int need_condition_modifier(struct ff_effect *old, struct ff_effect *new)<br> 	int i;<br> <br> 	if (new-&gt;type != FF_SPRING &amp;&amp; new-&gt;type != FF_FRICTION) {
<br>-		printk(KERN_WARNING &quot;iforce.c: bad effect type in need_condition_modifier\n&quot;);<br>+		warn(&quot;bad effect type in need_condition_modifier&quot;);<br> 		return 0;<br> 	}<br> <br>@@ -227,7 +227,7 @@ static int need_condition_modifier(struct ff_effect *old, struct ff_effect *new)
<br> static int need_magnitude_modifier(struct ff_effect *old, struct ff_effect *effect)<br> {<br> 	if (effect-&gt;type != FF_CONSTANT) {<br>-		printk(KERN_WARNING &quot;iforce.c: bad effect type in need_envelope_modifier\n&quot;);
<br>+		warn(&quot;bad effect type in need_envelope_modifier&quot;);<br> 		return 0;<br> 	}<br> <br>@@ -258,7 +258,7 @@ static int need_envelope_modifier(struct ff_effect *old, struct ff_effect *effec<br> 		break;<br> <br>


 	default:<br>-		printk(KERN_WARNING &quot;iforce.c: bad effect type in need_envelope_modifier\n&quot;);<br>+		warn(&quot;bad effect type in need_envelope_modifier&quot;);<br> 	}<br> <br> 	return 0;<br>@@ -271,7 +271,7 @@ static int need_envelope_modifier(struct ff_effect *old, struct ff_effect *effec
<br> static int need_period_modifier(struct ff_effect *old, struct ff_effect *new)<br> {<br> 	if (new-&gt;type != FF_PERIODIC) {<br>-		printk(KERN_WARNING &quot;iforce.c: bad effect type in need_period_modifier\n&quot;);
<br>
+		warn(&quot;bad effect type in need_period_modifier&quot;);<br> 		return 0;<br> 	}<br> 	return (old-&gt;u.periodic.period != new-&gt;u.periodic.period<br>diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-
main.c<br>index 3393a37..bd5a6de 100644<br>--- a/drivers/input/joystick/iforce/iforce-main.c<br>+++ b/drivers/input/joystick/iforce/iforce-main.c<br>@@ -2,7 +2,7 @@<br>&nbsp;&nbsp;* $Id: iforce-main.c,v 1.19 2002/07/07 10:22:50 jdeneux Exp $
<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2002 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">vojtech@ucw.cz</a>&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001-2002 Johann Deneux &lt;
<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>
&gt;<br>+ *&nbsp;&nbsp;Copyright (c) 2001-2002, 2007 Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">johann.deneux@gmail.com</a>&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.
<br>&nbsp;&nbsp;*/<br>@@ -29,7 +29,7 @@<br>
 <br> #include &quot;iforce.h&quot;<br> <br>-MODULE_AUTHOR(&quot;Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">vojtech@ucw.cz</a>&gt;, Johann Deneux &lt;
<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>&gt;&quot;);
<br>+MODULE_AUTHOR(&quot;Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">vojtech@ucw.cz</a>&gt;, Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

johann.deneux@gmail.com</a>&gt;&quot;);<br> MODULE_DESCRIPTION(&quot;USB/RS232 I-Force joysticks and wheels driver&quot;);
<br> MODULE_LICENSE(&quot;GPL&quot;);<br> <br>@@ -220,7 +220,7 @@ static void iforce_release(struct input_dev *dev)<br> 		/* Check: no effects should be present in memory */<br> 		for (i = 0; i &lt; dev-&gt;ff-&gt;max_effects; i++) {
<br> 			if (test_bit(FF_CORE_IS_USED, iforce-&gt;core_effects[i].flags)) {<br>-				printk(KERN_WARNING &quot;iforce_release: Device still owns effects\n&quot;);<br>+				warn(&quot;iforce_release: Device still owns effects&quot;);
<br> 				break;<br> 			}<br> 		}<br>@@ -232,7 +232,7 @@ static void iforce_release(struct input_dev *dev)<br> 	switch (iforce-&gt;bus) {<br> #ifdef CONFIG_JOYSTICK_IFORCE_USB<br> 		case IFORCE_USB:<br>-			usb_unlink_urb(iforce-&gt;irq);
<br>+			usb_kill_urb(iforce-&gt;irq);<br> <br> 			/* The device was unplugged before the file<br> 			 * was released */<br>@@ -324,7 +324,7 @@ int iforce_init_device(struct iforce *iforce)<br> 			break;<br> <br> 	if (i == 20) { /* 5 seconds */
<br>-		printk(KERN_ERR &quot;iforce-main.c: Timeout waiting for response from device.\n&quot;);<br>+		err(&quot;Timeout waiting for response from device.&quot;);<br> 		error = -ENODEV;<br> 		goto fail;<br> 	}<br>@@ -336,26 +336,26 @@ int iforce_init_device(struct iforce *iforce)
<br> 	if (!iforce_get_id_packet(iforce, &quot;M&quot;))<br> 		input_dev-&gt;id.vendor = (iforce-&gt;edata[2] &lt;&lt; 8) | iforce-&gt;edata[1];<br> 	else<br>-		printk(KERN_WARNING &quot;iforce-main.c: Device does not respond to id packet M\n&quot;);
<br>+		warn(&quot;Device does not respond to id packet M&quot;);<br> <br> 	if (!iforce_get_id_packet(iforce, &quot;P&quot;))<br> 		input_dev-&gt;id.product = (iforce-&gt;edata[2] &lt;&lt; 8) | iforce-&gt;edata[1];<br> 	else
<br>-		printk(KERN_WARNING &quot;iforce-main.c: Device does not respond to id packet P\n&quot;);<br>+		warn(&quot;Device does not respond to id packet P&quot;);<br> <br> 	if (!iforce_get_id_packet(iforce, &quot;B&quot;))
<br>
 		iforce-&gt;device_memory.end = (iforce-&gt;edata[2] &lt;&lt; 8) | iforce-&gt;edata[1];<br> 	else<br>-		printk(KERN_WARNING &quot;iforce-main.c: Device does not respond to id packet B\n&quot;);<br>+		warn(&quot;Device does not respond to id packet B&quot;);
<br> <br> 	if (!iforce_get_id_packet(iforce, &quot;N&quot;))<br> 		ff_effects = iforce-&gt;edata[1];<br> 	else<br>-		printk(KERN_WARNING &quot;iforce-main.c: Device does not respond to id packet N\n&quot;);<br>+		warn(&quot;Device does not respond to id packet N&quot;);
<br> <br> 	/* Check if the device can store more effects than the driver can really handle */<br> 	if (ff_effects &gt; IFORCE_EFFECTS_MAX) {<br>-		printk(KERN_WARNING &quot;iforce: Limiting number of effects to %d (device reports %d)\n&quot;,
<br>+		warn(&quot;Limiting number of effects to %d (device reports %d)&quot;,<br> 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IFORCE_EFFECTS_MAX, ff_effects);<br> 		ff_effects = IFORCE_EFFECTS_MAX;<br> 	}<br>@@ -457,8 +457,6 @@ int iforce_init_device(struct iforce *iforce)
<br> 	if (error)<br> 		goto fail;<br> <br>-	printk(KERN_DEBUG &quot;iforce-&gt;dev-&gt;open = %p\n&quot;, iforce-&gt;dev-&gt;open);<br>-<br> 	return 0;<br> <br>&nbsp;&nbsp;fail:	input_free_device(input_dev);<br>diff --git a/drivers/input/joystick/iforce/iforce-
packets.c b/drivers/input/joystick/iforce/iforce-packets.c<br>index 808f059..21c4e13 100644<br>--- a/drivers/input/joystick/iforce/iforce-packets.c<br>+++ b/drivers/input/joystick/iforce/iforce-packets.c<br>@@ -2,7 +2,7 @@
<br>&nbsp;&nbsp;* $Id: iforce-packets.c,v 1.16 2002/07/07 10:22:50 jdeneux Exp $<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2002 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

vojtech@ucw.cz</a>&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001-2002 Johann Deneux &lt;
<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>&gt;<br>+ *&nbsp;&nbsp;Copyright (c) 2001-2002, 2007 Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

johann.deneux@gmail.com</a>&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.
<br>&nbsp;&nbsp;*/<br>@@ -39,10 +39,10 @@ void iforce_dump_packet(char *msg, u16 cmd, unsigned char *data)<br> {<br> 	int i;<br> <br>-	printk(KERN_DEBUG &quot;iforce.c: %s ( cmd = %04x, data = &quot;, msg, cmd);<br>+	printk(KERN_DEBUG __FILE__ &quot;: %s cmd = %04x, data = &quot;, msg, cmd);
<br> 	for (i = 0; i &lt; LO(cmd); i++)<br> 		printk(&quot;%02x &quot;, data[i]);<br>-	printk(&quot;)\n&quot;);<br>+	printk(&quot;\n&quot;);<br> }<br> <br> /*<br>@@ -65,8 +65,9 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data)
<br> 	head = iforce-&gt;xmit.head;<br> 	tail = iforce-&gt;xmit.tail;<br> <br>+<br> 	if (CIRC_SPACE(head, tail, XMIT_SIZE) &lt; n+2) {<br>-		printk(KERN_WARNING &quot;iforce.c: not enough space in xmit buffer to send new packet\n&quot;);
<br>+		warn(&quot;not enough space in xmit buffer to send new packet&quot;);<br> 		spin_unlock_irqrestore(&amp;iforce-&gt;xmit_lock, flags);<br> 		return -1;<br> 	}<br>@@ -126,8 +127,6 @@ int iforce_control_playback(struct iforce* iforce, u16 id, unsigned int value)
<br> {<br> 	unsigned char data[3];<br> <br>-printk(KERN_DEBUG &quot;iforce-packets.c: control_playback %d %d\n&quot;, id, value);<br>-<br> 	data[0] = LO(id);<br> 	data[1] = (value &gt; 0) ? ((value &gt; 1) ? 0x41 : 0x01) : 0;
<br> 	data[2] = LO(value);<br>@@ -151,7 +150,7 @@ static int mark_core_as_ready(struct iforce *iforce, unsigned short addr)<br> 			return 0;<br> 		}<br> 	}<br>-	printk(KERN_WARNING &quot;iforce-packets.c: unused effect %04x updated !!!\n&quot;, addr);
<br>+	warn(&quot;unused effect %04x updated !!!&quot;, addr);<br> 	return -1;<br> }<br> <br>@@ -162,7 +161,7 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)<br> 	static int being_used = 0;
<br> <br> 	if (being_used)<br>-		printk(KERN_WARNING &quot;iforce-packets.c: re-entrant call to iforce_process %d\n&quot;, being_used);<br>+		warn(&quot;re-entrant call to iforce_process %d&quot;, being_used);<br> 	being_used++;
<br> <br> #ifdef CONFIG_JOYSTICK_IFORCE_232<br>@@ -266,7 +265,7 @@ int iforce_get_id_packet(struct iforce *iforce, char *packet)<br> 			return -1;<br> 		}<br> #else<br>-		printk(KERN_ERR &quot;iforce_get_id_packet: iforce-&gt;bus = USB!\n&quot;);
<br>+		err(&quot;iforce_get_id_packet: iforce-&gt;bus = USB!&quot;);<br> #endif<br> 		break;<br> <br>@@ -284,13 +283,12 @@ int iforce_get_id_packet(struct iforce *iforce, char *packet)<br> 			return -1;<br> 		}<br> #else
<br>
-		printk(KERN_ERR &quot;iforce_get_id_packet: iforce-&gt;bus = SERIO!\n&quot;);<br>+		err(&quot;iforce_get_id_packet: iforce-&gt;bus = SERIO!&quot;);<br> #endif<br> 		break;<br> <br> 	default:<br>-		printk(KERN_ERR &quot;iforce_get_id_packet: iforce-&gt;bus = %d\n&quot;,
<br>-		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iforce-&gt;bus);<br>+		err(&quot;iforce_get_id_packet: iforce-&gt;bus = %d&quot;, iforce-&gt;bus);<br> 		break;<br> 	}<br> <br>diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-
serio.c<br>index ec4be53..7b4bc19 100644<br>--- a/drivers/input/joystick/iforce/iforce-serio.c<br>+++ b/drivers/input/joystick/iforce/iforce-serio.c<br>@@ -2,7 +2,7 @@<br>&nbsp;&nbsp;* $Id: iforce-serio.c,v 1.4 2002/01/28 22:45:00 jdeneux Exp $
<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2001 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">vojtech@ucw.cz</a>&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001 Johann Deneux &lt;
<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>&gt;
<br>+ *&nbsp;&nbsp;Copyright (c) 2001, 2007 Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">johann.deneux@gmail.com</a>&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.
<br>&nbsp;&nbsp;*/<br>diff --git a/drivers/input/joystick/iforce/iforce-
usb.c b/drivers/input/joystick/iforce/iforce-usb.c<br>index 80cdebc..750099d 100644<br>--- a/drivers/input/joystick/iforce/iforce-usb.c<br>+++ b/drivers/input/joystick/iforce/iforce-usb.c<br>@@ -2,7 +2,7 @@<br>&nbsp;&nbsp;* $Id: iforce-usb.c


,v 1.16 2002/06/09 11:08:04 jdeneux Exp $<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2002 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">vojtech@ucw.cz</a>

&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001-2002 Johann Deneux &lt;<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
deneux@ifrance.com</a>&gt;<br>+ *&nbsp;&nbsp;Copyright (c) 2001-2002, 2007 Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">johann.deneux@gmail.com</a>

&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.<br>&nbsp;&nbsp;*/<br>
@@ -65,7 +65,7 @@ void iforce_usb_xmit(struct iforce *iforce)<br> 	XMIT_INC(iforce-&gt;xmit.tail, n);<br> <br> 	if ( (n=usb_submit_urb(iforce-&gt;out, GFP_ATOMIC)) ) {<br>-		printk(KERN_WARNING &quot;iforce-usb.c: iforce_usb_xmit: usb_submit_urb failed %d\n&quot;, n);
<br>+		warn(&quot;usb_submit_urb failed %d\n&quot;, n);<br> 	}<br> <br> 	/* The IFORCE_XMIT_RUNNING bit is not cleared here. That&#39;s intended.<br>@@ -110,7 +110,7 @@ static void iforce_usb_out(struct urb *urb)<br> 	struct iforce *iforce = urb-&gt;context;
<br> <br> 	if (urb-&gt;status) {<br>-		printk(KERN_DEBUG &quot;iforce_usb_out: urb-&gt;status %d, exiting&quot;, urb-&gt;status);<br>+		dbg(&quot;urb-&gt;status %d, exiting&quot;, urb-&gt;status);<br> 		return;<br> 	}<br>


 <br>@@ -190,10 +190,9 @@ fail:<br> /* Called by iforce_delete() */<br> void iforce_usb_delete(struct iforce* iforce)<br> {<br>-	usb_unlink_urb(iforce-&gt;irq);<br>-/* Is it ok to unlink those ? */<br>-	usb_unlink_urb(iforce-&gt;out);
<br>-	usb_unlink_urb(iforce-&gt;ctrl);<br>+	usb_kill_urb(iforce-&gt;irq);<br>+	usb_kill_urb(iforce-&gt;out);<br>+	usb_kill_urb(iforce-&gt;ctrl);<br> <br> 	usb_free_urb(iforce-&gt;irq);<br> 	usb_free_urb(iforce-&gt;out);<br>


diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h<br>index ffaeaef..dadcf4f 100644<br>--- a/drivers/input/joystick/iforce/iforce.h<br>+++ b/drivers/input/joystick/iforce/iforce.h
<br>@@ -2,7 +2,7 @@<br>&nbsp;&nbsp;* $Id: iforce.h,v 1.13 2002/07/07 10:22:50 jdeneux Exp $<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;Copyright (c) 2000-2002 Vojtech Pavlik &lt;<a href="mailto:vojtech@ucw.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

vojtech@ucw.cz</a>&gt;<br>- *&nbsp;&nbsp;Copyright (c) 2001-2002 Johann Deneux &lt;
<a href="mailto:deneux@ifrance.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">deneux@ifrance.com</a>&gt;<br>+ *&nbsp;&nbsp;Copyright (c) 2001-2002, 2007 Johann Deneux &lt;<a href="mailto:johann.deneux@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

johann.deneux@gmail.com</a>&gt;<br>&nbsp;&nbsp;*<br>&nbsp;&nbsp;*&nbsp;&nbsp;USB/RS232 I-Force joysticks and wheels.
<br>&nbsp;&nbsp;*/<br>
</span></div></blockquote></div><br>

------=_Part_108632_8931978.1174168258917--
