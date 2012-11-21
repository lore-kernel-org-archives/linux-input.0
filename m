From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] hid: hid-sensor-hub: Move NULL check to beginning
Date: Wed, 21 Nov 2012 09:11:39 -0800
Message-ID: <50AD0B4B.10109@linux.intel.com>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org> <1353478830-23788-2-git-send-email-sachin.kamat@linaro.org> <20121121124251.7bc7102b@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59653 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2KURKu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 12:10:50 -0500
In-Reply-To: <20121121124251.7bc7102b@pyramind.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jic23@kernel.org
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, jkosina@suse.cz, patches@linaro.org

Hi Jonathan,

Please check and merge Alan Cox's patch. I have forwarded this patch to you.

Thanks,
Srinivas


On 11/21/2012 04:42 AM, Alan Cox wrote:
> On Wed, 21 Nov 2012 11:50:30 +0530
> Sachin Kamat <sachin.kamat@linaro.org> wrote:
>
>> This avoids a possible NULL pointer dereference error when report
>> is NULL.
> This is wrong. Please see the patch I sent a while ago - it can't be
> NULL, the check just needs removing.
>

