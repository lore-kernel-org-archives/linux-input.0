From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: Changing the settings of the device driver
Date: Tue, 15 Nov 2011 22:29:21 +0530
Message-ID: <4EC29A69.8080102@ti.com>
References: <4EC29492.5030209@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51758 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661Ab1KOQ7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 11:59:33 -0500
Received: by mail-pz0-f48.google.com with SMTP id 32so17575382pzk.7
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 08:59:27 -0800 (PST)
In-Reply-To: <4EC29492.5030209@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Tuesday 15 November 2011 10:04 PM, Nuno Santos wrote:
> Hi,
>
> I have been reading about linux kernel development and ioctl seems to
> be discouraged by kernel developers.
>
> However ioctl is precisely what i'm looking for to mimic what I have
> in my Windows driver version.
>
> Should I consider an option to implement ioctl's to change my device
> settings?

What kind of settings?
By the way give sysfs a thought.
>
> Thanks,
>
> Nuno
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

