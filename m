From: Sriram V <vshrirama@gmail.com>
Subject: input_set_abs max
Date: Tue, 28 Feb 2017 18:32:41 +0530
Message-ID: <CAH9_wROD04FGhDjg471t4oYLtJkWeW2atrAvMSznokftkFMNpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34029 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdB1NCn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 08:02:43 -0500
Received: by mail-ua0-f176.google.com with SMTP id f54so12127361uaa.1
        for <linux-input@vger.kernel.org>; Tue, 28 Feb 2017 05:02:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have a 480x800 LCD and the touchscreen driver gives 0 to 4095 and
max value is X=4095, Y = 4095
I am using android. Currently, with this setup. I am not able to see
the effects on my touchscreen on the
LCD.

I use the call input_set_abs_params with ABS_X and ABS_Y to tell the
upper layer that my touchscreen
gives 0 to 4095.

Eventhough, i am able to see the events generated using evtest.

I wanted to check who maps these values 0 to 4095 to the Appropriate
pixel on the LCD.

Regards,
Sriram
