From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Thu, 23 Jun 2011 07:25:37 -0600
Message-ID: <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
 <1308823455-14446-2-git-send-email-david@protonic.nl> <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
 <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab1FWNZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 09:25:59 -0400
Received: by gyh3 with SMTP id 3so705652gyh.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 06:25:59 -0700 (PDT)
In-Reply-To: <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
>> > + =A0 =A0 =A0 - gpios: OF devcie-tree gpio specificatin.
>> > + =A0 =A0 =A0 - label: Descriptive name of the key.
>> > + =A0 =A0 =A0 - linux,code: Keycode to emit.
>>
>> The fact that this is the Linux internal keycode definitions still
>> makes me nervous. =A0Is there no existing standard for keycodes emit=
ted
>> by keyboard devices?
>
> There is but no standard lookup table. For Intel MID we do a translat=
ion
> between Linux key names in the firmware and keycodes but there isn't =
a
> generic helper for it.

I suppose the Linux keycodes are exported out to userspace, and are
therefore an ABI which will not change.  Okay.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
