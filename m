From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Tue, 5 Apr 2011 10:39:40 -0700
Message-ID: <20110405173940.GA13086@core.coreip.homeip.net>
References: <4D9B2CD0.20404@canonical.com>
 <4D9B522B.7080201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33356 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1DERjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 13:39:47 -0400
Received: by iyb14 with SMTP id 14so595830iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 10:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9B522B.7080201@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manoj <manoj.iyer@canonical.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 05, 2011 at 12:32:27PM -0500, Manoj wrote:
> Any thoughts on this one?
> 

When both are enabled in BIOS what protocol does the kernel use to talk
to the touchpad? Does it use synaptics protocol?

Thanks.

> Manoj Iyer
> Ubuntu/Canonical
> Hardware Enablement
> 
> On 04/05/2011 09:53 AM, Manoj wrote:
> >The Lenovo X220 has a touch pad and a track point. I would like to get
> >some clues as to if there is any work around in the kernel for the issue
> >I am seeing below:
> >
> >Case 1: Touchpad and Trackpoint enabled in BIOS.
> >================================================
> >In this case the touchpad works correctly, but the trackpoint is not
> >detected at all. Some times after random number of reboots, the
> >trackpoint will start to respond approximately 15mts after X starts. But
> >the mouse will be detected as PS2 Generic Mouse.
> >
> >Case 2: Touchpad Disabled Trackpoint Enabled in BIOS
> >======================================================
> >In this case the trackpoint works as expected, and it is detected as
> >TPPS/2 IBM TrackPoint.
> >[ 9.675396] input: TPPS/2 IBM TrackPoint as
> >/devices/platform/i8042/serio1/input/input9
> >
> >I suspect this is a BIOS bug? Is it possible to work around this in the
> >kernel?
> >
> >

-- 
Dmitry
