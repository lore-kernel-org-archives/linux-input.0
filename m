From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Mon, 7 Dec 2009 15:02:57 -0200
Message-ID: <20091207170257.GB5785@khazad-dum.debian.net>
References: <20091203075404.GK9121@core.coreip.homeip.net>
 <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
 <20091206065829.GI5340@wrars-comp.wrarsdomain>
 <20091206071751.GD14651@core.coreip.homeip.net>
 <71cd59b00912060021w6b9c46fem5a4da45f29d370a@mail.gmail.com>
 <20091206145415.GA16414@srcf.ucam.org>
 <20091207114749.GD20076@khazad-dum.debian.net>
 <20091207125553.GA31448@srcf.ucam.org>
 <20091207132334.GG20076@khazad-dum.debian.net>
 <20091207142059.GA32617@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56162 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935442AbZLGRCy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Dec 2009 12:02:54 -0500
Content-Disposition: inline
In-Reply-To: <20091207142059.GA32617@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrey Rahmatullin <wrar@altlinux.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 07 Dec 2009, Matthew Garrett wrote:
> > That's not what I got from this thread.  What I got was that KEY_WLAN would
> > be overloaded with KEY_RFKILL semanthics, regardless of anything we did in
> > the kernel side.
> 
> No.

Good.

> > And, if what we call KEY_WLAN is actually supposed to be KEY_RFKILL, swap
> > their definitions when adding KEY_RFKILL, so that USB HID devices will
> > generate KEY_RFKILL instead of KEY_WLAN.
> 
> I don't think this is in HID?

I don't think it is.  I wrote that along the lines of "even if that were to
happen, there is a way to fix things properly".

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
