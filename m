From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: psmouse: fix input_dev leak in lifebook driver
Date: Tue, 15 Jan 2008 17:04:01 -0500
Message-ID: <20080115170323.ZZRA012@mailhub.coreip.homeip.net>
References: <20080112151252.193d6b52@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:54186 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbYAOWEK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 17:04:10 -0500
Received: by an-out-0708.google.com with SMTP id d31so1227and.103
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2008 14:04:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080112151252.193d6b52@ephemeral>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Sat, Jan 12, 2008 at 03:12:52PM -0500, Andres Salomon wrote:
> 
> The lifebook driver may register a second input device, but it never
> unregisters it.  This fixes that.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>

Applied, thank you Andres.

-- 
Dmitry

