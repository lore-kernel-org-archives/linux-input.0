From: =?utf-8?Q?Andreas_Lilleb=C3=B8_Holm?= <andreas@sqhead.com>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Fri, 23 Aug 2013 14:51:34 +0200
Message-ID: <26F519B5754E471D9CBC217F6B5260B0@sqhead.com>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com>
 <20130813184056.GH7740@kroah.com>
 <16FA42AC8F654C3B81924591E607B342@sqhead.com>
 <20130815063736.GF25754@kroah.com>
 <26E21BF00B944AB6B8F48B5E59B0442D@sqhead.com>
 <CAN+gG=FJSMyQNHcq=0cO1srVpRb_83YihUH0WuAPTcKAJHhv4g@mail.gmail.com>
 <alpine.LNX.2.00.1308231447440.11021@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48294 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab3HWMvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Aug 2013 08:51:47 -0400
Received: by mail-lb0-f181.google.com with SMTP id u12so429280lbd.26
        for <linux-input@vger.kernel.org>; Fri, 23 Aug 2013 05:51:45 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308231447440.11021@pobox.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

> =20
> All three reported oopses happened on page boundary exactly, so this =
=20
> pretty much looks like my implement() fix is the one.
> =20
> Andreas, could you please apply
> =20
> http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=3D=
for-next&id=3D27ce405039bfe6d3f4143415c638f56a3df77dca
> =20
> and report back whether it makes your problem go away?

I will build and test this patch and hopefully it will resolve my issue=
s :)

-- =20
Andreas Lilleb=C3=B8 Holm


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
