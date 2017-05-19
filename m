From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: Touch Calibration
Date: Fri, 19 May 2017 14:54:07 +0200
Message-ID: <a4283e86-3181-f5cc-0861-1a8258c11696@ginzinger.com>
References: <CAH9_wRNRoz1fEJT9OF4NEn6igPsrh2Kg9jvazXST+k_JBLNw8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:39180 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbdESMyQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 08:54:16 -0400
In-Reply-To: <CAH9_wRNRoz1fEJT9OF4NEn6igPsrh2Kg9jvazXST+k_JBLNw8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sriram V <vshrirama@gmail.com>, linux-input@vger.kernel.org

On 2017-05-18 11:21, Sriram V wrote:
> Hi,
>
> I wanted to find out how does touch calibration works? Is this
> something that is taken care in the userspace?
> Unfortunately, my device does not have a Write Interface. I have read
> the values from the device but can't do i2c writes to the device.
> I also wanted to find out how touch screen calibration is done in
> Android systems.
>

Calibration is linear transformation of coordinate values. Usually this
is not a driver's work. The driver should make sure userspace can talk
in "evdev" sync frames.

It is usually done in userspace, by an X.org input "driver" for example.
At least I think xf86-input-evdev does some calibration.

For touchscreen devices, especially in embedded and if people need more
filters than linear transormation, tslib ( http://tslib.org ) is often
used for calibration. The one tslib module doing calibration is called
"linear" and can be configured (the actual calibration process) with a
graphical framebuffer application, ts_calibrate which is part of tslib.

                       martin

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

