From: Ville Ranki <ville.ranki@iki.fi>
Subject: Re: [PATCH] Input: joydev - Recognize joysticks with Z axis as
 joysticks.
Date: Fri, 2 Sep 2016 12:11:09 +0300
Message-ID: <7266b6f9-3623-f08c-abce-62d0daa6e77d@iki.fi>
References: <1472134610-6438-1-git-send-email-ville.ranki@iki.fi>
 <20160825164530.GD11206@dtor-ws>
 <e0aece92-b147-4c7d-90a9-c0243a224b01@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.tut.fi ([130.230.4.42]:62001 "HELO mail.cs.tut.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750873AbcIBJLQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Sep 2016 05:11:16 -0400
In-Reply-To: <e0aece92-b147-4c7d-90a9-c0243a224b01@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 08/25/2016 11:56 PM, Ville Ranki wrote:
> On 08/25/2016 07:45 PM, Dmitry Torokhov wrote:
>>> This patch adds ABS_Z to the input_device_id list allowing 
>>> devices with ABS_Z axis to be detected correctly.
> 
>> I am curious why you still use joydev and not switch your
>> client(s) to evdev? Or is it some legacy game?
> 
> Yes, this is about legacy games. For example X-Plane requires 
> joystick node to be present.

Was this patch accepted or rejected? In distros event devices are
not readable by non-root users by default while joystick devices are.
These can be changed with udev rules, but IMO joystick detection
should be fixed on kernel level.

-- 
Ville Ranki <ville.ranki@iki.fi>
http://www.iki.fi/~cos
PGP public key: http://www.iki.fi/~cos/vranki_pub.asc
