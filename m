From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: kernel panic on gpio-keys
Date: Mon, 30 Dec 2013 10:42:33 -0800
Message-ID: <20131230184233.GA3278@core.coreip.homeip.net>
References: <52A8BA49.7080507@gmail.com>
 <20131214093900.GA10799@core.coreip.homeip.net>
 <52B06B0E.20501@gmail.com>
 <20131227015658.GA20756@core.coreip.homeip.net>
 <52C18D88.9070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45051 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab3L3Smh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 13:42:37 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so11576772pdj.4
        for <linux-input@vger.kernel.org>; Mon, 30 Dec 2013 10:42:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52C18D88.9070707@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <pcercuei@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Mon, Dec 30, 2013 at 04:13:12PM +0100, Paul Cercueil wrote:
> On 27/12/2013 02:56, Dmitry Torokhov wrote:
> >On Tue, Dec 17, 2013 at 04:17:34PM +0100, Paul Cercueil wrote:
> >>On 14/12/2013 10:39, Dmitry Torokhov wrote:
> >>>On Wed, Dec 11, 2013 at 08:17:29PM +0100, Paul Cercueil wrote:
> >>>>Hi there,
> >>>>
> >>>>I am trying to use the gpio-keys driver to inject joystick events.
> >>>>There seems to be some basic support of it, looking at <linux/gpio_keys.h>.
> >>>>
> >>>>However, registering the following will trigger a kernel panic in
> >>>>the kernel:
> >>>>
> >>>>static struct gpio_keys_button my_buttons[] {
> >>>>	{
> >>>>		.gpio = GPIO_FOO,
> >>>>		.type = EV_ABS,
> >>>>		.code = ABS_HAT0X,
> >>>>		.value = 1,
> >>>>	},
> >>>>};
> >>>>
> >>>>(tested on kernel 3.12).
> >>>>
> >>>>I don't know well the input subsystem, so I have no idea of what is
> >>>>going wrong. Could anybody try to at least reproduce the issue?
> >>>
> >>>It woudl be helpful if you poster the stack trace from panic so we'd
> >>>have an idea where the fault happens.
> >>>
> >>>Thanks.
> >>>
> >>
> >>Here is the crash log I get: http://pastebin.com/FzTTGxsR
> >>(I did put it on pastebin because it's huge, 200+ lines).
> >>
> >>The first OOPS happen as soon as the GPIO button is pressed; the
> >>other ones seem to happen recursively. I included only a part of the
> >>log I get, as the OOPSes continue to flow until the watchdog kicks
> >>in.
> >
> >Hmm, I have an idea: this driver is one of few that does not use
> >input_set_abs_info() and this does not allocate memory for absinfo data
> >that input core uses to handle absolute events.
> >
> >Does the patch below work for you?
> >
> >Thanks.
> >
> 
> Hi,
> 
> The patch works just fine, thank you!

Thanks Paul.

-- 
Dmitry
