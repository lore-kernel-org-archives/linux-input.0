From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: gpio-keys-polled enhancements v2
Date: Thu, 14 Feb 2019 09:36:17 +0100
Message-ID: <1550133379-1793-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi folks,


here's v2 of my gpio-keys-polled enhancements queue.

I'm using this to allow it to be initialized by some other platform
driver (in my case for the APUv2 board), when no proper fw data
(oftree or acpi) is available.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
