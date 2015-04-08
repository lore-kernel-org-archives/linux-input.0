From: Andreas Fleig <andreasfleig@gmail.com>
Subject: Re: [PATCH] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Wed, 08 Apr 2015 11:34:30 +0200
Message-ID: <1428485670.14997.0@smtp.gmail.com>
References: <1428399169.9694.0@smtp.gmail.com>
	<CAKdAkRS=j4sOCDNVKzr7di2wh2XWDCF8ZC7sTXAa05NPdqJPmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35322 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbDHJed (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 05:34:33 -0400
Received: by widdi4 with SMTP id di4so47770542wid.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2015 02:34:31 -0700 (PDT)
In-Reply-To: <CAKdAkRS=j4sOCDNVKzr7di2wh2XWDCF8ZC7sTXAa05NPdqJPmA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Apr 7, 2015 at 5:42 , Dmitry Torokhov 
<dmitry.torokhov@gmail.com> wrote:
> Without commenting on validity of making this decision based on
> presence or absence of LEDs the proper test would be:
> 
>         if (!test_bit(EV_LED, hi->input->evbit)) {

Thanks, that's much cleaner. I'll also test for EV_REL instead, which 
makes more sense, especially since the keyboard doesn't actually have 
physical LEDs.

Andreas

