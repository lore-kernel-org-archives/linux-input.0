From: Stefan Roese <sr@denx.de>
Subject: Support for touch controller ILI2511: Integrate into ili210x or new
 driver ?
Date: Fri, 2 Feb 2018 17:03:10 +0100
Message-ID: <92137959-654f-79f9-e15f-d9bed2185518@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:21216 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBBQDQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Feb 2018 11:03:16 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Olivier Sobrie <olivier@sobrie.be>

Hi,

I'm currently working on supporting the Ilitek ILI2511 touch controller
in mainline. The 2 choices I have are:

a) Try to integrate the ILI2511 support into the existing ili210x
    driver

or

b) Create a new driver for ILI2511 which might be suitable for other /
    future Ilitek controller

Looking at alternative a), ili210x seems to be pretty unused and in not
real good shape (only supporting platform-data, not using devm_ calls,
not using threaded interrupts etc...). I could enhance this driver but
my main concern here is, that I have no chance to test this driver on
the currently supported chips.

Alternative b) sounds more promising to me. Especially since ILI2511
supports touch protocol v3.x (Ilitek naming), which is quite different
from the currently supported protocol.

What's your recommendation here? Is it okay to go with adding a new
driver, perhaps named something like ili2xxx?

Thanks,
Stefan
