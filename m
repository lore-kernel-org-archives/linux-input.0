From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Mon, 11 Jun 2012 11:46:41 -0300
Message-ID: <CAAngNMZwxu0uf_YeXt_TnokxeCGUfAAjV7jkgGs37b5Kp3cEmg@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46975 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab2FKOql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jun 2012 10:46:41 -0400
Received: by obbtb18 with SMTP id tb18so6823957obb.19
        for <linux-input@vger.kernel.org>; Mon, 11 Jun 2012 07:46:41 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Sun, Jun 10, 2012 at 10:16 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> This adds a new low-level HID driver that allows user-space to implem=
ent the
> transport-layer. This is needed by HOGP (HID over Gatt on Bluetooth L=
ow Energy).
> There is already an implementation of HOGP, see the
> linux-bluetooth@vger.kernel.org mailing list for this.
>
> I've split this into multiple patches to make review easier. This pat=
chset is
> already working for several months for the HOGP developers but there =
may still
> be some issues with it. Please review.
>
> The uhid_*() functions implement the basic module functionality. The
> uhid_char_*() functions handle character-device related functionality=
=2E The
> uhid_dev_*() functions handle the uhid-device object and the uhid_hid=
_*()
> functions are HID-callbacks.
>
> I am open for any suggestions.
>

Hello David,

I've noticed one regression from the patch you've sent without Feature
Reports support to the one with Feature Reports support (which was the
previous patch, before the split) with the events coming from the char
device. The event_type values we're all coming out of its enum type
range. Have you tested this lately, with this new patch? I'll apply
and test it right now.

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
