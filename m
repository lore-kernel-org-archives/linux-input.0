From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Generic implementation for Input enable disable methods
Date: Fri, 5 Feb 2010 00:10:54 -0800
Message-ID: <201002050010.55524.dmitry.torokhov@gmail.com>
References: <1263968920.18053.24.camel@4fid08082> <20100201085901.GC24188@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B8257283DAC4@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:35572 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab0BEILA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 03:11:00 -0500
Received: by pxi12 with SMTP id 12so3905306pxi.33
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2010 00:11:00 -0800 (PST)
In-Reply-To: <62697B07E9803846BC582181BD6FB6B8257283DAC4@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: linux-input@vger.kernel.org, ext-mika.1.westerberg@nokia.com, ext-jani.1.nikula@nokia.com

On Thursday 04 February 2010 11:38:41 pm samu.p.onkalo@nokia.com wrote:
> >-----Original Message-----
> >From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >
> >Hi Samu,
> >
> >I still believe that the only thing we need (apart of special plumbing
> >in
> >gpio-keys) is a way for userspace clients to subsribe on unsubscribe
> >from certain events rather than device-wide configuration. This way we
> >can avoid waking up processes that are not interested in some of the
> >events.
> 
> Hi Dmitry,
> 
> I just noticed that control interface for gpio was applied to input-tree.
> We still have a need to disable hw in certain cases. It is probably better
> to forget generic implementation to input core and make control interface
> as specific to each driver like proposed some months ago for example
> for tel4030-keypad driver. Or what do you think?
> 
> Sw filtering which avoids to wakeup some processes is not proper solution
> to embedded devices. We need to avoid waking up the processor itself.

I see. I think that such facility should not be limited to input devices
(with the exception of gpio-keys which is a special case since it works
with multiple interrupts). We need a way to allow userspace initiate
putting an arbitrary device to "sleep" and this should be generic
infrastructure.

So you need to talk to PM people again and design such facility with them
since IIRC there wasn't anything like that last time you tried asking that
question.

Thanks.

-- 
Dmitry
