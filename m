From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2 v2] Input: synaptics - print firmware ID and board
 number at init
Date: Wed, 4 Jul 2012 14:56:59 +0200
Message-ID: <20120704125659.GA261@polaris.bitmath.org>
References: <1341392837-19115-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:58158 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2GDM4h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 08:56:37 -0400
Content-Disposition: inline
In-Reply-To: <1341392837-19115-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 04, 2012 at 05:07:16PM +0800, Daniel Kurtz wrote:
> Read the Firmware ID and Board Number from a synaptics device at init
> and display them in the system log.
> 
> Device behavior is very board and firmware dependent.
> It may prove useful for users to include this information when providing
> bug reports or other feedback.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/input/mouse/synaptics.c |   38 ++++++++++++++++++++++++++++++++++++--
>  drivers/input/mouse/synaptics.h |    3 +++
>  2 files changed, 39 insertions(+), 2 deletions(-)

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
