From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH v3] Input: keyboard - add device tree bindings for
 simple key matrixes
Date: Tue, 3 Jan 2012 09:46:42 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F10DC@HQMAIL01.nvidia.com>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6659 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab2ACRq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2012 12:46:59 -0500
In-Reply-To: <1325484557-27695-1-git-send-email-olof@lixom.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>, "sjg@chromium.org" <sjg@chromium.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Olof Johansson wrote at Sunday, January 01, 2012 11:09 PM:
> This adds a simple device tree binding for simple key matrix data and
> a helper to fill in the platform data.
> 
> The implementation is in a shared file outside if drivers/input/keyboard
> since some drivers in drivers/input/misc might be making use of it
> as well.
> 
> Changes since v2:
>  * Removed reference to "legacy" format with a subnode per key
>  * Changed to a packed format with one cell per key instead of 3.
>  * Moved new OF helper to separate file
>  * Misc fixups based on comments
> 
> Changes since v1:
>  * Removed samsung-style binding support
>  * Added linux,fn-keymap and linux,fn-key optional properties
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

The new binding looks good to me. I assume the FIXME in the code was
deliberate.

-- 
nvpublic

