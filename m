From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: EV_PWR events for reporting battery state?
Date: Tue, 16 Feb 2010 21:19:40 -0800
Message-ID: <20100217051940.GC7160@core.coreip.homeip.net>
References: <1266357620.4195.10.camel@pldmachine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:44181 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0BQFTs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 00:19:48 -0500
Received: by gxk27 with SMTP id 27so788790gxk.1
        for <linux-input@vger.kernel.org>; Tue, 16 Feb 2010 21:19:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266357620.4195.10.camel@pldmachine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-input@vger.kernel.org

Hi Przemo,

On Tue, Feb 16, 2010 at 10:00:20PM +0000, Przemo Firszt wrote:
> Hi,
> I'm developing device driver for a bluetooth device. I need to report
> battery state/ac plugged status via input_event function. I've 2 ideas
> what event I could use: EV_MSC/MSC_RAW or define something for EV_PWR
> i.e.:
> PWR_BAT for reporting battery operation, 
> PWR_AC for ac connected and 
> PWR_STT for battery state.
> 
> There are some definitions in HID usage tables in HID specification, but
> I cannot see any of them implemented in kernel (or I omitted something).

I maintain that these kind of events are outside of input subsystem
doman (which I would like to limit to human interfaces, not general
purpose transport).

-- 
Dmitry
