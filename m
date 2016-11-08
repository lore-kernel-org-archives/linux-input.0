From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [PATCH v4 3/3] Input: ALPS - Clean up code for SS5 hardware
Date: Tue, 8 Nov 2016 10:46:42 -0500
Message-ID: <20161108154642.GQ2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161108151621.GO2927@TopQuark.net>
 <20161108151710.GP2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:37137 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbcKHPqq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 10:46:46 -0500
Content-Disposition: inline
In-Reply-To: <20161108151710.GP2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>

On Tue, Nov 08, 2016 at 10:17:10AM -0500, Paul Donohue wrote:
> +#define SS4_TS_X_V2(_b)		(((_b[0] & 0x01) << 7) |	\
> +				 ((_b[1]) & 0x7F)		\
> +				)
> +
> +#define SS4_TS_Y_V2(_b)		-(((_b[3] & 0x01) << 7) |	\
> +				  ((_b[2]) & 0x7F)		\
> +				 )
> +
> +#define SS4_TS_Z_V2(_b)		(_b[4] & 0x7F)

This isn't working quite right.  I'm going to try this patch again.
