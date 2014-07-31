From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: PATCH hid: Implement mode switching on Logitech gaming wheels
 accordingly to the documentation
Date: Thu, 31 Jul 2014 11:20:15 +0200
Message-ID: <CADbOyBQJjnOGfGJ4wwrtX=70V4-rkf_G8_8zP_eTdfD1y-8FYw@mail.gmail.com>
References: <3335238.KGDcEM6DjH@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:47031 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098AbaGaJUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 05:20:17 -0400
In-Reply-To: <3335238.KGDcEM6DjH@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Edwin Velds <edwin@velds.nl>, "simon@mungewell.org" <simon@mungewell.org>, Roland Bosa <rbosa@logitech.com>

On Wed, Jul 30, 2014 at 12:10 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> Implement mode switching on Logitech gaming wheels accordingly to the=
 documentation
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>

Tested all lg4ff_switch_force_mode
modes (0, 1, 2, 3, default), on both:
- MOMO (Black) : PID 0xCA03
- Formula Vibration : PID 0xCA04

Behaviour didn't deviate from normal, which is as expected because
these devices don't use the native versus compatibility mode,
according to the documentation.
So I consider this patch successful for these devices:

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>

Elias
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
