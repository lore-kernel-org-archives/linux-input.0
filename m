From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v5] i8042: Add unmask_kbd_data option
Date: Fri, 3 Jul 2015 14:05:36 +0200
Message-ID: <20150703120536.GA17743@rhlx01.hs-esslingen.de>
References: <20150627203543.GA31870@rhlx01.hs-esslingen.de>
 <1435852008-4509-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:38673 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbbGCMFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jul 2015 08:05:38 -0400
Content-Disposition: inline
In-Reply-To: <1435852008-4509-1-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Mohr <andi@lisas.de>

On Thu, Jul 02, 2015 at 11:46:48AM -0400, cpaul@redhat.com wrote:
> 				    Changes
> * Fix incorrect option name in MODULE_PARM_DESC() (I have no idea how that
>   happened in the first place)
> * Replaced the description with one of the suggestions given by Andreas
> * Rename debug_kbd to unmask_kbd_data
> * Improve description in Documentation/kernel-parameters.txt

Patch in its entirety seems fine to me, thanks!

Reviewed-by: Andreas Mohr <andim2@users.sf.net>
