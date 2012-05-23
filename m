From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] input: Force Sentelic reconnect when mode setting has
 failed
Date: Thu, 24 May 2012 01:22:45 +0800 (CST)
Message-ID: <1205240109410.9614@cnaqrzbavhz.fragryvp.pbz>
References: <1337468192-16337-1-git-send-email-mjg@redhat.com>
 <12052123215711.9614@cnaqrzbavhz.fragryvp.pbz> <20120521152851.GA3552@srcf.ucam.org>
 <12052211372417.9614@cnaqrzbavhz.fragryvp.pbz> <20120522202839.GA9140@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:25312 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2EWRWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 May 2012 13:22:54 -0400
In-Reply-To: <20120522202839.GA9140@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: os@ohmu.fi, dtor@mail.ru, linux-input@vger.kernel.org

On Tue, 22 May 2012, Matthew Garrett wrote:
> When working: 0700, 4005, 4180, 4237
> When broken : 0700, 4005, 4180, 4237

   There's no hardware reset according to this dump.

   Now I'm confused: the hardware default of FSP_REG_SWC1 is zero and
there's no single piece of code(dirver/firmware) that will set SWC1 to
0x80 as far as I can remember.
