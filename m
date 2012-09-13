From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] input: fix input_open_file() accessing out-of-bound buffers
Date: Thu, 13 Sep 2012 19:00:55 +0200
Message-ID: <CANq1E4QKBOedvHDEXKs6X9F01jZaY6XOeTwa-oDO6EsAtS31sg@mail.gmail.com>
References: <1347553050-25480-1-git-send-email-dh.herrmann@googlemail.com>
	<CANq1E4Rs7ue8E7prx8KQ=UxLrhRdYA9YV7URGHLiV3yGAmrePA@mail.gmail.com>
	<20120913165717.GB3519@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33826 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580Ab2IMRA4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 13:00:56 -0400
Received: by wibhr14 with SMTP id hr14so3877157wib.1
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 10:00:55 -0700 (PDT)
In-Reply-To: <20120913165717.GB3519@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

On Thu, Sep 13, 2012 at 6:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Thu, Sep 13, 2012 at 06:18:17PM +0200, David Herrmann wrote:
>> Hi Dmitry
>>
>> On Thu, Sep 13, 2012 at 6:17 PM, David Herrmann
>> <dh.herrmann@googlemail.com> wrote:
>> > The "input_table" array is very small and we cannot be sure that the file
>> > the user opens has a minor-ID below 256 (8 << 5). Hence, simply check that
>> > the minor isn't out-of-bounds. If it is, return -ENODEV.
>> >
>> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> > Cc: <stable@kernel.org>
>>
>> This should be "Cc: <stable@vger.kernel.org>". Sorry for the typo.
>
> register_chrdev() reserves exactly 256 minors so it is not possible for
> input_open_file() to be called with minor that will get us out of
> bounds.

Ah, magic numbers. I love them!
But thanks, good to know, as I am currently working on integrating
dynamic-minors.

Sorry for the noise. Regards
David
