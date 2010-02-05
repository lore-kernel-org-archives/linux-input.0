From: <samu.p.onkalo@nokia.com>
Subject: RE: [RFC] Generic implementation for Input enable disable methods
Date: Fri, 5 Feb 2010 08:38:41 +0100
Message-ID: <62697B07E9803846BC582181BD6FB6B8257283DAC4@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1263968920.18053.24.camel@4fid08082>
 <1264141700.2889.14.camel@4fid08082>
 <20100201085901.GC24188@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18185 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933310Ab0BEHi4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 02:38:56 -0500
In-Reply-To: <20100201085901.GC24188@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, ext-mika.1.westerberg@nokia.com, ext-jani.1.nikula@nokia.com

>-----Original Message-----
>From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>
>Hi Samu,
>
>I still believe that the only thing we need (apart of special plumbing
>in
>gpio-keys) is a way for userspace clients to subsribe on unsubscribe
>from certain events rather than device-wide configuration. This way we
>can avoid waking up processes that are not interested in some of the
>events.
>

Hi Dmitry,

I just noticed that control interface for gpio was applied to input-tree.
We still have a need to disable hw in certain cases. It is probably better
to forget generic implementation to input core and make control interface
as specific to each driver like proposed some months ago for example
for tel4030-keypad driver. Or what do you think?

Sw filtering which avoids to wakeup some processes is not proper solution
to embedded devices. We need to avoid waking up the processor itself.

Br,
Samu




