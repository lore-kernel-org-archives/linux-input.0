From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 25 Feb 2013 09:16:51 -0800
Message-ID: <CAG_cf+eWx0U2Y+sMDazOWf6_vbZh7mLXPVrteJ48t1Lwfi+7Mw@mail.gmail.com>
References: <CAG_cf+dOuB-Xi9zDdXguj9S_-PpB98wi2v1LqbR7msPD+DSwgA@mail.gmail.com>
 <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz> <alpine.LNX.2.00.1302251403250.2128@pobox.suse.cz>
 <CANq1E4QR42NyPe=SZGCpHL7Mzcic9YYxXG3v=G+WV9oNq+34oQ@mail.gmail.com> <alpine.LNX.2.00.1302251414130.2128@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46764 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3BYRRL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 12:17:11 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so3299367iea.40
        for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 09:17:11 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1302251414130.2128@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>

Sorry, I'll make sure to CC you in the future.

If you look at linux-input@, you'll see I updated the patch and also
included a use of this patch.

-andrew

On Mon, Feb 25, 2013 at 5:15 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Mon, 25 Feb 2013, David Herrmann wrote:
>
> > >> Please provide your Signed-off-by line; without that, the patch can't be
> > >> accepted.
> > >
> > > Andrew, please ... ?
> >
> > I got the new PATCH with the sign-off. Maybe you missed it?
> >
> > Subject: [PATCH 1/3] HID: Separate struct hid_device's driver_lock
> > into two locks.
> > Date: Mon, 18 Feb 2013 09:20:21 -0800
> > Message-Id: <1361208023-11500-2-git-send-email-andrew-vger@gizmolabs.org>
>
> Ah, thanks for the pointer, apparently I wasn't CCed, which increases the
> likelyhood of patches getting lost significantly.
>
> I'll take them from linux-input@ and add to my TODO.
>
> --
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
