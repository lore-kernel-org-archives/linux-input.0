From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 11:47:47 +0800
Message-ID: <4E4C8B63.7030108@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <4E4C8758.4020205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61929 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755048Ab1HRDrY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:47:24 -0400
In-Reply-To: <4E4C8758.4020205@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

>> +
>> +    case 3:
>> +        if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>> +            elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
>> +            elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>> +            elantech_ps2_command(psmouse, NULL, reg) ||
>> +            elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO)) {
>> +            rc = -1;
>> +        }
> Prefer to remove these big brace ?
> also with "case 1, case 2 "?

Just wondering What's wrong with this piece of code and what do you
sugguest to improve it?
