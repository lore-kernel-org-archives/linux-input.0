From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Fri, 8 Feb 2008 11:27:09 +0000
Message-ID: <20080208112709.GA12028@rakim.wolfsonmicro.main>
References: <20080126151820.GA13899@sirena.org.uk> <1201368516-3513-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080207170112.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964927AbYBHL1Y@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080207170112.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 07, 2008 at 05:07:23PM -0500, Dmitry Torokhov wrote:

> The probe error handling is not quite correct. When we reach the fragment
> above ret variable is 0 so if platfrom_device_alloc() fails we will return
> 0 and the device will be considered bound but in half-dead state. Please
> make sure that proper error is returned in all cases. Also please do not
> mix out of line and in-line error unwinding (input_free_device() should
> be called in the error path and if you are concerned about double-free
> after input_unregister_device() just set wm->input_dev to NULL there).

Thanks for the review, I've implemented these changes and will resubmit
as a followup to this e-mail, also including a change from Dmitry
Baryshkov to make the devices unnumbered.
