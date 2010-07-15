From: Oliver Neukum <oneukum@suse.de>
Subject: [0/3]power management for usbtouchscreens
Date: Thu, 15 Jul 2010 15:56:27 +0200
Message-ID: <201007151556.27284.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231Ab0GON5O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 09:57:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Petr =?utf-8?q?=C5=A0tetiar?= <ynezz@true.cz>

Hi,

this series implements power management in form of suspend/resume
and reset_resume() for USB touchscreens. For devices that can live with=
out
constant communication runtime power management is also implemented.
Support for reset_resume() required splitting up device initialization =
in two
parts. Allocations are not repeated upon reset_resume(); initializing t=
he
hardware is repeated.

Many thanks to Petr =C5=A0tetiar for testing.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
