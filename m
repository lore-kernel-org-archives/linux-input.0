From: "s.rawat" <imsaurabhrawat@gmail.com>
Subject: Using hidraw example for HID I2C devices
Date: Mon, 25 May 2015 10:55:24 -0700
Message-ID: <CALwa49v7B=LeHZh99XokRR3caTwEg=Ma87HWbn1RoOgUR-CqBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33117 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbEYRzq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:55:46 -0400
Received: by wicmx19 with SMTP id mx19so45694860wic.0
        for <linux-input@vger.kernel.org>; Mon, 25 May 2015 10:55:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi,
Can hid-example.c at Linux/samples/hidraw/hid-example.c be used for
HID I2C device as well without any modifications except adding without
breaking any configuration of the HID I2C devices :

case BUS_I2C:
 return "I2C";

in function : const char * bus_str(int bus)

Thanks,S
