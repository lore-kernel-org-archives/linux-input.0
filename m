From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fix resume issue on Raydium touchscreen
 device
Date: Thu, 4 Jan 2018 20:56:50 +0800
Message-ID: <7ddae302-a44f-b729-c826-082bdcb38d70@canonical.com>
References: <20180102173006.506-1-aaron.ma@canonical.com>
 <20180102173006.506-2-aaron.ma@canonical.com>
 <CAO-hwJJ3n3YD1+pKvKRRoCX8y-5xZwemKLuLi7aqWSQT=J645A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53606 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbeADM51 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 Jan 2018 07:57:27 -0500
In-Reply-To: <CAO-hwJJ3n3YD1+pKvKRRoCX8y-5xZwemKLuLi7aqWSQT=J645A@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

Hi Benjamin:

Thanks for reviewing my patches.

This issue only happened on this RayD 2386:3118 touchscreen.
No other devices found, so I think it should be in quirk.
