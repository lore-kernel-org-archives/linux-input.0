From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Fri, 5 Jan 2018 21:29:26 +0800
Message-ID: <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeAEN3d (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Jan 2018 08:29:33 -0500
In-Reply-To: <20180105005659.j2x56opkq74wm7v2@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

Hi Dmitry:

Got the official info from Lenovo:
Lenovo introduced new TrackPoint compatible sticks ( ELAN/Alps/NXP
sticks) from 2016.
These new devices only support the minimum commands described in the
spec, which has been used in the current Windows driver.

Legacy TrackPoint: 0101 – 0E01
ALPS: 0102 – FF02
ELAN:0103 – FF03
NXP: 0104 – FF04

2.4.18 READ SECONDARY ID (x"E1")
This command will read the secondary device ID of the pointing device (2
bytes).  The least significant byte is sent first.  For the first byte,
the legacy TrackPoint controller from IBM will always return x"01", the
pointing stick from ALPS will always return x"02", the pointing stick
from Elan will always return x"03”, and the pointing stick from NXP will
always return 0x”04".  And a second byte which denotes a specific set of
functional specifications.  Differing ROM versions are used to denote
changes within a given functional set.

The new devices (include Legacy ID:01) will not support the sysfs like
speed.

So it is not right to revert the commit, it is about to add another 0x04
ID in it.

Old sysfs could be stayed for old legacy device ID:01 or removed.

Aaron
