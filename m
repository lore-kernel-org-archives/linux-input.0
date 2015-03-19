From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: synaptics - quirk for Thinkpad E440
Date: Thu, 19 Mar 2015 18:15:45 -0400
Message-ID: <CAN+gG=HJgrdK+qRbRn-HetFNTxFf43Cig2aV_d567bX_kZW6_Q@mail.gmail.com>
References: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
	<CAO7PdF-NNkxo5Ym2+Wf9Bd+d7pU7U3X0puN8QNj_cXpQfbf9qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33106 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbCSWPq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 18:15:46 -0400
Received: by qgfa8 with SMTP id a8so78571989qgf.0
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 15:15:45 -0700 (PDT)
In-Reply-To: <CAO7PdF-NNkxo5Ym2+Wf9Bd+d7pU7U3X0puN8QNj_cXpQfbf9qA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ramiro Morales <cramm0@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Mar 19, 2015 at 11:17 AM, Ramiro Morales <cramm0@gmail.com> wrote:
> On Thu, Mar 19, 2015 at 7:37 AM, Ramiro Morales <cramm0@gmail.com> wrote:
>
>> Subject: [PATCH] Input: synaptics - quirk for Thinkpad E440
>>
>> Its ClickPad shares PNP ID "LEN2006" with the one in model E540 which is
>> already handled by the driver (both are Haswell iterations of the Edge
>> line, launched in 2014) but the dimensions it reports are different:
>
> Clarification: This patch is against the synaptics branch.

Then I am even more surprised that you need to quirk a late 2014
haswell refresh.

Can you post your dmesg when booting the synaptics branch so that we
can check if the FW has the correct values stored or if we really need
to quirk it?

Cheers,
Benjamin

>
> Regards,
>
> --
> Ramiro Morales
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
