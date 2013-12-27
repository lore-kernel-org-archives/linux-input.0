From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: kernel panic on gpio-keys
Date: Thu, 26 Dec 2013 17:56:58 -0800
Message-ID: <20131227015658.GA20756@core.coreip.homeip.net>
References: <52A8BA49.7080507@gmail.com>
 <20131214093900.GA10799@core.coreip.homeip.net>
 <52B06B0E.20501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42079 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab3L0B5B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 20:57:01 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so8585427pdi.10
        for <linux-input@vger.kernel.org>; Thu, 26 Dec 2013 17:57:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52B06B0E.20501@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <pcercuei@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Tue, Dec 17, 2013 at 04:17:34PM +0100, Paul Cercueil wrote:
> On 14/12/2013 10:39, Dmitry Torokhov wrote:
> >On Wed, Dec 11, 2013 at 08:17:29PM +0100, Paul Cercueil wrote:
> >>Hi there,
> >>
> >>I am trying to use the gpio-keys driver to inject joystick events.
> >>There seems to be some basic support of it, looking at <linux/gpio_keys.h>.
> >>
> >>However, registering the following will trigger a kernel panic in
> >>the kernel:
> >>
> >>static struct gpio_keys_button my_buttons[] {
> >>	{
> >>		.gpio = GPIO_FOO,
> >>		.type = EV_ABS,
> >>		.code = ABS_HAT0X,
> >>		.value = 1,
> >>	},
> >>};
> >>
> >>(tested on kernel 3.12).
> >>
> >>I don't know well the input subsystem, so I have no idea of what is
> >>going wrong. Could anybody try to at least reproduce the issue?
> >
> >It woudl be helpful if you poster the stack trace from panic so we'd
> >have an idea where the fault happens.
> >
> >Thanks.
> >
> 
> Here is the crash log I get: http://pastebin.com/FzTTGxsR
> (I did put it on pastebin because it's huge, 200+ lines).
> 
> The first OOPS happen as soon as the GPIO button is pressed; the
> other ones seem to happen recursively. I included only a part of the
> log I get, as the OOPSes continue to flow until the watchdog kicks
> in.

Hmm, I have an idea: this driver is one of few that does not use
input_set_abs_info() and this does not allocate memory for absinfo data
that input core uses to handle absolute events.

Does the patch below work for you?

Thanks.

-- 
Dmitry

Input: allocate absinfo data when setting ABS capability

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We need to make sure we allocate absinfo data when we are setting one of
EV_ABS/ABS_XXX capabilities, otherwise we may bomb when we try to emit this
event.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 692435a..1c4c0db 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1909,6 +1909,10 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
 		break;
 
 	case EV_ABS:
+		input_alloc_absinfo(dev);
+		if (!dev->absinfo)
+			return;
+
 		__set_bit(code, dev->absbit);
 		break;
 
