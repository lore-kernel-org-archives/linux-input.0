From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: Add driver for ION iCade
Date: Wed, 31 Oct 2012 12:17:37 +0100
Message-ID: <1351682257.14430.3.camel@sirocco.hadess.net>
References: <1351681810.14430.1.camel@sirocco.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54154 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934387Ab2JaLRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 07:17:41 -0400
In-Reply-To: <1351681810.14430.1.camel@sirocco.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@gmail.com, Jiri Kosina <jkosina@suse.cz>

Em Wed, 2012-10-31 =C3=A0s 12:10 +0100, Bastien Nocera escreveu:
> Add a driver for the ION iCade mini arcade cabinet [1]. The device
> generates a key press and release for each joystick movement or
> button press or release. For example, moving the stick to the
> left will generate the "A" key being pressed and the released.
                                                   ^^^
Should be "then".

> A list of all the combinations is available in the iCade
> developer guide [2].
>=20
> This driver hides all this and makes the device work as a generic
> joystick.
>=20
> [1]: http://www.ionaudio.com/products/details/icade
> [2]: http://www.ionaudio.com/downloads/iCade_Dev_Resource_v1.3.pdf

Latest version of the devel guide is:
http://www.ionaudio.com/downloads/ION%20Arcade%20Dev%20Resource%20v1.5.=
pdf

Let me know if you want a new patch for those.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
