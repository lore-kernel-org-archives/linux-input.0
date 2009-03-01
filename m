From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Notification when a new device is added or removed
Date: Sat, 28 Feb 2009 18:39:48 -0800
Message-ID: <20090228183917.ZZRA012@mailhub.coreip.homeip.net>
References: <49A8BEF7.9060602@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:43722 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZCACkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 21:40:00 -0500
Received: by an-out-0708.google.com with SMTP id c2so1340220anc.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2009 18:39:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <49A8BEF7.9060602@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Fri, Feb 27, 2009 at 08:35:03PM -0800, Alessio Sangalli wrote:
> Hi, what is the easiest way to get somewhat notified when a device is
> added or removed from the system? I know /proc/bus/input/devices reports
> the devices list, can I make use of that? I am in an embedded
> environment where I prefer not having to bringup all the hotplug + udev
> infrastructure.
> 

You should be able to poll (select) /proc/bus/input/devices.

-- 
Dmitry
