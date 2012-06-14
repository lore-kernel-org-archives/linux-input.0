From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Thu, 14 Jun 2012 19:05:17 -0300
Message-ID: <CAAngNMYehtuW5405+U7Kkw+dyCFDT0t08gteTDfxH-gbK0Zhug@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMZwxu0uf_YeXt_TnokxeCGUfAAjV7jkgGs37b5Kp3cEmg@mail.gmail.com>
	<CANq1E4SCbURdH+fhoMinTz_R0SN_Y4PEPST5jNZSN6czt=q+DQ@mail.gmail.com>
	<CAAngNMa3GMqrgZUrx=XqaRWfK2MaFMewK6OEQU_=4oPj1FOMNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59455 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2FNWFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 18:05:18 -0400
Received: by obbtb18 with SMTP id tb18so2998520obb.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jun 2012 15:05:17 -0700 (PDT)
In-Reply-To: <CAAngNMa3GMqrgZUrx=XqaRWfK2MaFMewK6OEQU_=4oPj1FOMNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, Jun 11, 2012 at 11:40 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Mon, Jun 11, 2012 at 2:56 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> Hi Joao
>>
>> On Mon, Jun 11, 2012 at 4:46 PM, Joao Paulo Rechi Vita
>> <jprvita@openbossa.org> wrote:
>>> On Sun, Jun 10, 2012 at 10:16 AM, David Herrmann
>>> <dh.herrmann@googlemail.com> wrote:
>>>> This adds a new low-level HID driver that allows user-space to imp=
lement the
>>>> transport-layer. This is needed by HOGP (HID over Gatt on Bluetoot=
h Low Energy).
>>>> There is already an implementation of HOGP, see the
>>>> linux-bluetooth@vger.kernel.org mailing list for this.
>>>>
>>>> I've split this into multiple patches to make review easier. This =
patchset is
>>>> already working for several months for the HOGP developers but the=
re may still
>>>> be some issues with it. Please review.
>>>>
>>>> The uhid_*() functions implement the basic module functionality. T=
he
>>>> uhid_char_*() functions handle character-device related functional=
ity. The
>>>> uhid_dev_*() functions handle the uhid-device object and the uhid_=
hid_*()
>>>> functions are HID-callbacks.
>>>>
>>>> I am open for any suggestions.
>>>>
>>>
>>> Hello David,
>>>
>>> I've noticed one regression from the patch you've sent without Feat=
ure
>>> Reports support to the one with Feature Reports support (which was =
the
>>> previous patch, before the split) with the events coming from the c=
har
>>> device. The event_type values we're all coming out of its enum type
>>> range. Have you tested this lately, with this new patch? I'll apply
>>> and test it right now.
>>
>> I don't understand. What do you mean with "are all coming out of its
>> enum type range"? Are the type values incorrect and not the ones
>> defined in uhid.h?
>>
>
> Exactly, the "event_type" field if of type "enum uhid_event_type",
> which ranges from 0 to 10. The values coming from the char device are
> numbers with around 10-12 digits.
>

(sorry, I forgot to cc the list on the original response)

I've tested this new version split in several patches. Input reports
support works fine, but the event_type value is still broken. This is
a minor issue IMO, since it just affects output and feature reports
support, which is not completed implemented in the userspace side of
HoG yet. I don't see a problem in having the series integrated
upstream and we fix this problem later on.

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
