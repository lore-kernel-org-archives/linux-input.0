From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
 ac97 with its private field
Date: Fri, 25 Apr 2008 12:18:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804251212120.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
 <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
 <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz> <s5hve26v0aw.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804251008270.7882@tm8103.perex-int.cz> <s5hprsel2da.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804251134010.7882@tm8103.perex-int.cz> <s5hfxtal05k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:49594 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756215AbYDYKSO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 06:18:14 -0400
In-Reply-To: <s5hfxtal05k.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> > > > I see. In this case, I would propose to add a 32-bit "magic" at the 
> > > > start of 'void *' data. How about this modification:
> > > 
> > > The magic number sounds OK, but funky cast to integer pointer is bad.
> > > If you have a long or a pointer after int, you can have an alignment
> > > problem on 64bit archs, for example.
> > 
> > Not really. First 32-bit word has offset 0 and next 64-bit word has offset 
> > 8 on x86-64. So alignment is OK.
> 
> No, suppose the data like
> 
> 	int magic;
> 	void *ptr;
> 
> and the code to retrive the magic is
> 
> 	magic = *(int*)device_data;
> 
> and thus the next data pointer is (int*)device_data + 1.
> This doesn't work.

+ 1 does not work, but driver can define own private structure and it will 
work. The point is that 32-bit magic must be always at offset 0.

> > Anyway, I agree that with a struct, code is more readable without hidden 
> > things. Also, drivers can define own struct with magic member as first.
> > 
> > Here is corrected patch:
> 
> Hm, but this allows you pass only one value and has an ugly union.

As I mentioned, this structure can be redefined. I can imagine, that 
drivers won't use predefined structure and create own like:

struct mydata {
	unsigned int magic;	/* required */
	unsigned long value1;
	char *name;
	int somevalue;
};

The only required thing is to have 32-bit magic value at offset 0.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

