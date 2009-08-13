From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add EV_IR bit
Date: Wed, 12 Aug 2009 23:49:40 -0700
Message-ID: <20090813072023.7BCC9526EC9@mailhub.coreip.homeip.net>
References: <20090812223327.GA6827@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:6128 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZHMGto (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 02:49:44 -0400
Received: by rv-out-0506.google.com with SMTP id f6so187311rvb.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2009 23:49:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090812223327.GA6827@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org

On Thu, Aug 13, 2009 at 12:33:27AM +0200, David H=E4rdeman wrote:
> This patch adds an EV_IR bit to allow input drivers to let userspace =
=20
> know that the hardware is an infrared remote control transceiver.
>
> No dev->irbit is defined yet but I plan to add that later (which woul=
d =20
> be used to indicate whether the hardware supports RX, TX, etc).
>
> If the patch is accepted I'll send followup patches adding the =20
> appropriate input_set_capability call to the relevant drivers.
>

Do you expect devices to actually _send_ EV_IR events?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
