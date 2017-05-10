From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] Input: elan_i2c - check if device is there before
 really probing
Date: Tue, 9 May 2017 21:49:50 -0300
Message-ID: <CAOMZO5Af4YR95D7xJepPf-wm4JA0qxmgEMqSJd8SbUBT0CxB7A@mail.gmail.com>
References: <20170509004553.GA21295@dtor-ws> <CAOMZO5BjGVU3N1YZVo9JiTaKzWcvq1GA_dskXtA4LvNGKG8kNw@mail.gmail.com>
 <20170510004654.GC32584@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35826 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdEJAtv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 20:49:51 -0400
In-Reply-To: <20170510004654.GC32584@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, KT Liao <ktalex.liao@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, May 9, 2017 at 9:46 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> That is the point of the patch - we want to fail silently if the device
> is not actually there and fails even the simplest communication. Driver
> core treats ENXIO and ENODEV as special and does not log errors.

Got it, thanks for the explanation!
