From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: Commit c64f6f934c7490faff76faf96217066a1b3570a0 breaks my MosArt touchscreen
Date: Wed, 9 Mar 2011 13:19:57 +0100
Message-ID: <AANLkTinuDb8Yreiw+H3E1D-W5S0BSstbi6OGYOUgn3z+@mail.gmail.com>
References: <AANLkTinngODj8K0feoJdwoq7T0RX9vbhJazf_9WNbTGB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37472 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab1CIMT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 07:19:59 -0500
Received: by wwa36 with SMTP id 36so542459wwa.1
        for <linux-input@vger.kernel.org>; Wed, 09 Mar 2011 04:19:57 -0800 (PST)
In-Reply-To: <AANLkTinngODj8K0feoJdwoq7T0RX9vbhJazf_9WNbTGB@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James Sharam <james.sharam@googlemail.com>, Jiri Kosina <jkosina@suse.cz>, Greg KH <gregkh@suse.de>, linux-input <linux-input@vger.kernel.org>

Hi James,

Ouch, sorry for that. In fact, hid-mosart is buggy since its creation
for the relative/absolute behavior you are observing.
A patch corrects this and has been included in 2.6.38, but it has not
been backported to 2.6.37.
The name of the patch is "HID: hid-mosart: ignore buttons report".

Jiri, Greg, do you think we can include this in the stable queue?

Cheers,
Benjamin


On Wed, Mar 9, 2011 at 11:28, James Sharam <james.sharam@googlemail.com=
> wrote:
> Dear Benjamin,
> I've recently upgraded to kernel 2.6.37.2 from 2.6.37.1 and have run =
in to
> problems with my MosArt touchscreen that I think is related to
> commit=A0c64f6f934c7490faff76faf96217066a1b3570a0 that you signed off=
=2E The
> details are in this kernel bug report that I have just
> posted:=A0https://bugzilla.kernel.org/show_bug.cgi?id=3D30792=A0.
> Would you mind having a quick look to see if this is easily resolvabl=
e?
> Thanks,
> - James Sharam
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
