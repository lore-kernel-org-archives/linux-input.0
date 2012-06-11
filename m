From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Mon, 11 Jun 2012 19:56:11 +0200
Message-ID: <CANq1E4SCbURdH+fhoMinTz_R0SN_Y4PEPST5jNZSN6czt=q+DQ@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMZwxu0uf_YeXt_TnokxeCGUfAAjV7jkgGs37b5Kp3cEmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62943 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2FKR4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jun 2012 13:56:12 -0400
Received: by wibhn6 with SMTP id hn6so3219882wib.1
        for <linux-input@vger.kernel.org>; Mon, 11 Jun 2012 10:56:11 -0700 (PDT)
In-Reply-To: <CAAngNMZwxu0uf_YeXt_TnokxeCGUfAAjV7jkgGs37b5Kp3cEmg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi Joao

On Mon, Jun 11, 2012 at 4:46 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Sun, Jun 10, 2012 at 10:16 AM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> This adds a new low-level HID driver that allows user-space to imple=
ment the
>> transport-layer. This is needed by HOGP (HID over Gatt on Bluetooth =
Low Energy).
>> There is already an implementation of HOGP, see the
>> linux-bluetooth@vger.kernel.org mailing list for this.
>>
>> I've split this into multiple patches to make review easier. This pa=
tchset is
>> already working for several months for the HOGP developers but there=
 may still
>> be some issues with it. Please review.
>>
>> The uhid_*() functions implement the basic module functionality. The
>> uhid_char_*() functions handle character-device related functionalit=
y. The
>> uhid_dev_*() functions handle the uhid-device object and the uhid_hi=
d_*()
>> functions are HID-callbacks.
>>
>> I am open for any suggestions.
>>
>
> Hello David,
>
> I've noticed one regression from the patch you've sent without Featur=
e
> Reports support to the one with Feature Reports support (which was th=
e
> previous patch, before the split) with the events coming from the cha=
r
> device. The event_type values we're all coming out of its enum type
> range. Have you tested this lately, with this new patch? I'll apply
> and test it right now.

I don't understand. What do you mean with "are all coming out of its
enum type range"? Are the type values incorrect and not the ones
defined in uhid.h?

> --
> Jo=E3o Paulo Rechi Vita
> Openbossa Labs - INdT

Thanks for testing
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
