From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: [PATCH 0/3] HID: multitouch: fix a corner case of some Win 8
 devices
Date: Thu, 22 Jun 2017 18:20:29 +0200
Message-ID: <8be6104d-220d-e3a1-fd5e-c02c4ef85a05@gmail.com>
References: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34612 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdFVQUe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Jun 2017 12:20:34 -0400
In-Reply-To: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 15.06.2017 15:32, Benjamin Tissoires wrote:
> It looks like the Microsft certification misses one case of released fingers.
>
> The (only) solution we can have against that is to wait for a hundred of ms,
> and if no input report comes in, consider that the touches should have been
> released. The spec, as I read it, enforces that.
>
> Arek, can you please give a test to this new series?
> I managed to find out a way to have the IRQ and the timeout exclusive, and
> also added a few optimizations.
Sorry for delayed response.
Works great! Highly recommend this fix.

Cheers,
Arek
