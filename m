From: Tolga Cakir <cevelnet@gmail.com>
Subject: HID: microsoft: lacking keycodes for Sidewinder X4 / X6 support
Date: Wed, 5 Mar 2014 15:40:36 +0100
Message-ID: <CABcamCCnxupDiAdokyMVMuetLCZUNk-q6qnBPdU-tF2vimR7Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52188 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419AbaCEOki (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Mar 2014 09:40:38 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so1341961wgh.3
        for <linux-input@vger.kernel.org>; Wed, 05 Mar 2014 06:40:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi there,

I'm currently working on a kernel module patch, adding support for the
Microsoft Sidewinder X4 / X6 gaming keyboards. There are 30 dedicated
extra keys on the Sidewinder X6, all sending out individual USB codes
and 6 extra keys on the Sidewinder X4. Also, both devices feature 3
profiles for each of these extra keys, resulting in about 90 extra
keys for the Sidewinder X6 and 18 for the X4. While picking 18
keycodes for the Sidewinder X4 is not a big issue (KEY_F13 - KEY_F24,
KEY_WWW, KEY_EMAIL, KEY_PROG[1-4]), I'm having a hard time choosing
something reasonable for the X6. These keys are (software)
programmable and therefore don't need to have a function except
sending out an individual, unqiue keycode.

The problem I'm facing is not technical; it's more of a design
question. With keyboards like the Corsair K90 / K95 (18 macro keys, 3
profiles each, total of 54 extra keys) or the Logitech G110 (12 macro
keys, 3 profiles, 36 extra keys), there's need for dedicated, general
keycodes for extra keys. So, I'd propose defining KEY_M1 - KEY_M100 (M
for macro) in linux/input.h for such uses or extending the already
defined F-keys up to KEY_F100. What are your thoughts about this?

Here's the work-in-progress code:
https://github.com/tolga9009/hid-sidewinder-x4/blob/master/hid-microsoft.c

Thank you for your time,
Tolga Cakir
