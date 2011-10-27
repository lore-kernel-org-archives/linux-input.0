From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for new (3rd generation) Bambbo P&Ts
Date: Wed, 26 Oct 2011 22:35:02 -0700
Message-ID: <20111027053502.GB15725@core.coreip.homeip.net>
References: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45302 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1J0FfI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 01:35:08 -0400
Received: by ywm3 with SMTP id 3so2297253ywm.19
        for <linux-input@vger.kernel.org>; Wed, 26 Oct 2011 22:35:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se

On Sun, Oct 23, 2011 at 05:28:54PM -0500, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> New in v3: Minor style and comment updates based on Henrik's
> feedback in patch 6. Moved packet size definition to patch 5
> to make compilable/bisectable without patch 6.
> 
> New in v2: Indentation fixes in patch 6.
> 
> Wacom has released in the last month a 3rd generation of their
> Bamboo Pen and Touch line and this patch series adds support
> for them all. There are 3 new models.  2 include stylus and touch
> support and can track up to 16 touches.  1 is a stylus only tablet.
> 
> A squashed version of this patch series has been tested by 1 user
> for each tablet type over at linuxwacom-discuss mailing list.
> 
> Chris Bagwell (6):
>   Input: wacom - cleanup feature report for bamboos
>   Input: wacom - remove unused bamboo HID parsing
>   Input: wacom - add some comments to wacom_parse_hid
>   Input: wacom - relax Bamboo stylus ID check
>   Input: wacom - read 3rd gen Bamboo Touch HID data
>   Input: wacom - 3rd gen Bamboo P&Touch packet support

Applied all 6 for 3.3.

-- 
Dmitry
