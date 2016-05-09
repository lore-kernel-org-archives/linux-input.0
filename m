From: Grant Grundler <grundler@chromium.org>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Mon, 9 May 2016 09:44:57 -0700
Message-ID: <CANEJEGu=QkYwrDeS08JdNaUis1aVpOs_xnZCdFmC4FHF8uSRHA@mail.gmail.com>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
	<20160504135123.GA4567@rob-hp-laptop>
	<CANEJEGt1Ri7Q-g25U8_KTAb9Z8MfVWH0N5QLaLcdnDuF_wwrtw@mail.gmail.com>
	<572C61B1.2040508@atmel.com>
	<CAHHoo-j7145vPFNmJH=CvPu-BRCgRe0WNKH8QDkSc+c3koxHAQ@mail.gmail.com>
	<20160509162948.GA15535@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35958 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbcEIQo6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2016 12:44:58 -0400
Received: by mail-vk0-f51.google.com with SMTP id s184so72999742vkb.3
        for <linux-input@vger.kernel.org>; Mon, 09 May 2016 09:44:58 -0700 (PDT)
In-Reply-To: <20160509162948.GA15535@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Hung-yu Wu <hywu@google.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Grant Grundler <grundler@chromium.org>, Rob Herring <robh@kernel.org>, linux-input <linux-input@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux DeviceTree <devicetree@vger.kernel.org>

On Mon, May 9, 2016 at 9:29 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, May 06, 2016 at 11:14:12PM +0800, Daniel Hung-yu Wu wrote:
>> The register set is different, and this chip does not support calibration.
>> The I2C protocol is not the same as well; there is an additional byte
>> indicating data length.
>>
>> Atmega88PA is a general-purpose MCU. In the future, we will add more
>> functionalities, such as firmware upgrade through I2C.
>
> Is it Google who will be maintaining and extending the protocol or
> Atmel? If it is Google then maybe we should switch compat string to
> "google,captouch" or similar.

My understanding was Atmel would extend the protocol to support FW update.
No other extensions are planned.

cheers,
grant
