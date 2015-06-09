From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH] cap11xx: add LED support
Date: Tue, 9 Jun 2015 09:18:41 -0700
Message-ID: <CAKzfze8rM1AryLLd9deRGSzudpBWptk1AcpGiJ9qdBiR9jg0Xg@mail.gmail.com>
References: <1433821584-20102-1-git-send-email-mranostay@gmail.com>
	<55767915.5050206@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34900 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbbFIQSm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:18:42 -0400
Received: by iesa3 with SMTP id a3so17737295ies.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2015 09:18:41 -0700 (PDT)
In-Reply-To: <55767915.5050206@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Jun 8, 2015 at 10:26 PM, Daniel Mack <daniel@zonque.org> wrote:
> On 06/09/2015 05:46 AM, Matt Ranostay wrote:
>> Several cap11xx variants have LEDs that be can be controlled, this
>> patchset implements this functionality.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/input/keyboard/cap11xx.c | 102 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 99 insertions(+), 3 deletions(-)
>
> Ah, and please include the LED maintainers in v2, they might spot other
> details :)
>

Will do.

>
> Thanks,
> Daniel
>
>
