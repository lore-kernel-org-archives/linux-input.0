From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Mon, 2 Jul 2012 23:19:41 +0200
Message-ID: <CANq1E4RsZDN1QpwPMfotFPSoqo0DEYnxmo2XdyNE0Mvmi-_7ow@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1206181345330.15308@pobox.suse.cz>
	<CAAngNMZDFi9TLb+5Cfeg-iUBjjmcYixr235BL8q4=pO6n9ziSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57908 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab2GBVTm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 17:19:42 -0400
Received: by werb14 with SMTP id b14so2819207wer.19
        for <linux-input@vger.kernel.org>; Mon, 02 Jul 2012 14:19:41 -0700 (PDT)
In-Reply-To: <CAAngNMZDFi9TLb+5Cfeg-iUBjjmcYixr235BL8q4=pO6n9ziSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Joao

On Mon, Jul 2, 2012 at 11:05 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Mon, Jun 18, 2012 at 8:46 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Sun, 10 Jun 2012, David Herrmann wrote:
>>
>>> This adds a new low-level HID driver that allows user-space to implement the
>>> transport-layer. This is needed by HOGP (HID over Gatt on Bluetooth Low Energy).
>>> There is already an implementation of HOGP, see the
>>> linux-bluetooth@vger.kernel.org mailing list for this.
>>>
>>> I've split this into multiple patches to make review easier. This patchset is
>>> already working for several months for the HOGP developers but there may still
>>> be some issues with it. Please review.
>>>
>>> The uhid_*() functions implement the basic module functionality. The
>>> uhid_char_*() functions handle character-device related functionality. The
>>> uhid_dev_*() functions handle the uhid-device object and the uhid_hid_*()
>>> functions are HID-callbacks.
>>>
>>> I am open for any suggestions.
>>
>> David,
>>
>> I have just finished my review and haven't found any principal issues. I
>> am queueing the patchset in my tree.
>>
>
> Just for information, when is this going to hit upstream trees (not
> sure if its Linus' directly or other intermediate tree)? 3.6 merge
> window?

If Jiri does not delay it due to bugs in linux-next it will hit
upstream with next merge window (hopefully ;)).

Regards
David
