From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [RFC] ucb1400 touchscreen, irq auto probing and ac97 with its
	private field
Date: Thu, 24 Apr 2008 16:35:00 +0200
Message-ID: <20080424143500.GB26452@Chamillionaire.breakpoint.cc>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <Pine.LNX.4.61.0804241625220.7882@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:36499 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbYDXOfC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 10:35:02 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804241625220.7882@tm8103.perex-int.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>

* Jaroslav Kysela | 2008-04-24 16:32:37 [+0200]:
good morning :)

>On Thu, 24 Apr 2008, Sebastian Siewior wrote:
>
>> I've sent a RFC to the alsa mailing list [1] about adding an extra field 
>> in order to pass the IRQ from the AC97 driver to the ucb1400 driver. The 
>> result was:
>
>The original patch seems to be acceptable. But I would choose a more 
>universal name and 'void *' type like 'void *device_private_data' and 
>specify more the purpose of this member (add USB1400 as example device).
I came to this conclusion after the wmXXX thingi.

>> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006555.html
>
>Could you change and resend your patch?
yes sir.
>
>				Thanks,
>					Jaroslav
>

Sebastian
