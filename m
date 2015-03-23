From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: synaptics - quirk for Thinkpad E440
Date: Mon, 23 Mar 2015 12:58:16 -0400
Message-ID: <CAN+gG=G1byht7trjgGpUzEtHWUnK3stmxV0hjNTx0WzSgnOk8g@mail.gmail.com>
References: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
	<CAO7PdF-NNkxo5Ym2+Wf9Bd+d7pU7U3X0puN8QNj_cXpQfbf9qA@mail.gmail.com>
	<CAN+gG=HJgrdK+qRbRn-HetFNTxFf43Cig2aV_d567bX_kZW6_Q@mail.gmail.com>
	<CAO7PdF8VKNOAz6b2nkt5bfqfK+jpDm2LhsQX0QeRX_woGD+ZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36616 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbbCWQ6U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 12:58:20 -0400
Received: by qgez102 with SMTP id z102so65135402qge.3
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2015 09:58:19 -0700 (PDT)
In-Reply-To: <CAO7PdF8VKNOAz6b2nkt5bfqfK+jpDm2LhsQX0QeRX_woGD+ZKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ramiro Morales <cramm0@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Mar 21, 2015 at 9:24 AM, Ramiro Morales <cramm0@gmail.com> wrote:
> On Thu, Mar 19, 2015 at 7:15 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Then I am even more surprised that you need to quirk a late 2014
>> haswell refresh.
>>
>> Can you post your dmesg when booting the synaptics branch so that we
>> can check if the FW has the correct values stored or if we really need
>> to quirk it?
>
> On Thu, Mar 19, 2015 at 7:15 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Then I am even more surprised that you need to quirk a late 2014
>> haswell refresh.
>
> Actually the laptop manufacturing date is Nov '13, I bought it on May.
>
> This patch is almost a year late because I had a false start
> submitting fixes through the Ubuntu BTS[1] only to discover that a
> clashing quirk for the E540 got added upstream about the same time.
> The ability to include the board ID in the quirk table logic added by
> this branch provides a way out.
>
>> Can you post your dmesg when booting the synaptics branch so that we
>> can check if the FW has the correct values stored or if we really need
>> to quirk it?
>
> Here it is:
>
> https://dl.dropboxusercontent.com/u/5403630/dmesg_thinkpad_e440_synaptics_8f004f3f.txt

Thanks for all these information. So indeed, your patch is entirely
valid and is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Regards,
>
>
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1395243
> [2] https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?id=bce4f9e764c36bc35dd5c9cf9e057c09f422397d
>
> --
> Ramiro Morales
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
