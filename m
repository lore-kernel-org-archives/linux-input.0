From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 3/4] Input: cyttsp - switch to using device properties
Date: Fri, 22 Jan 2016 16:37:17 -0600
Message-ID: <20160122223717.GA23569@rob-hp-laptop>
References: <cover.1453414661.git.oreste.salerno@tomtom.com>
 <cbb77531529b8941a6a9a7a191e91c6629506a71.1453414661.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59678 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540AbcAVWhV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 17:37:21 -0500
Content-Disposition: inline
In-Reply-To: <cbb77531529b8941a6a9a7a191e91c6629506a71.1453414661.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oreste Salerno <oreste.salerno@tomtom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On Thu, Jan 21, 2016 at 11:21:31PM +0100, Oreste Salerno wrote:
> Drop support for platform data passed via a C-structure and switch to
> device properties instead, which should make the driver compatible
> with all platforms: OF, ACPI and static boards. Static boards should
> use property sets to communicate device parameters to the driver.
> 
> Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
> ---
>  .../bindings/input/touchscreen/cyttsp.txt          |  95 ++++++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/cyttsp_core.c            | 136 ++++++++++++++-------
>  drivers/input/touchscreen/cyttsp_core.h            |   9 +-
>  include/linux/input/cyttsp.h                       |  15 ---
>  4 files changed, 197 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
