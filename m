From: Tomohiro Yoshidomi <sylph23k@gmail.com>
Subject: Re: [PATCH v7] Input: psxpad-spi - Add PlayStation 1/2 joypads via
 SPI interface Driver
Date: Sun, 30 Apr 2017 14:12:04 +0900
Message-ID: <CAGeZN5NceKWi6bbX-GyqKYo=0UokB_78fMz8j+gUowZuGrOzfQ@mail.gmail.com>
References: <20170430051103.703-1-sylph23k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34391 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162149AbdD3FMF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Apr 2017 01:12:05 -0400
In-Reply-To: <20170430051103.703-1-sylph23k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomohiro Yoshidomi <typesylph@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Mr.Torokhov

I fixed source, and sent PATCH v7 to you.
I'm sorry to occars warnings.

* In function 'psxpad_spi_probe',
  removed uninitialized value 'err' in dev_err().

* 'psxpad_spi_resume' restored.

Regards.

--
Tomohiro
