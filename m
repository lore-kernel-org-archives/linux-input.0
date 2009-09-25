From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: private ioctls in input driver
Date: Thu, 24 Sep 2009 21:02:05 -0700
Message-ID: <20090925040204.GD416@core.coreip.homeip.net>
References: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:64749 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZIYECE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 00:02:04 -0400
Received: by mail-qy0-f174.google.com with SMTP id 4so1791845qyk.33
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2009 21:02:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Trilok,

On Thu, Sep 24, 2009 at 05:21:09PM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> Is there any way of creating private ioctls in the input driver? I see
> that all the input framework handled
> by the framework itself and there is no way to call private ioctls if
> it doesn't match the standard ones.
> 

You are right, event devices only allow standard ioctl. What kind of
ictl are you considering? Normally device-specific controls are done via
sysfs attached to the parent device (see atkbd, psmouse, etc).

-- 
Dmitry
