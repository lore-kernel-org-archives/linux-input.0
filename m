From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] input: goodix: Add device tree support
Date: Fri, 06 Mar 2015 13:23:45 +0100
Message-ID: <1425644625.11984.11.camel@hadess.net>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	 <1425576761-25208-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44628 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbCFMXx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 07:23:53 -0500
In-Reply-To: <1425576761-25208-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Thu, 2015-03-05 at 20:32 +0300, Aleksei Mamlin wrote:
> This patch adds device tree support and binding information for 
> Goodix GT9xx series touchscreen controller.
> It also adds support for 5-finger chips, like GT911 and GT912, which 
> can be found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
> 
> Changes since v2:
> * Split to two patches:
>   The first one for use max number of touches from device config.
>   The second one adds device tree support.
> 
> Changes since v1:
> * Merge patches into single patch.
> * Use max touch number from config instead of hardcoding.
> * Update description in Kconfig.
> 
> Datasheets can be found here:
> https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>
