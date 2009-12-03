From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Wed, 2 Dec 2009 23:54:04 -0800
Message-ID: <20091203075404.GK9121@core.coreip.homeip.net>
References: <1259826317-18809-24-git-send-email-corentincj@iksaif.net> <1259826317-18809-25-git-send-email-corentincj@iksaif.net> <1259826317-18809-26-git-send-email-corentincj@iksaif.net> <1259826317-18809-27-git-send-email-corentincj@iksaif.net> <1259826317-18809-28-git-send-email-corentincj@iksaif.net> <1259826317-18809-29-git-send-email-corentincj@iksaif.net> <1259826317-18809-30-git-send-email-corentincj@iksaif.net> <1259826317-18809-31-git-send-email-corentincj@iksaif.net> <1259826317-18809-32-git-send-email-corentincj@iksaif.net> <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:54937 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZLCHyC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 02:54:02 -0500
Content-Disposition: inline
In-Reply-To: <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 08:45:16AM +0100, Corentin Chary wrote:
> This keycode could be used in a lot of platform specific drivers.
> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
> drivers (bt/wl: off/off, on/off, off/on, on/on).
> 
> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
> are rarely used.
> 

Is there any application support for such cycling? IOW does anyone cares
to do such cycling?

-- 
Dmitry
