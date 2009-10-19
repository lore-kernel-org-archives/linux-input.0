From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Bugme-new] [Bug 14421] New: CH Products joystick detected but not functional
Date: Mon, 19 Oct 2009 16:34:08 +0200
Message-ID: <200910191634.09047.oliver@neukum.org>
References: <200910191526.30825.oliver@neukum.org> <4ADC6FE5.2000706@signatureresearchinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:43276 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbZJSOcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 10:32:10 -0400
In-Reply-To: <4ADC6FE5.2000706@signatureresearchinc.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Keith Rutkowski <rutkowski@signatureresearchinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

Am Montag, 19. Oktober 2009 15:55:49 schrieb Keith Rutkowski:
> I have not found any patches for this specific device. =A0It is an
> industrial class joystick, so probably not as common as the CH Produc=
ts
> consumer class joysticks.
>
> However, this patch seems to address a similar issue with other more
> common CH Products joysticks:

Yes, that's the patch. Could you try to also add your device to the bla=
cklist?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
