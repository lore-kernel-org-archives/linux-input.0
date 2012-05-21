From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Add LED selector control for Wacom Intuos4
 WL
Date: Mon, 21 May 2012 15:08:56 +0100
Message-ID: <5dc3b5b61e2776c46cbd97c82f88c870.squirrel@webmail.firszt.eu>
References: <1336674232-5410-1-git-send-email-przemo@firszt.eu>
    <alpine.LNX.2.00.1205111448350.17928@pobox.suse.cz>
    <alpine.DEB.2.00.1205191905430.24674@chino.kir.corp.google.com>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:48070 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757420Ab2EUOJE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 10:09:04 -0400
In-Reply-To: <alpine.DEB.2.00.1205191905430.24674@chino.kir.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Przemo Firszt <przemo@firszt.eu>, pinglinux@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net


Dnia 20 Maja 2012, 3:11 am, N, David Rientjes napisa=B3(a):
> On Fri, 11 May 2012, Jiri Kosina wrote:
>
>> > Add sysfs attribute to control LED selector on Wacom Intuos4.
>>
>> Applied, thanks.
>>
>
> This results in a build failure if you've enabled CONFIG_HID_WACOM wi=
thout
> CONFIG_NEW_LEDS, which is required for CONFIG_LEDS_CLASS.
>
[..]
Thanks for catching that!
--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
