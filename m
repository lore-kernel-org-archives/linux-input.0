From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag for 74
 03 28 devices
Date: Fri, 3 Mar 2017 14:58:34 -0500
Message-ID: <78be095c-a7ae-328d-dd0a-b8470dfc1318@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdCCT6x (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Mar 2017 14:58:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ben@smart-cactus.org
Cc: mhocko@suse.com, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-kernel@PaulSD.com, linux@roeck-us.net, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Ben,

A kernel bug report was opened against Ubuntu [0].  After a kernel
bisect, it was found that reverting the following commit resolved this bug:

commit aeaa881f9b17823028b464893b89c42db797b717
Author: Ben Gamari <ben@smart-cactus.org>
Date:   Tue Oct 4 11:43:30 2016 -0700

    Input: ALPS - set DualPoint flag for 74 03 28 devices

The regression was introduced as of v4.9-rc1.

I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?


Thanks,

Joe

[0] http://pad.lv/1662589


