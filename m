From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] input: Add support for filtering input events
Date: Thu, 6 Aug 2009 16:18:08 -0300
Message-ID: <20090806191808.GE15867@khazad-dum.debian.net>
References: <1249007207-27392-1-git-send-email-mjg@redhat.com>
 <20090803170453.F0DF9526EA5@mailhub.coreip.homeip.net>
 <20090804100158.GA14530@srcf.ucam.org>
 <20090805044923.6AE71526EA5@mailhub.coreip.homeip.net>
 <20090806124910.GA15867@khazad-dum.debian.net>
 <20090806144817.6E610526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33695 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756512AbZHFTYs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2009 15:24:48 -0400
Content-Disposition: inline
In-Reply-To: <20090806144817.6E610526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 06 Aug 2009, Dmitry Torokhov wrote:
> >But don't we have a crapload of implementation weirdness work-
> >arounds in the
> >i8042 drivers, including some for problems with the raw protocol
> >itself?  We
> >wouldn't want to duplicate THAT...
> 
> There actually not many quirks there, once we identified all ports
> on i8042; mostly we need to deal with keys not sending release
> events.
> 
> >will the filter be placed somewhere that
> >doesn't have to deal with that kind of bogosity?
> 
> The problem with doing this on input core level is that we don't

It doesn't have to be on the input core, it could be on i8042, but the
hook should be AFTER i8042 did all the processing and cleanup that we
want to take place...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
