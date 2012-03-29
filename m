From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 19/20] Input: atmel_mxt_ts - remove mxt_make_highchg and
 parse T6 report
Date: Thu, 29 Mar 2012 23:20:11 +0800
Message-ID: <CAGS+omBkqBqMC7f73RzXqdwkpqTOxUvWWYLMGefF+zdBKjKLTw@mail.gmail.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-20-git-send-email-djkurtz@chromium.org> <4F68A46D.9020601@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933485Ab2C2PUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 11:20:32 -0400
Received: by iagz16 with SMTP id z16so3148204iag.19
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 08:20:32 -0700 (PDT)
In-Reply-To: <4F68A46D.9020601@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On Tue, Mar 20, 2012 at 11:38 PM, Nick Dyer <nick.dyer@itdev.co.uk> wro=
te:
> Daniel Kurtz wrote:
>> This function attempts to make the CHG pin high by reading a bunch o=
f
>> messages until the device is happy. =A0Instead of just blindly tryin=
g to
>> read a fixed number of messages, let's actually read and process the=
m.
>>
>> It turns out that the messages after boot or nvupdates are T6 report=
s,
>> containing a status, and the config memory checksum. =A0So, let's pa=
rse
>> them and dump a useful info message.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>
> mxt_make_highchg exists due to the interrupts being edge triggered. I=
t
> forces the CHG line to go high.
>
> With this implementation, I suspect that if a new message arrives aft=
er you
> have read T44 and before you finish processing messages, then the int=
errupt
> handler will not ever be run. What testing have you done on this?

Actually, for the MXT224E on which I've been testing, the CHG line
goes high after reading the first byte of the T5 message (in other
words, the first byte of the first message, no matter how many
messages T44 reports).

Expect an updated version of this patchset soon.

Thanks for all of your reviews!

>
> The printout of T6 messages looks OK, though. I'd prefer to see a loo=
kup
> table for the report IDs.
>
> --
> Nick Dyer
> Software Engineer, ITDev Ltd
> Hardware and Software Development Consultancy
> Website: http://www.itdev.co.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
