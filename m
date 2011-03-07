From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Port of hid-egalax to the unified hid-multitouch driver
Date: Mon, 7 Mar 2011 11:04:14 +0100
Message-ID: <AANLkTikWm3iBwqSTsQZWsLZ4b_q2aScUEo4dW9GJ9Kcz@mail.gmail.com>
References: <1299417883.9645.494.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38383 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab1CGKEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 05:04:15 -0500
Received: by bwz15 with SMTP id 15so3681355bwz.19
        for <linux-input@vger.kernel.org>; Mon, 07 Mar 2011 02:04:14 -0800 (PST)
In-Reply-To: <1299417883.9645.494.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

Hi Richard,

Thank you very much for this work. This reminds me that we have to
switch the other drivers to hid-multitouch too.
Actually, I was not in favor of porting this driver into
hid-multitouch. eGalax has two differents protocols: one for resistive
technology (which is compatible with hid-multitouch in its current
form), and one for capacitive technology (which requires the "corrupt
packet length" quirk).

Apparently, according to the kernel logs the Samsung MB30 is a
resistive technology (correct me if I'm wrong). This means that we
also need testings for the capacitive one.

I'll let the community decide whether we should include this in
hid-multitouch. Henrik, Jiri, any idea?

Now let's go for the review!

Cheers,
Benjamin

On Sun, Mar 6, 2011 at 14:24, Richard Nauber
<richard.nauber@googlemail.com> wrote:
> Hi everyone,
> I wrote this little patch that merges hid-egalax into hid-multitouch.
> (It applies to 2.6.38-rc7, but I can rebase it as you please...) The
> latter driver has to gain a new quirk type (MT_QUIRK_EGALAX) for fixi=
ng
> the reported ranges (X,Y and Z) and work around the corrupt packet
> length (td->last_field_index).
> With these changes it works like a charm for my Samsung MB30
> touchscreen and by the way fixes the broken suspend/resume behavior.
>
> So I'd like you to test it for other egalax devices and give me your
> feedback on this patch.
>
> Thanks and Greetings,
> Richard
>
> =A0[input-hid] Add hid-egalax driver to the unified hid-multitouch
> =A0 =A0framework.
>
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/hid/hid-egalax.c =A0 =A0 | =A0279
> ------------------------------------------
> =A0drivers/hid/hid-multitouch.c | =A0 48 +++++++-
> =A04 files changed, 47 insertions(+), 290 deletions(-)
> =A0delete mode 100644 drivers/hid/hid-egalax.c
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
