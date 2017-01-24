From: David Farrell <davidnmfarrell@gmail.com>
Subject: Adonit Jot Pixel Stylus driver
Date: Mon, 23 Jan 2017 23:12:55 -0500
Message-ID: <CAAzBBqut4ki4A1ygqcL54Bq=NP-TWPe9M_SVLJYZLkk=guOGDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35524 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAXEM5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Jan 2017 23:12:57 -0500
Received: by mail-io0-f179.google.com with SMTP id j18so126625846ioe.2
        for <linux-input@vger.kernel.org>; Mon, 23 Jan 2017 20:12:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks,

I have an adonit jot pixel bluetooth stylus. Adapting someone else's
code (source http://gerev.github.io/laptop-cintiq/) I have it working
with uinput, posting ABS_PRESSURE and BTN_1/2 event codes and so on.
I'm running upstream.

What I'm wondering is; as the stylus relies on a bluetooth connection,
is it a suitable device to develop a kernel input driver for? And if
yes, are there any reference drivers you'd recommend I look at?

Many thanks in advance

David
