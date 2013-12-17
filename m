From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Disable i8042 check on Apple machines
Date: Tue, 17 Dec 2013 08:35:19 -0800
Message-ID: <20131217163519.GA16989@core.coreip.homeip.net>
References: <CA+5PVA565FmR+f5eOZDSUv_pb-pbgExg5L6zHXf9aJyNUoRVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40074 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3LQQfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 11:35:23 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so4672577pad.12
        for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 08:35:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+5PVA565FmR+f5eOZDSUv_pb-pbgExg5L6zHXf9aJyNUoRVdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Bastien Nocera <bnocera@redhat.com>, linux-input@vger.kernel.org

On Tue, Dec 17, 2013 at 10:25:36AM -0500, Josh Boyer wrote:
> Hi Bastien and Dmitry,
> 
> I was going through some of the patches we're carrying in Fedora and
> came across this one that Bastien submitted a long time ago:
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/1005.0/00938.html
> 
> It works and we're still carrying it, but Dmitry said it needed to be
> done differently in i8042-x86ia64io.h.  Would that just mean adding a
> DMI for Apple machines to the i8042_dmi_nopnp_table struct?  Or
> exactly what should be done here?

That is one possible option that I had in mind originally. Another would
be to modify arch/x86/kernel/x86_init.c::default_x86_detect() and add
the check there.

Thanks.

-- 
Dmitry
