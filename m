From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: hgpk - Extend jumpyness detection
Date: Mon, 4 Oct 2010 10:39:00 -0700
Message-ID: <20101004173900.GB8321@core.coreip.homeip.net>
References: <20101002204243.EFD039D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50735 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0JDRjL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 13:39:11 -0400
Received: by pzk34 with SMTP id 34so1398760pzk.19
        for <linux-input@vger.kernel.org>; Mon, 04 Oct 2010 10:39:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002204243.EFD039D401B@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org

Hi Daniel,

On Sat, Oct 02, 2010 at 09:42:43PM +0100, Daniel Drake wrote:
>  
> -static int recalib_delta = 100;
> -module_param(recalib_delta, int, 0644);
> -MODULE_PARM_DESC(recalib_delta,
> -	"packets containing a delta this large will cause a recalibration.");
> +static int discard_threshold = 60;
> +module_param(discard_threshold, int, 0644);
> +MODULE_PARM_DESC(discard_threshold,
> +	"packets with a delta this large will be discarded, "
> +	"and a recalibration may be scheduled.");
>  

Do we need to gratuitously rename module parameter? I'd leave the name
as is and just adjust the description to match the extended usage.

Thanks.

-- 
Dmitry
