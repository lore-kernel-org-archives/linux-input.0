From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
Date: Sat, 26 Sep 2009 22:51:11 +0530
Message-ID: <5d5443650909261021v298d925cn1d4c08c9ef81517f@mail.gmail.com>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
	 <20090926095447.GC1331@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:58802 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZIZRVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Sep 2009 13:21:12 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1234531qwd.37
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2009 10:21:15 -0700 (PDT)
In-Reply-To: <20090926095447.GC1331@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: jsgood.yang@samsung.com, Kyeongil Kim <ki0351.kim@samsung.com>, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

Hi Pavel,

On Sat, Sep 26, 2009 at 3:24 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2009-09-09 20:11:03, jsgood.yang@samsung.com wrote:
>> From: Jinsung Yang <jsgood.yang@samsung.com>
>>
>> Add support for Samsung matrix keypad driver
>
> Could generic matrix keyboard driver be used instead?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pavel

Just looking at initial lines of code of this driver, matrix gpio
keypad driver doesn't fit the need, because this driver is based on
keypad controller on SoC and not through gpios.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
