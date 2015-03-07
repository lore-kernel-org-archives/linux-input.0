From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: goodix: Add device tree support
Date: Fri, 6 Mar 2015 16:47:54 -0800
Message-ID: <20150307004754.GC26151@dtor-ws>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
 <1425576761-25208-1-git-send-email-mamlinav@gmail.com>
 <1425644625.11984.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:40135 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbCGAr7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 19:47:59 -0500
Content-Disposition: inline
In-Reply-To: <1425644625.11984.11.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Fri, Mar 06, 2015 at 01:23:45PM +0100, Bastien Nocera wrote:
> On Thu, 2015-03-05 at 20:32 +0300, Aleksei Mamlin wrote:
> > This patch adds device tree support and binding information for 
> > Goodix GT9xx series touchscreen controller.
> > It also adds support for 5-finger chips, like GT911 and GT912, which 
> > can be found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
> > 
> > Changes since v2:
> > * Split to two patches:
> >   The first one for use max number of touches from device config.
> >   The second one adds device tree support.
> > 
> > Changes since v1:
> > * Merge patches into single patch.
> > * Use max touch number from config instead of hardcoding.
> > * Update description in Kconfig.
> > 
> > Datasheets can be found here:
> > https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing
> > 
> > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> 
> Reviewed-by: Bastien Nocera <hadess@hadess.net>

Applied, thank you.

-- 
Dmitry
