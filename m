From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: Atmel updates to atmel_mxt_ts touch controller driver
Date: Fri, 22 Feb 2013 21:19:24 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1302222111420.1668@pmeerw.net>
References: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60509 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423Ab3BVUTZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Feb 2013 15:19:25 -0500
In-Reply-To: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@chromium.org, olofj@chromium.org

Hello Nick,

> These changes address some of the same issues that appear in the patchsets
> submitted by Daniel Kurtz and Peter Meerwald. However, they go much further in
> adding support for new objects, improving performance, and increasing
> reliability. They have been regularly regression tested against old and new
> chips which use the same protocol.

the series gets rid of the fragile binary config data and 
handle_pdata() - I like it, but haven't tested yet

is there a reference to the specification of the new config format?
the format of the old pdata->config was immediately obvious from reading 
the source, the new way not so much...

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
