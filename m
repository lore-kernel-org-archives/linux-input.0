From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: HID generic-bluetooth driver
Date: Sun, 8 May 2011 14:20:40 +0200
Message-ID: <BANLkTim7BJHV528DvJZvSnzmTzFjn=4qSw@mail.gmail.com>
References: <BANLkTi=tUNCMyCKVEXtv0W=8jYbK-k7HMg@mail.gmail.com>
	<1304855553.4742.3.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62376 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1EHMUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2011 08:20:41 -0400
Received: by vxi39 with SMTP id 39so4863925vxi.19
        for <linux-input@vger.kernel.org>; Sun, 08 May 2011 05:20:40 -0700 (PDT)
In-Reply-To: <1304855553.4742.3.camel@mars>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Sun, May 8, 2011 at 1:52 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> =A0you can add it to hid_have_special_driver[] (drivers/hid/hid-core.=
c).
>

Since I cannot see any MODULE_DEVICE_TABLE() entry there, I guess I
can't extend this table on runtime?

Adding my device there helped. Thank you.

>
> Thanks,
> =A0-- chf

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
