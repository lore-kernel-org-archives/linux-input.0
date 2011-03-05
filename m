From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4 v3] input - wacom: Support 2FGT in MT format
Date: Sat, 5 Mar 2011 09:46:17 +0100
Message-ID: <20110305084617.GA9918@polaris.bitmath.org>
References: <1299025142-8626-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:56045 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab1CEIoT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Mar 2011 03:44:19 -0500
Content-Disposition: inline
In-Reply-To: <1299025142-8626-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Tue, Mar 01, 2011 at 04:19:02PM -0800, Ping Cheng wrote:
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v3: Use contact_with_no_pen_down_count instead of individual touch
> state to decide touch_down status.
> ---
>  drivers/input/tablet/wacom_sys.c |   12 ++++----
>  drivers/input/tablet/wacom_wac.c |   59 ++++++++++++++++++++++++++++++--------
>  2 files changed, 53 insertions(+), 18 deletions(-)

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
