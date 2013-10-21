From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
Subject: Re: [PATCH] Input: add regulator haptic driver
Date: Mon, 21 Oct 2013 08:06:34 -0400
Message-ID: <20131021120634.GA24439@jake.ruivo.org>
References: <000a01cec629$3cf34de0$b6d9e9a0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([173.14.175.98]:36949 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab3JUMRA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 08:17:00 -0400
Content-Disposition: inline
In-Reply-To: <000a01cec629$3cf34de0$b6d9e9a0$%kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "hyunhee.kim" <hyunhee.kim@samsung.com>
Cc: dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@ti.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kyungmin.park@samsung.com

Hi Hyunhee,
On Fri, Oct 11, 2013 at 11:26:05AM +0900, hyunhee.kim wrote:
> +static void regulator_haptic_work(struct work_struct *work)
> +{
> +	struct regulator_haptic *haptic = container_of(work,
> +						       struct
> regulator_haptic,

you got a line wrap damage patch

-- 
Aristeu

