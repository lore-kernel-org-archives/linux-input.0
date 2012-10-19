From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: matrix-keypad - remove const from pointer to
 array of gpios
Date: Fri, 19 Oct 2012 16:00:59 -0700
Message-ID: <20121019230059.GB10915@core.coreip.homeip.net>
References: <1350630373-24279-1-git-send-email-anilkumar@ti.com>
 <1350630373-24279-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58717 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab2JSXBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Oct 2012 19:01:04 -0400
Content-Disposition: inline
In-Reply-To: <1350630373-24279-2-git-send-email-anilkumar@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, dgdunix@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Fri, Oct 19, 2012 at 12:36:12PM +0530, AnilKumar Ch wrote:
> Remove const from pointer to array of gpios in matrix_keypad_platform_data
> struct. This is required if we update row_gpios and col_gpios based on
> device tree data.

Then don't. Set them up via non-const aliases instead.

Thanks.

-- 
Dmitry
