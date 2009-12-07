From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Mon, 7 Dec 2009 09:47:49 -0200
Message-ID: <20091207114749.GD20076@khazad-dum.debian.net>
References: <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
 <20091203075404.GK9121@core.coreip.homeip.net>
 <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
 <20091206065829.GI5340@wrars-comp.wrarsdomain>
 <20091206071751.GD14651@core.coreip.homeip.net>
 <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com>
 <20091206145415.GA16414@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42420 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933740AbZLGLrp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Dec 2009 06:47:45 -0500
Content-Disposition: inline
In-Reply-To: <20091206145415.GA16414@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Sun, 06 Dec 2009, Matthew Garrett wrote:
> On Sun, Dec 06, 2009 at 09:21:12AM +0100, Corentin Chary wrote:
> > Old xandros builds use the acpi event.
> > New builds have switched to eeepc-laptop (based on my 2.6.30
> > backport), so they may use an input event (KEY_WLAN).
> 
> Yeah. We should probably change that to KEY_RFKILL once that lands.

Depends on what is being done in userspace to the other KEY_(radio type).

What I do know, is that I will miss a keycode that rfkills just my WLAN... I
use that for power management, it is nice to have a key that is for WLAN
only, and another that is for bluetooth-only...

It is a pity KEY_RFKILL is arriving too late to avoid the loss of KEY_WLAN
(or is it?)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
