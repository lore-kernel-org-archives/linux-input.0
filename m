From: Olivier Gay <ogay@logitech.com>
Subject: Re: [PATCH] HID: add keyboard input assist hid usages
Date: Sat, 18 Oct 2014 08:55:56 -0700
Message-ID: <CAFLMSp9Eg0pztZ=VZMaye4hiKD=MWfZd8PcfuhDkh5HF_Miz_w@mail.gmail.com>
References: <1413590019-1829-1-git-send-email-ogay@logitech.com> <20141017235937.GB22238@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:45081 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186AbaJRP4T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Oct 2014 11:56:19 -0400
Received: by mail-wg0-f44.google.com with SMTP id y10so2695898wgg.3
        for <linux-input@vger.kernel.org>; Sat, 18 Oct 2014 08:56:17 -0700 (PDT)
In-Reply-To: <20141017235937.GB22238@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mathieu Meisser <mmeisser@logitech.com>

Hi Dmitry,

a potential consumer could be Android and Android IMEs, this would add
the ability for a HID device to select and control the suggested words
in the word prediction system when typing.

Olivier

On Fri, Oct 17, 2014 at 4:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Oct 18, 2014 at 01:53:39AM +0200, Olivier Gay wrote:
>> Add keyboard input assist controls usages from approved
>> hid usage table request HUTTR42:
>> http://www.usb.org/developers/hidpage/HUTRR42c.pdf
>>
>> Signed-off-by: Olivier Gay <ogay@logitech.com>
>> ---
>>
>> Hi all,
>>
>> this patch adds some currently missing hid usages to the
>> hid system.
>
> Who is going to be using these codes? Do we have userspace consumers?
>
> Thanks.
>
> --
> Dmitry
