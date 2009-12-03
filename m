From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Thu, 3 Dec 2009 08:54:22 -0200
Message-ID: <20091203105422.GC32571@khazad-dum.debian.net>
References: <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
 <20091203075404.GK9121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43976 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654AbZLCKyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2009 05:54:19 -0500
Content-Disposition: inline
In-Reply-To: <20091203075404.GK9121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 02 Dec 2009, Dmitry Torokhov wrote:
> On Thu, Dec 03, 2009 at 08:45:16AM +0100, Corentin Chary wrote:
> > This keycode could be used in a lot of platform specific drivers.
> > For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
> > drivers (bt/wl: off/off, on/off, off/on, on/on).
> > 
> > Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
> > are rarely used.
> 
> Is there any application support for such cycling? IOW does anyone cares
> to do such cycling?

Well, the default ThinkPad behaviour would be to cycle as well, and I'd use
this new keycode if it becomes available.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
