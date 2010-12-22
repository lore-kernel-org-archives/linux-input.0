From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Wed, 22 Dec 2010 18:15:20 +0200
Message-ID: <20101222161520.GD5882@esdhcp04044.research.nokia.com>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <20101213085143.GE21401@core.coreip.homeip.net> <4D088CC0.9080402@nokia.com> <20101216075716.GD26567@core.coreip.homeip.net> <4D11B9DF.4050107@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 87-119-183-111.tll.elisa.ee ([87.119.183.111]:4062 "EHLO
	bazspaz.fatphil.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754094Ab0LVQ01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 11:26:27 -0500
Content-Disposition: inline
In-Reply-To: <4D11B9DF.4050107@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, kwlee@mtekvision.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

On 22/12/10 10:42 +0200, Srikar wrote:
> Hi Torkhov ,

(FYI, Torokhov is Dmitry's surname (family name), and I know that if 
I'm being addressed by just one name, I much prefer my first name, 
not my surname.)

>            Other differences between tsc2005 and tsc2007 driver are
> request_threaded_irq is being used by tsc2005 and request_irq is being
> used by tsc2007.

The tsc2005 driver used in recent nokia linux devices did not have
the request_threaded_irq(). The move to a threaded IRQ (and the removal
of stuff whose presence in low-level drivers has been debated) was 
done purely to make this driver more upstreamable by using the cleanest
and simplest architecture now available, which wasn't available in the 
kernel we were using.

So, Dmitry, we were, and are, trying to make it easier for you to accept, 
honest ;-)

>         Similar  type there are other differences in the both code where
> tsc200x core need to implemented  other then bus access methods,need to
> discuss with tsc2007 driver to make it common implementation for both
> drivers.More over added the kwlee@mtekvision.com who is contributor for
> tsc2007 driver which is also need to modified for to tsc200x and
> tsc2007.c.To adapt requires comments and discussion with kwlee and Lauri.

I think Lauri might be a little out of the loop currently. He's marked
as the author of the driver because historically the code was an evolution
of his tsc2003 (or similar) driver. He might not recognise the code any 
more, I don't know.

Phil

