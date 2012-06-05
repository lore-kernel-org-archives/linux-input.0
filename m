From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v2 5/9] Input: tegra-kbc - add clk_prepare/clk_unprepare
Date: Tue, 05 Jun 2012 10:50:14 +0530
Message-ID: <4FCD970E.7080301@ti.com>
References: <1338869966-8430-1-git-send-email-pgaikwad@nvidia.com> <1338869966-8430-6-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45314 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755815Ab2FEFUV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jun 2012 01:20:21 -0400
Received: by obbuo13 with SMTP id uo13so9590040obb.29
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 22:20:19 -0700 (PDT)
In-Reply-To: <1338869966-8430-6-git-send-email-pgaikwad@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Tuesday 05 June 2012 09:49 AM, Prashant Gaikwad wrote:
> Use clk_prepare/clk_unprepare as required by the generic clk framework.
Not a comment just curious to know what does

clk_prepare/clk_unprepare do differently vis a vis enable.

> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---

