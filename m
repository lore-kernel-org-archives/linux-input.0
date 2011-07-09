From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Sat, 09 Jul 2011 01:04:53 -0700
Message-ID: <4E180BA5.4080808@zytor.com>
References: <4E17504F.5070806@zytor.com> <20110708204630.GA28623@core.coreip.homeip.net> <4E178320.7050401@zytor.com> <20110708223709.GB28623@core.coreip.homeip.net> <4E179033.9050806@zytor.com> <20110709003508.GC28623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38793 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214Ab1GIIFH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Jul 2011 04:05:07 -0400
In-Reply-To: <20110709003508.GC28623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On 07/08/2011 05:35 PM, Dmitry Torokhov wrote:
> 
> Input only need to do this compat stuff on read/write paths so maybe if
> you add plumbing similar to compat_ioctl we could switch owver to it.
> 

The problem is that read/write ties into a large number of system calls,
and input is the *only* subsystem which needs it.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

