From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: define KEY_WWAN for Wireless WAN
Date: Wed, 4 Dec 2013 09:10:30 -0800
Message-ID: <20131204171029.GC8838@core.coreip.homeip.net>
References: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50773 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab3LDRKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Dec 2013 12:10:33 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so23972049pbb.30
        for <linux-input@vger.kernel.org>; Wed, 04 Dec 2013 09:10:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Hauke Mehrtens <hauke@hauke-m.de>

Hi Rafal,

On Thu, Nov 28, 2013 at 07:42:53PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> Some devices with support for mobile networks may have buttons for
> enabling/disabling such connection. An example can be Linksys router
> 54G3G.
> We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sense
> to add KEY_WWAN as well.

Isn't WiMAX an implementation of WWAN? Maybe instead of adding a new
keycode we should use KEY_WIMAX code and alias KEY_WIMAX to KEY_WWAN to
preserve ABI?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
