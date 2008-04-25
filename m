From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
 ac97 with its private field
Date: Fri, 25 Apr 2008 09:10:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
 <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
 <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:39872 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbYDYHKd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 03:10:33 -0400
In-Reply-To: <s5h8wz24dto.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> Hm, indeed it's more than a single value...
> 
> For multiple anonymous data, we can use a data with a key like below:
> 
> 	struct device_hint {
> 		char *key;
> 		void *data;
> 		struct list_head list;
> 	};
> 
> and the controller driver assigns the data like
> 
> 	controller_init()
> 	{
> 		...
> 		controller.hint.key = "ucb1000-irq";
> 		controller.hint.data = whatever;
> 		list_add(&controller.hint. &ac97->device_hint_list);
> 		...
> 	}
> 
> and the device driver retrieves the data like
> 
> 	device_init()
> 	{
> 		struct device_hint *hint;
> 		hint = device_hint_get(&ac97->device_hint_list, "ucb1000-irq");
> 		if (hint) {
> 			whatever = hint->data;
> 			...
> 		}
> 	}
> 
> where device_hint_get() is defined like
> 
> 	struct device_hint *device_hint_get(struct device_hint *head,
> 			const char *key)
> 	{
> 		struct device_hint *hint;
> 		list_for_each_entry(hint, head, list)
> 			if (!strcmp(hint, key))
> 				return hint;
> 		return NULL;
> 	}
> 
> Of course, we can cast via container_of() to a container type instead
> of using a void pointer there.
> 
> This is obviously an overweight for a single use-case, but if we have
> more and more complex ones, maybe worth to consider.

Sure. I applied the simple 'void *device_private_data' patch, because 
current usage request is really trivial. We can implement complex code to 
handle data for multiple "extra" devices on AC97 bus later.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

