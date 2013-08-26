From: =?utf-8?Q?Andreas_Lilleb=C3=B8_Holm?= <andreas@sqhead.com>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Mon, 26 Aug 2013 18:16:11 +0200
Message-ID: <7851429DDA1F498899F023F32CC33483@sqhead.com>
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
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48032 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3HZQQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 12:16:15 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so1572136lbh.5
        for <linux-input@vger.kernel.org>; Mon, 26 Aug 2013 09:16:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1308231447440.11021@pobox.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

On Friday, August 23, 2013 at 2:49 PM, Jiri Kosina wrote:
> On Fri, 23 Aug 2013, Benjamin Tissoires wrote:
> =20
> > IIRC, Jiri fixed some paging requests with the two following patche=
s:
> > http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=
=3Dfor-next&id=3D27ce405039bfe6d3f4143415c638f56a3df77dca
> > http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=
=3Dfor-next&id=3Dbc197eedef1ae082ec662c64c3f4aa302821fb7a
> > =20
> > At least, these two patches are related to hid_output_report(). I
> > think they are scheduled for 3.12, so I can not find them in Linus'
> > tree.
> > =20
> > It would worth trying them :)
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
Hi,

You are my hero Jiri :-) These two patches fixes the issues I was seein=
g and I can no longer reproduce them.

I have only tried them on one hardware platform yet; the one that I had=
 failing: Atom Intel e6xx CPU with EG20T PCH platform controller. I hav=
e had approximately 300 boots in our test rigg now and no fails yet. Be=
fore was the failrate 1/25 boots.

I made the kernel based on 3.10.9 stable tag and applied them directly =
on there. I do recommend that these patches makes it way into the stabl=
e tree :-)

Thanks again :)

Best regards
Andreas Lilleb=C3=B8 Holm

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
