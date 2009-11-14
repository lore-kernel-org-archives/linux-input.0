From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/1] Input polldev: Sysfs interface for setting of
	polling interval
Date: Fri, 13 Nov 2009 21:26:17 -0800
Message-ID: <20091114052617.GE4463@core.coreip.homeip.net>
References: <1257840047-7751-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50492 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZKNF0S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Nov 2009 00:26:18 -0500
Received: by pwi3 with SMTP id 3so2379363pwi.21
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2009 21:26:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257840047-7751-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Samu,

On Tue, Nov 10, 2009 at 10:00:47AM +0200, Samu Onkalo wrote:
> Sysfs entry for reading and setting of the polling interval.
> If the interval is set to 0, polling is stopped. Polling
> is restarted when interval is changed to non-zero.
> 
> sysfs entries:
> poll = current polling interval in msec (RW)
> max = max allowed polling interval (RO)
> min = min allowed polling interval (RO)
> 
> Minimum and maximum limit for interval can be set while setting up the
> device.
> 
> Interval can be adjusted even if the input device is not currently open.

Applied, thank you.

-- 
Dmitry
