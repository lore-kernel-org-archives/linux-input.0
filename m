From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: private ioctls in input driver
Date: Fri, 25 Sep 2009 14:21:40 +0530
Message-ID: <5d5443650909250151h55b0eeefx7ce91f32bb287e3b@mail.gmail.com>
References: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com>
	 <20090925040204.GD416@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:47782 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZIYIvh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 04:51:37 -0400
Received: by qyk4 with SMTP id 4so1871881qyk.33
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2009 01:51:40 -0700 (PDT)
In-Reply-To: <20090925040204.GD416@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, Sep 25, 2009 at 9:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Trilok,
>
> On Thu, Sep 24, 2009 at 05:21:09PM +0530, Trilok Soni wrote:
>> Hi Dmitry,
>>
>> Is there any way of creating private ioctls in the input driver? I see
>> that all the input framework handled
>> by the framework itself and there is no way to call private ioctls if
>> it doesn't match the standard ones.
>>
>
> You are right, event devices only allow standard ioctl. What kind of
> ictl are you considering? Normally device-specific controls are done via
> sysfs attached to the parent device (see atkbd, psmouse, etc).

sysfs might good for purpose when you can associate one file per
value, so for more data we can't simply create one file per the data.
Say five fingers touch data (I know we have MT_* support but here it
is just for example) , say id, x, y, z etc., per finger, then we can't
create one file for each of them.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
