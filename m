From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Using EV_MSC or extending KEY_*
Date: Tue, 15 Sep 2009 22:41:30 +0530
Message-ID: <5d5443650909151011k4b21a6d0n28ac6142c3d7161d@mail.gmail.com>
References: <aac07123ee2b14a0ac25d1652dbe0780.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:44973 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbZIORL1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 13:11:27 -0400
In-Reply-To: <aac07123ee2b14a0ac25d1652dbe0780.squirrel@intranet.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Linux USB <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Adding linux-input.

On Tue, Sep 15, 2009 at 9:49 PM, Rick L. Vinyard, Jr.
<rvinyard@cs.nmsu.edu> wrote:
> On the Logitech G13 there are a set of 10 special keys at the top of =
the
> device.
>
> I've written the driver so that it maintains a map from the general k=
eys
> (G1-G22) to Linux' input subsystem keys.
>
> The map can be changed on the fly, allowing multiple keymaps to be lo=
aded.
>
> As a side note I haven't provided for this functionality (multiple
> keymaps) in the driver since this can be maintained from userspace, b=
ut it
> does need to know about the currently loaded keymap so that when the =
raw
> HID events are parsed the appropriate EV_KEY events can be input.
>
> I could set it up so that the special keys also map to a KEY_* code.
> However, I'd prefer to set things up so that any G1-G22 key can be ma=
pped
> to any input subsystem KEY_* code and not reserve a set of 10 from th=
e
> current KEY_* codes for the 10 special keys.
>
> One way I was thinking of approaching this was to generate EV_MSC typ=
e
> events (with a MSC_RAW code) using the value to indicate the state
> (pressed/released) and special key.
>
> Another way to approach this would be to extend the KEY_* #defines wi=
th a
> special set of 10 codes for the 10 special keys.
>
> Any suggestions on the better approach?
>
> Thanks,
>
> Rick
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
