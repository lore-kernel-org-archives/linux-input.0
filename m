From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] input: misc: AD714x: Add option to specify irqflags
Date: Wed, 11 May 2011 14:20:25 -0700
Message-ID: <20110511212025.GD11178@core.coreip.homeip.net>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
 <1305027309-17637-4-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59200 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab1EKVUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 17:20:32 -0400
Received: by pvg12 with SMTP id 12so420984pvg.19
        for <linux-input@vger.kernel.org>; Wed, 11 May 2011 14:20:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305027309-17637-4-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

On Tue, May 10, 2011 at 01:35:08PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add option to specify irqflags.
> Use IRQF_TRIGGER_LOW | IRQF_ONESHOT if not set otherwise.

This would break existing users that expect IRQF_TRIGGER_FALLING. I'd
leave the default flags as they were.

Thanks.

-- 
Dmitry
