From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: hid-lg2ff handling of zero/low magnitude rumble effects
Date: Thu, 27 Mar 2014 23:13:35 +0100
Message-ID: <CADbOyBRGha3+X8RSjvOU=ftTGuDGYAyuFW_b7==0HeF1uBLV-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:53919 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633AbaC0WNg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 18:13:36 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so5090101vcb.30
        for <linux-input@vger.kernel.org>; Thu, 27 Mar 2014 15:13:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org

Hi,


I noticed that my rumble wheel (Logitech Formula Vibration Feedback)
reacts in a strange way when sending low rumble magnitudes to the
device:

Assume the following USB command to be send to emit rumble:
    report->field[0]->value[0] = 0x51;
    report->field[0]->value[2] = weak;
    report->field[0]->value[4] = strong;
When 'weak' or 'strong' is lower than 0x02 (i.e. 0x01 or 0x00), then
the corresponding rumble motor begins to rumble intermittently, this
resembles a bit to forcing a 2-state light-switch to be in the middle
position.

Now my question is whether all other devices (e.g. "Logitech
RumblePad", "Rumblepad 2") experience this behaviour?
(If you own such a device, please verify this.)


Best regards,

Elias
