From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: suspend / hibernate nomenclature
Date: Mon, 2 Mar 2009 08:24:00 -0300
Message-ID: <20090302112400.GA2356@khazad-dum.debian.net>
References: <1235992429.3858.58.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34204 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753878AbZCBLYG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 06:24:06 -0500
Content-Disposition: inline
In-Reply-To: <1235992429.3858.58.camel@hughsie-work.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Mon, 02 Mar 2009, Richard Hughes wrote:
> standby = sleep CPU and devices (not really used any more)
> suspend = sleep to memory (quite fast)
> hibernate = sleep to disk (slow)
> hybrid = sleep to both (slow, but fast resume)
> 
> In X, and evdev we've also fixed the mapping, so that:
> 
> XF86Sleep : suspend _or_ hibernate (configured in session policy)
> XF86Suspend: suspend
> XF86Hibernate: hibernate

And when hybrid is to be used it gets hooked to hibernate, correct?

> I propose that we add a KEY_HIBERNATE (key 247), and then we can just
> do:
> 
> KEY_HIBERNATE -> XF86Hibernate -> sleep to disk
> KEY_SUSPEND   -> XF86Suspend   -> sleep to ram
> KEY_SLEEP     -> XF86Sleep     -> sleep (configurable)

I'd like that.

I'd also like a LOT if proper documentation were added next to the
KEY_ defines...

> Then the drivers can be patched so everyone is doing the same thing. At
> the moment I'm diagnosing bugs and trying to work around the brokenness
> in userspace hal-info every few days, and it's getting tiresome.
> 
> Feedback welcome, although please don't comment on things like "suspend
> sounds more like a suspend to disk" as we spent years talking with
> userspace people working for a compromise, and this is what we've
> settled on. It's not to everyones taste, but we _do_ need to agree on
> something, even if its just an agreed bodge.
> 
> Would patches be accepted to fix this?

FWIW, I think it is a good idea, and I'd take patches for
thinkpad-acpi.

But I would appreciate that the commit log discloses the userspace
versions of stuff like HAL that have the desired behaviour.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
