From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: tegra-kbc: Add Function keymap.
Date: Wed, 16 Feb 2011 13:19:40 -0800
Message-ID: <20110216211940.GB31387@core.coreip.homeip.net>
References: <1297280680-7555-1-git-send-email-riyer@nvidia.com>
 <20110216081208.GA12787@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DF@HQMAIL03.nvidia.com>
 <20110216200349.GA31387@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080E0@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56527 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1BPVTw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 16:19:52 -0500
Received: by yxt3 with SMTP id 3so810897yxt.19
        for <linux-input@vger.kernel.org>; Wed, 16 Feb 2011 13:19:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A0080E0@HQMAIL03.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

On Wed, Feb 16, 2011 at 12:12:54PM -0800, Rakesh Iyer wrote:
> I agree with that, and that was my original plan.
> 
> But I saw matrix_keypad.h has the MATRIX_MAX_ROWS defined at 16, and decided to
> accommodate for it.
> 

Conveniently we just increased MATRIX_MAX_ROWS/COLS to 32 (see
commit cfaea56741360311d0dabcb6603fa78c2e3de155 in mainline).

Thanks.

-- 
Dmitry
