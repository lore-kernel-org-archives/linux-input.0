From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] Input: spear-keyboard: add device tree bindings
Date: Mon, 26 Mar 2012 09:30:23 -0600
Message-ID: <4F708B8F.10602@wwwdotorg.org>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com> <a2d16bc563cf5c7e8eebf817de0a1eb08d7b96ba.1332754641.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36345 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445Ab2CZPa0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 11:30:26 -0400
In-Reply-To: <a2d16bc563cf5c7e8eebf817de0a1eb08d7b96ba.1332754641.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, rajeev-dlh.kumar@st.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org

On 03/26/2012 03:45 AM, Viresh Kumar wrote:
> This adds simple DT bindings for spear-keyboard controller.
...
> diff --git a/Documentation/devicetree/bindings/input/spear-keyboard.txt b/Documentation/devicetree/bindings/input/spear-keyboard.txt
...
> +Required properties:
> +- compatible: "st,spear-kbd"

Should "spear" include some version number so that there's a clear path
if/when future SoCs need a different binding?

> +Optional properties, in addition to those specified by the shared
> +matrix-keyboard bindings:
> +- autorepeat: bool: enables key autorepeat
> +- mode: keyboard mode: 0 - 9x9, 1 - 6x6, 2 - 2x2

mode at least should be "st,mode". autorepeat is probably generic enough
that it doesn't need the vendor prefix.
