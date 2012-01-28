From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Required modules for the joystick read/write
Date: Sat, 28 Jan 2012 12:59:41 -0800
Message-ID: <20120128205941.GD23595@core.coreip.homeip.net>
References: <CAM1yFZ9KrKdv3ptyq2NQ0PdPC_tFLezjq_2K+ut95uE0=HKRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41847 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab2A1U7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jan 2012 15:59:46 -0500
Received: by dadi2 with SMTP id i2so2422003dad.19
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 12:59:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAM1yFZ9KrKdv3ptyq2NQ0PdPC_tFLezjq_2K+ut95uE0=HKRPw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Jan 24, 2012 at 09:58:11AM +0530, Anisha Kaul wrote:
> Greetz,
> 
> If the `jstest` recognizes the joystick and reads the values from it,
> does it mean that all
> the required modules are already loaded into the kernel?
> 
> Do we still need to load any more modules for enabling the force
> feedback (if supported
> by the joystick)?
> 

If force feedback support is enabled then it is already present in the
kernel, there is no separate module.

-- 
Dmitry
