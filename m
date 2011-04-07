From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Thu, 7 Apr 2011 19:45:51 +0200
Message-ID: <201104071945.52232.alexander.stein@informatik.tu-chemnitz.de>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de> <201104031021.26509.alexander.stein@informatik.tu-chemnitz.de> <20110405183651.GD13086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:33934 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754165Ab1DGRps (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Apr 2011 13:45:48 -0400
In-Reply-To: <20110405183651.GD13086@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday 05 April 2011 20:36:52 Dmitry Torokhov wrote:
> Hi Alexander,
> 
> On Sun, Apr 03, 2011 at 10:21:26AM +0200, Alexander Stein wrote:
> > Hello Dimitry,
> > 
> > On Sunday 03 April 2011 06:23:05 Dmitry Torokhov wrote:
> > > On Sat, Apr 02, 2011 at 10:31:53AM +0200, Alexander Stein wrote:
> > > > Hello Dimitry,
> > > > 
> > > > On Wednesday 16 March 2011 07:36:18 Dmitry Torokhov wrote:
> > > > > On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> > > > > > On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > > > > > > This patch adds a generic driver for slide switches connected
> > > > > > > to GPIO pins of a system. It requires gpiolib and generic
> > > > > > > hardware irqs.
> > > > > 
> > > > > Hm, can't it be merged with gpio_keys? Just add the 'value' to the
> > > > > gpio_keys_button structure that would be valid for EV_ABS (or even
> > > > > EV_REL) types. Debouncing should filter out jittery events...
> > > > 
> > > > Sorry, for no answer long time.
> > > > I just tried merging both. The problem i noticed is that the PGIO
> > > > interrupts are independable and each GPIO will generate an event,
> > > > which is wrong. Assume the switch state change from position 2 to 1
> > > > it will actually generate lots of interrupts: e.g. 2, 1, 2, 1.
> > > > Depending from the order of such interrupts the last event shows a
> > > > possible wrong position.
> > > 
> > > However at some point the output should stabilize. Does not setting
> > > appropriate debouncing interval help here?
> > 
> > Well, a debounce interval will prevent to get events for position 2, 1,
> > 2, 1 (from the example above). You will get only 2 and 1.
> 
> No, if the switch settles in position 2 then we will report only 2. I.e.
> if you set debounce interval for 200 msecs for all gpios at the end of
> this period gpio representing "1" position will not be active so you
> will not send any event for it. The gpio representing "2" will still be
> active and thus you will send ABS_whatever/2.

Mh, i think you had a slightly different implementation in mind than me.

> > The debounce will only decrease the amount of events for _each_ GPIO
> > interrupt. It will not prevent GPIO interrupts from different pins while
> > moving the switch one position.
> 
> It will not prevent interrupts but should prevent unstable events. It
> might be beneficial if you posted the code you tried and we'd see why
> debouncing does not work for you.

Here we go:

diff --git a/drivers/input/keyboard/gpio_keys.c 
b/drivers/input/keyboard/gpio_keys.c
index eb30063..544db8f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -324,7 +324,10 @@ static void gpio_keys_report_event(struct 
gpio_button_data *bdata)
 	unsigned int type = button->type ?: EV_KEY;
 	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button-
>active_low;
 
-	input_event(input, type, button->code, !!state);
+	if ((type == EV_ABS) || (type == EV_REL))
+		input_event(input, type, button->code, button->value);
+	else
+		input_event(input, type, button->code, !!state);
 	input_sync(input);
 }
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index dd1a56f..3cfb26f 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -8,6 +8,7 @@ struct gpio_keys_button {
 	int active_low;
 	char *desc;
 	int type;		/* input event type (EV_KEY, EV_SW) */
+	int value;		/* axis value for EV_ABS and EV_REL */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
 	bool can_disable;

Regards,
Alexander
