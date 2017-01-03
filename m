From: "Lars R. Damerow" <lars@pixar.com>
Subject: Re: increasing LED_MAX and INPUT_DEVICE_ID_LED_MAX?
Date: Tue, 3 Jan 2017 12:26:18 -0800
Message-ID: <20170103202618.GC6471@pixar.com>
References: <20161222210306.GE8919@pixar.com>
 <CAKdAkRQO-4wCuF_bE-FdoVPouXxQSoTKfVA2p=JYQBwWA=y=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-lb.pixar.com ([138.72.247.109]:24105 "EHLO
        smtp-lb.pixar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965902AbdACUp7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 15:45:59 -0500
Content-Disposition: inline
In-Reply-To: <CAKdAkRQO-4wCuF_bE-FdoVPouXxQSoTKfVA2p=JYQBwWA=y=kg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

>From Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wed, Dec 28, 2016 at 10:56:17AM -0800:
> Hi Lars,
> 
> No, we do not want to extend LED range to allow device report buttons
> as leds. You need to teach hid-input to parse the descriptors better
> for your device.

Sounds good. Thanks!
-lars

--
lars r. damerow :: button pusher :: pixar animation studios

https://keybase.io/ldamerow
F29F 160D B23C 3237 1BA3 FCD5 4E13 C775 36B3 ABCA
