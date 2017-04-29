From: Tomohiro Yoshidomi <sylph23k@gmail.com>
Subject: Re: [PATCH v5] Input: psxpad-spi - Add PSX (Play Station 1/2) pad SPI driver
Date: Sat, 29 Apr 2017 18:44:32 +0900
Message-ID: <CAGeZN5O8aova6EJ9SQeu0ZKUYMUuY6YTFuGNNiej_O17aFaxVQ@mail.gmail.com>
References: <20170429094053.26870-1-sylph23k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34908 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426723AbdD2Joe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 29 Apr 2017 05:44:34 -0400
In-Reply-To: <20170429094053.26870-1-sylph23k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomohiro Yoshidomi <typesylph@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Mr.Torokhov

I changed source, and sent PATCH v5 to you.

* Delete about 'analog 2'
Deleted experimental features.
Possibility of confusing SDL.

* Delete about setadmode()
Never set analog mode from the system to the pad.

* Delete SPI 'delay_usecs'
Unnecessary

* Delete psxpad_spi_deinit_ff()
Unused

* Chande #define to immd value

* Fix memory free in init()
By build bot warning.

* Fix in suspend()/resume()
Just rumble stop at suspend.

* Fix pool -> poll
* Fix AZO -> Tomohiro

Regard.

---
Tomohiro Yoshidomi <sylph23k@gmail.com>
