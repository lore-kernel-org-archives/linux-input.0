From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: gpio_keys_polled and MSC_SCAN
Date: Tue, 21 May 2013 11:13:20 +0200
Message-ID: <CAH9NwWdSogEFjfk6NMrZHNcFO5KL9PZ_AxH_=VdrSqLanD4iAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45755 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3EUJNk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 05:13:40 -0400
Received: by mail-qc0-f174.google.com with SMTP id m16so194504qcq.5
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 02:13:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all.

I am using the gpio_keys_polled driver to simulate a F20 key press. My
target application
a HTML5 application running in the browser on the target device will
read the keycode
via java script. The problem is that no MSC_SCAN is send from the driver.

# evtest /dev/input/event4
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
Input device name: "gpio-keys-polled"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 190 (KEY_F20)
Testing ... (interrupt to exit)
Event: time 1369127353.064272, type 1 (EV_KEY), code 190 (KEY_F20), value 1
Event: time 1369127353.064298, -------------- SYN_REPORT ------------
Event: time 1369127353.314149, type 1 (EV_KEY), code 190 (KEY_F20), value 0
Event: time 1369127353.314152, -------------- SYN_REPORT ------------


vs. USB keyboard

Testing ... (interrupt to exit)
Event: time 1369127339.805042, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70045
Event: time 1369127339.805061, type 1 (EV_KEY), code 88 (KEY_F12), value 1
Event: time 1369127339.805069, -------------- SYN_REPORT ------------
Event: time 1369127340.053526, type 1 (EV_KEY), code 88 (KEY_F12), value 2
Event: time 1369127340.053531, -------------- SYN_REPORT ------------
Event: time 1369127340.093528, type 1 (EV_KEY), code 88 (KEY_F12), value 2
Event: time 1369127340.093532, -------------- SYN_REPORT ------------
Event: time 1369127340.133526, type 1 (EV_KEY), code 88 (KEY_F12), value 2
Event: time 1369127340.133531, -------------- SYN_REPORT ------------
Event: time 1369127340.173524, type 1 (EV_KEY), code 88 (KEY_F12), value 2


This is how i setup my button:

static struct gpio_keys_button device_gpio_keys[] = {
        {
                .code = KEY_F20, /* See include/linux/input.h */
                .type = EV_KEY,
                .gpio = 235,
                .active_low = 1,
                .desc = "F20",
                .wakeup = 0,
        },
};


Is there a way to also get the scan code?

thanks
--
Christian Gmeiner, MSc
