From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Mon, 16 Aug 2010 17:30:13 +0200
Message-ID: <4C695985.5080403@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:49517 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385Ab0HPRKz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 13:10:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?U3TDqXBoYW5lIENoYXR0eQ==?= <chatty@intuilab.com>
Cc: linux-input <linux-input@vger.kernel.org>

St=C3=A9phane, Jiri,

Regarding the several-hid-packets-per-actual-input-packet problem, what=
 do you
think about constructing a special MT HID device, using raw_event? It c=
ould
encapsulate the current protocol a bit better and use the full HID exte=
nsion.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
