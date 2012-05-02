From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Wed, 2 May 2012 16:09:32 -0300
Message-ID: <CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38329 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab2EBTRq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 May 2012 15:17:46 -0400
Received: by pbbrp8 with SMTP id rp8so1481884pbb.19
        for <linux-input@vger.kernel.org>; Wed, 02 May 2012 12:17:46 -0700 (PDT)
In-Reply-To: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, marcel@holtmann.org, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org

On Mon, Apr 30, 2012 at 12:27 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> This implements a hid_ll_driver user-space interface similar to uinpu=
t for the
> input devices. It allows to implement the HID transport-layer in user=
-space as
> required by Bluetooth Low-Energy (HoG).
>
> This is my "first final revision" for the module. Please review and t=
est.
> Changes from the previous RFCs include:
> =C2=A0- The feature-report mechanism is now implemented
> =C2=A0- Several min_t() fixes
> =C2=A0- Minor coding-style issues
>
> I did not change __attribute__((__packed__)) to __packed as the latte=
r one is
> not provided to user-space.
>
> If there are any more issues, please tell me. And for the record, the=
 HoG devs
> told me that they are working since several months with it now so we =
have a real
> user-space application that needs it ;)
>
> If there are no more issues (which i doubt) I can also resend this sp=
litted into
> multiple patches.
>

Thanks for your work, David. I'll test and review this new version.
Did you find out the what is the problem when passing BUS_BLUETOOTH on
the 'bus' field of the create request?

Also, how does the HID subsystem differentiate from HID protocol
versions? We've just found out that HoG exposes what HID protocol
version the device implements, is it the case of having an extra field
on the uhid_create_req structure to pass this information, or is it
already present on the HID descriptor (sorry for my limited knowledge
on the HID protocol itself)?

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
