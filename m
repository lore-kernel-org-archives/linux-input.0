From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] Input: tc3589x-keypad - fix keymap size
Date: Mon, 11 Mar 2013 16:54:00 +0100
Message-ID: <CAH+eYFDZFZfWx64deckTfujtypDdsV9=+HcVBe-tZtmmO8Me9A@mail.gmail.com>
References: <1362752803-21853-1-git-send-email-rabin.vincent@stericsson.com> <20130310002300.GA31236@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:60335 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3CKP7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Mar 2013 11:59:46 -0400
Received: by mail-qe0-f41.google.com with SMTP id 6so2391094qeb.0
        for <linux-input@vger.kernel.org>; Mon, 11 Mar 2013 08:59:45 -0700 (PDT)
In-Reply-To: <20130310002300.GA31236@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

2013/3/10 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Fri, Mar 08, 2013 at 03:26:43PM +0100, Rabin Vincent wrote:
>> The keymap size used by tc3589x is too low, leading to the driver
>> overwriting other people's memory.  Fix this by making the driver use
>> the automatically allocated keymap provided by
>> matrix_keypad_build_keymap() instead of allocating one on its own.
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>
> Do you think you could prepare a patch against stable as older kernels
> should have the same issue but matrix_keypad_build_keymap does not
> allocate keymap there?

The memory overwriting problem only exists after 1932811f426fee ("Input:
matrix-keymap - uninline and prepare for device tree support").  Before
that the driver was passing in a row_shift of 3, which, with a max rows
count of 8, fit into the 64 entries of keymap that the driver allocates.

1932811f426fee was introduced in v3.5.

5383116b86d8e87 ("Input: marix-keymap - automatically allocate memory
for keymap") was introduced in v3.8

The only stable kernel from v3.5 to v3.8 which is currently maintained
is v3.8.  So, it looks like this patch can be applied to v3.8 stable,
and no stable specific patches are needed.
