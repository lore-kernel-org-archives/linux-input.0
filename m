From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: add lps001wp_prs driver
Date: Mon, 29 Nov 2010 22:09:26 -0800
Message-ID: <20101130060926.GA31838@core.coreip.homeip.net>
References: <matteo.dameno@st.com>
 <1291049009-32597-1-git-send-email-matteo.dameno@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50020 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab0K3GJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 01:09:34 -0500
Content-Disposition: inline
In-Reply-To: <1291049009-32597-1-git-send-email-matteo.dameno@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mems applications <mems.applications@st.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, matteo.dameno@st.com, carmine.iascone@st.com, mems <mems@mems-laptopT43.corenet.prv>

Hi,

On Mon, Nov 29, 2010 at 05:43:29PM +0100, mems applications wrote:
> +config INPUT_LPS001WP_PRS
> +	tristate "STMicro LPS001WP Pressure Temperature Sensor"
> +	depends on I2C
> +	default n
> +	help
> +	 If you say yes here you get support for the 
> +	 STM LPS001D Barometer/Termometer on I2C bus.

This does not belong to input subsystem, IIO is a better fit.

Thanks.

-- 
Dmitry
