From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] Input: wm97xx-core - add retries to
	wm97xx_read_aux_adc
Date: Fri, 3 Sep 2010 14:25:09 +0100
Message-ID: <20100903132509.GD8381@sirena.org.uk>
References: <1283519614-14963-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56630 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0ICNZL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 09:25:11 -0400
Content-Disposition: inline
In-Reply-To: <1283519614-14963-1-git-send-email-emillbrandt@dekaresearch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-input@vger.kernel.org

On Fri, Sep 03, 2010 at 09:13:34AM -0400, Eric Millbrandt wrote:
> Add logic to wm97xx_read_aux_adc() to retry reading the adc if the
> sample failed.  This could occur if the previous sample was still in
> the return register or the sample timed-out.  Also avoid a pathologic
> failure mode by disabling the digitizer and returning -EBUSY after 5
> retries.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

Good stuff - thanks!

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
