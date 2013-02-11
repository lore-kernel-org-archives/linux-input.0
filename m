From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/3] HID: sensor-hub: get rid of unused
 sensor_hub_grabbed_usages[] table
Date: Mon, 11 Feb 2013 12:21:37 +0100
Message-ID: <CAN+gG=EGK9nweX=1s1_g--xqapXhQu9+++GyZ=Jw=p=Q2Jz2_g@mail.gmail.com>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
	<1360578679-7029-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33670 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab3BKLVj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 06:21:39 -0500
In-Reply-To: <1360578679-7029-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

On Mon, Feb 11, 2013 at 11:31 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> This table is not used anywhere in the driver so kill it.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Yep, it's rather strange that the compiler didn't complained...
Anyway, Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
