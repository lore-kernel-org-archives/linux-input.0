From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8] Input: psxpad-spi - Add PlayStation 1/2 joypads via
 SPI interface Driver
Date: Tue, 9 May 2017 17:44:53 -0700
Message-ID: <20170510004453.GB32584@dtor-ws>
References: <1494294412-3122-1-git-send-email-sylph23k@gmail.com>
 <CAGeZN5NFCRhY+KRgtj0Ad7yJvsh7dUvjUpMfGAiVOHiGkmq9qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:34929 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdEJAo5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 20:44:57 -0400
Content-Disposition: inline
In-Reply-To: <CAGeZN5NFCRhY+KRgtj0Ad7yJvsh7dUvjUpMfGAiVOHiGkmq9qQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomohiro Yoshidomi <sylph23k@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi,

On Tue, May 09, 2017 at 10:50:11AM +0900, Tomohiro Yoshidomi wrote:
> Mr.Torokhov
> 
> Hi.
> I fixed source, and sent v8 patch to you.
> 
> * FF codes ('CONFIG_JOYSTICK_PSXPAD_SPI_FF' defined),
>   put together in one place.
> 
> * psxpad_spi_suspend() stub removed again.

Could you please test the version of the patch I sent to you? It had
more changes than the 2 you mentioned above.

Thanks.

-- 
Dmitry
