From: Corentin Chary <corentin.chary@gmail.com>
Subject: Adding a special key for touchpad toggle
Date: Fri, 9 Oct 2009 21:41:30 +0200
Message-ID: <71cd59b00910091241m115ee71cl54b76173dac1d74f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934154AbZJITmJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,
in drivers/platform/x86/ there is 3 drivers who need a key to toggle
the touchpad:
- topstar-laptop.c: mapped to KEY_F13
- asus-laptop.c: mapped to BTN_TOUCH, don't know why
- eeepc-laptop.c: I didn't do the patch yet, because I don't know what
key to use

Do you think we need a new key ? (KEY_TOUCHPAD)
Should we use KEY_F13 in all drivers ?
Thanks,
-- 
Corentin Chary
http://xf.iksaif.net
