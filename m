From: Alan Cox <alan@linux.intel.com>
Subject: Re: [patch] input: cy8ctmg100_ts: signedness bug
Date: Fri, 6 Aug 2010 12:20:58 +0100
Message-ID: <20100806122058.67945233@linux.intel.com>
References: <20100806063006.GM9031@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42862 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740Ab0HFL5F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Aug 2010 07:57:05 -0400
In-Reply-To: <20100806063006.GM9031@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 6 Aug 2010 08:30:06 +0200
Dan Carpenter <error27@gmail.com> wrote:

> "ret" should be signed here or the error handling doesn't work.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

Well spotted
