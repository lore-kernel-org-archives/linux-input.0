From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Mon, 23 Feb 2015 11:10:13 -0300
Message-ID: <1424700613.3136058.231192293.03A600A7@webmail.messagingengine.com>
References: <1424292832.32581.49.camel@hadess.net>
 <20150218233420.GB23265@khazad-dum.debian.net>
 <1424686542.28361.10.camel@hadess.net>
 <1424688591.3045289.231119453.42C70082@webmail.messagingengine.com>
 <1424691695.28361.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41016 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbbBWOKN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 09:10:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B000120A56
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2015 09:10:12 -0500 (EST)
In-Reply-To: <1424691695.28361.15.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Feb 23, 2015, at 08:41, Bastien Nocera wrote:
> > You could opt to change some of those keypresses dinamically into
> > driver-specific
> > ACPI events, by setting the keymap entry to KEY_RESERVED.  The driver
> > will
> > issue HKEY events in that case. That will be an viable alternative for
> > some of the new
> > keys.
> 
> I don't understand what you mean here.

I mean please set anything that you don't have a keycode for in the new
keymaps to either KEY_RESERVED (will issue an HKEY ACPI event) or
KEY_UNKNOWN (will issue an input EV_KEY event for KEY_UNKNOWN grouped
with an EV_MSC EV MSC_SCAN event that allows userspace to know which key
was pressed/released even if it has no specific keycode).

> > The beauty of it is that keymaps are configurable in run-time, so
> > userspace can
> > just set any key entries it wants to change to something else, and ACPI
> > events will be
> > suppressed if the entry is not set to KEY_RESERVED anymore.
> 
> Keymaps are already configurable at run-time, that's how udev changes
> keymaps. Or did you mean something else?

I mean if anyone wants to change something that is KEY_RESERVED or
KEY_UNKNOWN they can configure the driver to do so at runtime through
the input device interface, i.e. get udev to do it.

Nothing new, there.

> > We need to be careful with tpacpi_input_send_key_masked(). If any of the
> > codepaths
> > could call it from the adaptative keyboard handling code,
> 
> But we're not calling it from there, are we?

Probably not, but it would be a good idea to double-check.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
