From: simon@mungewell.org
Subject: Re: [PATCH v2] HID: lg4ff: Take advantage of private driver data
Date: Mon, 9 Apr 2012 11:53:57 -0400
Message-ID: <a02797a0b907d32e22cc455c57823ae2.squirrel@mungewell.org>
References: <1649210.pcO5IpzBEF@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39788 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2DIPx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Apr 2012 11:53:59 -0400
In-Reply-To: <1649210.pcO5IpzBEF@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org

I tested this against a G27 and WiiWheel and it appears to function
correctly.

I'll shortly send another patch on top of this which enables the LEDs o=
n
the G27. Hopefully this will bring to a close this short series of
patches.

Simon.


> Please note that this patch depends on
> "[PATCH v4] HID: hid-lg: Allow for custom device-specific properties =
to be
> stored in private drv data"
> "[PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating memory=
"
>
> Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

tested-by: Simon Wood <simon@mungewell.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
