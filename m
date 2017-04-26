From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.eu>
Subject: Re: [PATCH v2.2] HID: hid-elecom: extend to fix the descriptor for DEFT trackballs.
Date: Wed, 26 Apr 2017 17:37:03 +0100
Message-ID: <20170426163704.26184-1-flameeyes@flameeyes.eu>
References: <alpine.LSU.2.20.1704261030230.12121@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37416 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdDZQhR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 12:37:17 -0400
Received: by mail-wm0-f50.google.com with SMTP id m123so10147984wma.0
        for <linux-input@vger.kernel.org>; Wed, 26 Apr 2017 09:37:16 -0700 (PDT)
Received: from localhost ([2a02:8084:d6c0:6b00:2452:b52:90dd:3b1d])
        by smtp.gmail.com with ESMTPSA id x2sm36969edb.49.2017.04.26.09.37.12
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 09:37:13 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.20.1704261030230.12121@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


On Wed, Apr 26, 2017 at 9:34 AM Jiri Kosina <jikos@kernel.org> wrote:
> > + *  HID driver for ELECOM devices.
> >   *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
> > + *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
> 
> If new copyright of a 3rd party is being added, I'd like to see explicit
> Signed-off-by: from that person.

Yuxuan Shui is CCed to this thread so I hope he can sign off it. For what
it's worth, the only thing I took from his patch is the ID of the ELECOM
DEFT wired which I don't have and so wouldn't know (nor would I have known
it needed the same descriptor hotfix).

Please advise.

> Missing break?

Good catch, fixed.

> > +              *     Report Count (1),            |      Report Count (0),
> 
> I personally don't find the '|' notation for diff really straightforward
> ... how about '->', so that it's clear which are the old and new values?

Great idea, done :)

This was the output of diff -y -- but since I had to change it anyway to
make it fit into the comment, it makes sense to replace that too.

Thanks!
Diego
