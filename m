From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v11 0/8] Goodix touchscreen enhancements
Date: Thu, 17 Dec 2015 17:13:18 -0800
Message-ID: <20151218011318.GB16016@dtor-ws>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34370 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbLRBNV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 20:13:21 -0500
Content-Disposition: inline
In-Reply-To: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Nov 19, 2015 at 02:26:33PM +0200, Irina Tirdea wrote:
> This patchset depends on Dmitry's patch that fixes the
> GPIO ACPI API[1], so devm_gpiod_get_optional can be properly
> used in the code. 
> 
> [1] https://lkml.org/lkml/2015/11/11/465

Applied 1 through 5 (see my goodix branch), looking at the rest.

-- 
Dmitry
