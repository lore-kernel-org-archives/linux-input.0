From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: uinput really needs a custom sleep time?
Date: Tue, 31 Jan 2017 00:00:40 -0200
Message-ID: <20170131020039.GA2138@xfiles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36317 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdAaCAu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 21:00:50 -0500
Received: by mail-qk0-f179.google.com with SMTP id 11so149722860qkl.3
        for <linux-input@vger.kernel.org>; Mon, 30 Jan 2017 18:00:50 -0800 (PST)
Received: from xfiles ([191.248.111.174])
        by smtp.gmail.com with ESMTPSA id q3sm13973091qte.0.2017.01.30.18.00.47
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jan 2017 18:00:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi input guys,

after playing with uinput, it seems an sleep call is necessary before emitting new events. If this really required?

While reading code of cwiid project, another user of uinput interface, it seems this sleep time isn't necessary[1].

In the other hang, when trying to send a simple event in my desktop, an sleep is necessary, take a look in my example[2].

Another interesting fact: kernel documentation lacks of an uinput example. Do you think this would be interesting to have one?

Thanks for your time,
Marcos

[1] https://github.com/abstrakraft/cwiid/blob/master/wminput/uinput.c#L193
[2] https://github.com/marcosps/kernel_experiments/blob/master/userspace/uinput.c#L65
