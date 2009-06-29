From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PCAP misc input driver (for 2.6.32)
Date: Mon, 29 Jun 2009 10:46:59 +0100
Message-ID: <20090629094658.GE11855@sirena.org.uk>
References: <1246122592.3727.20.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:47895 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZF2Jq4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 05:46:56 -0400
Content-Disposition: inline
In-Reply-To: <1246122592.3727.20.camel@brutus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, inux-kernel <linux-kernel@vger.kernel.org>, openezx-devel <openezx-devel@lists.openezx.org>, Samuel Ortiz <sameo@linux.intel.com>, Ilya Petrov <ilya.muromec@gmail.com>

On Sat, Jun 27, 2009 at 02:09:52PM -0300, Daniel Ribeiro wrote:
> This is a driver for misc input events for the PCAP2 PMIC, it handles
> the power button, headphone insertion/removal and the headphone button.

Depending on the power management capabilities of the CODEC it may be
better to support at laest the headphone insert/removal via the audio
driver as a jack to allow automatic management of the power for the
relevant paths within the CODEC.
