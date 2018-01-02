From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Tue, 2 Jan 2018 21:57:55 +0800
Message-ID: <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45373 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeABN6F (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 08:58:05 -0500
In-Reply-To: <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

No, it is not a regression of this commit.

ThinkPad X1 Yoga 2nd:
   trackpoint (ID: 01)

ThinkPad X1 Yoga 3rd:
   trackpoint (ID: 03)

Both laptop's trackpoints have the same behavior.
Writing "speed" of sysfs is failed.

Override the ID and force loading drivers/input/mouse/elantech.c,
it causes too many failure and trackpoint stops work.

The ID of "2.4.18 READ SECONDARY ID (x"E1")" in TrackPoint specification
does not indicate any other vendors but only trackpoint.
Elantech uses 0x03e9.
ALPS uses 0x00e6/0x00e7/0x00ec.

Maybe the windows tool's is wrong like Linux driver before.
