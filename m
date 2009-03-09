From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Notification when a new device is added or removed
Date: Mon, 09 Mar 2009 13:06:53 +0100
Message-ID: <87iqmidhnm.fsf@macbook.be.48ers.dk>
References: <49A8BEF7.9060602@manoweb.com>
	<20090228183917.ZZRA012@mailhub.coreip.homeip.net>
	<49A9F9BD.2090604@manoweb.com>
	<20090301022212.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:42144 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbZCIMG7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2009 08:06:59 -0400
Received: by ewy25 with SMTP id 25so834867ewy.37
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2009 05:06:56 -0700 (PDT)
In-Reply-To: <20090301022212.ZZRA012@mailhub.coreip.homeip.net> (Dmitry Torokhov's message of "Sun\, 1 Mar 2009 02\:23\:19 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessio Sangalli <alesan@manoweb.com>, linux-input@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

Hi,

 >> > You should be able to poll (select) /proc/bus/input/devices.
 >> 
 >> Yeah that would be great; anyway, I tried and... well nothing happens. I
 >> am obviously missing something here:
 >> 

 Dmitry> Hmm, it turns out poll is completely busted. The patch below should
 Dmitry> help.

2.6.29 material?

-- 
Bye, Peter Korsgaard
