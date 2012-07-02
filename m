From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Mon, 2 Jul 2012 18:05:08 -0300
Message-ID: <CAAngNMZDFi9TLb+5Cfeg-iUBjjmcYixr235BL8q4=pO6n9ziSA@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1206181345330.15308@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39638 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab2GBVFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 17:05:09 -0400
Received: by yenl2 with SMTP id l2so4570652yen.19
        for <linux-input@vger.kernel.org>; Mon, 02 Jul 2012 14:05:08 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1206181345330.15308@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Mon, Jun 18, 2012 at 8:46 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 10 Jun 2012, David Herrmann wrote:
>
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
>
> David,
>
> I have just finished my review and haven't found any principal issues=
=2E I
> am queueing the patchset in my tree.
>

Just for information, when is this going to hit upstream trees (not
sure if its Linus' directly or other intermediate tree)? 3.6 merge
window?

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
