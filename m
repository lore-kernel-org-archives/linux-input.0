Return-Path: <SRS0=Y9e+=A3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B557FC433EA
	for <linux-input@archiver.kernel.org>; Thu, 16 Jul 2020 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9668B207E8
	for <linux-input@archiver.kernel.org>; Thu, 16 Jul 2020 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPNTh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:19:37 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43597 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728709AbgGPNTg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Jul 2020 09:19:36 -0400
Received: from [192.168.0.7] (ip5f5af4de.dynamic.kabel-deutschland.de [95.90.244.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 47478206466C6;
        Thu, 16 Jul 2020 15:19:33 +0200 (CEST)
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-input@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: No pinch events with Dell laptops and Alps
Message-ID: <8b4907c5-4af8-2a2c-bbe1-46b2be2980be@molgen.mpg.de>
Date:   Thu, 16 Jul 2020 15:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Dear Linux folks,


On the Dell Latitude E7250 and Dell Precision 3340 I fail to get three 
finger pinch events generated needed for GNOME Shell gestures [1].

Debian Sid/unstable with Linux 5.7.6 is running on these systems.

     [    1.602394] input: AlpsPS/2 ALPS GlidePoint as 
/devices/platform/i8042/serio1/input/input2

I am only able to create swipe events. (Four finger swipe works to 
switch workspaces.)

```
$ sudo libinput debug-events
[…]
-event1   DEVICE_ADDED     AlpsPS/2 ALPS GlidePoint          seat0 
default group10 cap:pg  size 98x51mm tap(dl off) left scroll-nat 
scroll-2fg-edge dwt-on
-event2   DEVICE_ADDED     DELL Wireless hotkeys             seat0 
default group11 cap:k
event1  - AlpsPS/2 ALPS GlidePoint: kernel bug: Wrong slot count (4), 
reducing to 2
-event1   GESTURE_SWIPE_BEGIN +1.549s	3
  event1   GESTURE_SWIPE_UPDATE +1.549s	3 -0.36/ 0.26 (-2.59/ 1.85 
unaccelerated)
[…]
```

Does the hardware and driver support that?


Kind regards,

Paul


[1]: https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/2897
