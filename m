From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Fri, 5 Jan 2018 08:23:13 -0800
Message-ID: <20180105162313.higyrbd6unumgtjb@dtor-ws>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
 <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:41401 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeAEQXR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Jan 2018 11:23:17 -0500
Received: by mail-pg0-f52.google.com with SMTP id 77so2157148pgd.8
        for <linux-input@vger.kernel.org>; Fri, 05 Jan 2018 08:23:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

Hi Aaron,

On Fri, Jan 05, 2018 at 09:29:26PM +0800, Aaron Ma wrote:
> Hi Dmitry:
> 
> Got the official info from Lenovo:
> Lenovo introduced new TrackPoint compatible sticks ( ELAN/Alps/NXP
> sticks) from 2016.
> These new devices only support the minimum commands described in the
> spec, which has been used in the current Windows driver.

What is the exact list of the commands supported by each variant?

> 
> Legacy TrackPoint: 0101 – 0E01
> ALPS: 0102 – FF02
> ELAN:0103 – FF03
> NXP: 0104 – FF04
> 
> 2.4.18 READ SECONDARY ID (x"E1")
> This command will read the secondary device ID of the pointing device (2
> bytes).  The least significant byte is sent first.  For the first byte,
> the legacy TrackPoint controller from IBM will always return x"01", the
> pointing stick from ALPS will always return x"02", the pointing stick
> from Elan will always return x"03”, and the pointing stick from NXP will
> always return 0x”04".  And a second byte which denotes a specific set of
> functional specifications.  Differing ROM versions are used to denote
> changes within a given functional set.

Can you/Lenovo share the updated spec?

> 
> The new devices (include Legacy ID:01) will not support the sysfs like
> speed.
> 
> So it is not right to revert the commit, it is about to add another 0x04
> ID in it.
> 
> Old sysfs could be stayed for old legacy device ID:01 or removed.

No, because there are devices that have trackpoints properly
implementing the protocol, before Lenovo started their "innovation".

Do we have any way to distinguish between properly implemented
trackpoints and Lenovo "improved" ones? I played with gen3 Carbon, and
while it does not error out on "speed" attribute, unlike gen5, it still
has no visible effects. Additionally, the "press to select"
functionality seems to be disabled, and trying to enable it via sysfs
results in register content being reverted to the original "disabled"
setting in a second or two. Setting to swap X and Y axes does not work
either, not sure about other bits of that control register.
"sensitivity" does work though, again unlike my gen5.

Thanks.

-- 
Dmitry
