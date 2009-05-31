From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sun, 31 May 2009 10:38:22 -0700
Message-ID: <200905311038.23807.dmitry.torokhov@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <20090531142027.GA22540@n2100.arm.linux.org.uk> <f17812d70905310729r501ed41fja622392c187c5cbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:62420 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZEaRid (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2009 13:38:33 -0400
Received: by pzk7 with SMTP id 7so5604603pzk.33
        for <linux-input@vger.kernel.org>; Sun, 31 May 2009 10:38:34 -0700 (PDT)
In-Reply-To: <f17812d70905310729r501ed41fja622392c187c5cbb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sunday 31 May 2009 07:29:08 Eric Miao wrote:
> On Sun, May 31, 2009 at 10:20 PM, Russell King - ARM Linux
>
> <linux@arm.linux.org.uk> wrote:
> > On Sun, May 31, 2009 at 10:12:25PM +0800, Eric Miao wrote:
> >> +static void __devinit build_keycodes(struct matrix_keypad *keypad)
> >> +{
> >> +     struct matrix_keypad_platform_data *pdata = keypad->pdata;
> >> +     struct input_dev *input_dev = keypad->input_dev;
> >> +     uint32_t *key;
> >> +     int i;
> >> +
> >> +     keypad->keycodes = kzalloc(MATRIX_MAX_KEYS * sizeof(int),
> >> GFP_KERNEL);
> >
> > This doesn't check for failure...
>
> Oops, updated (together with the release) as below:

Eric, could you please send me this patch as a diff to the original
one you sent?

Thanks a lot.

-- 
Dmitry
