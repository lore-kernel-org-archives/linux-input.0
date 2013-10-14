From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v2 1/2] Add an additional argument for decode routine,
 change secondary device name
Date: Sun, 13 Oct 2013 23:02:02 -0700
Message-ID: <CAJiQ=7ChMZDEbUE_761NLwByWSCQTBM8ek=NQvVNQwjBN=SqBA@mail.gmail.com>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
	<1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
	<CAJiQ=7D9ZBKJcGgYT+3se92t2zn6nzJ8645CzWdB2xh1S60+nQ@mail.gmail.com>
	<CA+F6ckOfK25hhCxcJ5JRbzt+o1BKYvOynB1DQkPY+RSZrp8KFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46603 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3JNGCC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Oct 2013 02:02:02 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so6874503pbc.22
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 23:02:02 -0700 (PDT)
In-Reply-To: <CA+F6ckOfK25hhCxcJ5JRbzt+o1BKYvOynB1DQkPY+RSZrp8KFw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Will Tommy <tommywill2011@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, yunkang.tang@cn.alps.com, linux-input@vger.kernel.org, david turvene <dturvene@dahetral.com>

On Sun, Oct 13, 2013 at 10:50 PM, Will Tommy <tommywill2011@gmail.com> wrote:
>> I assume start_bit and end_bit can never be negative, because the code
>> that calculates e.g. x_map will populate at most bits 0..(x_bits-1)?
>
> Do you mean it's not good to define start_bit & end_bit as "int" since they have
> no chance to be negative ? Actually, "unsigned char" is much better.

No type change needed - I was just checking to make sure it wasn't a
risk, since getting a negative number in there would really throw off
the math...
